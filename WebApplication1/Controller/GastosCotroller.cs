using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.models;
using WebApplication1.DTOs;

namespace WebApplication1.Controller
{
    [ApiController]
    [Route("api/[controller]")]
    public class GastosController : ControllerBase
    {
        private readonly AppDbContext _context;

        public GastosController(AppDbContext context)
        {
            _context = context;
        }

        #region CADASTRO DE PESSOAS

        [HttpPost("pessoas")]
        public async Task<IActionResult> CriarPessoa([FromBody] Pessoa pessoa)
        {
            _context.Pessoas.Add(pessoa);
            await _context.SaveChangesAsync();
            return CreatedAtAction(nameof(ListarPessoas), new { id = pessoa.Id }, pessoa);
        }

        [HttpGet("pessoas")]
        public async Task<IActionResult> ListarPessoas()
        {
            var pessoas = await _context.Pessoas.ToListAsync();
            return Ok(pessoas);
        }

        [HttpDelete("pessoas/{id}")]
        public async Task<IActionResult> DeletarPessoa(Guid id)
        {
            var pessoa = await _context.Pessoas.FindAsync(id);
            if (pessoa == null) return NotFound("Pessoa não encontrada.");

            _context.Pessoas.Remove(pessoa);
            await _context.SaveChangesAsync();
            return NoContent();
        }

        #endregion

        #region CADASTRO DE TRANSAÇÕES

        [HttpPost("transacoes")]
        public async Task<IActionResult> CriarTransacao([FromBody] Transacao transacao)
        {
            var pessoa = await _context.Pessoas.FindAsync(transacao.PessoaId);
            if (pessoa == null)
            {
                return BadRequest("A pessoa informada para esta transação não existe.");
            }

            if (pessoa.Age < 18 && transacao.Tipo == TipoTransacao.RECEITA)
            {
                return BadRequest("Menores de 18 anos só podem registrar transações do tipo Despesa.");
            }

            _context.Transacoes.Add(transacao);
            await _context.SaveChangesAsync();
            return Ok(transacao);
        }

        [HttpGet("transacoes")]
        public async Task<IActionResult> ListarTransacoes()
        {
            var transacoes = await _context.Transacoes.ToListAsync();
            return Ok(transacoes);
        }

        #endregion

        #region CONSULTA DE TOTAIS

        [HttpGet("relatorio")]
        public async Task<ActionResult<RelatorioGeralDto>> ObterTotais()
        {
            var pessoasDoBanco = await _context.Pessoas
                .Include(p => p.Transacoes)
                .ToListAsync();

            var listaPessoasTotais = pessoasDoBanco.Select(p => {
                var receitas = p.Transacoes.Where(t => t.Tipo == TipoTransacao.RECEITA).Sum(t => t.Valor);
                var despesas = p.Transacoes.Where(t => t.Tipo == TipoTransacao.DESPESA).Sum(t => t.Valor);
                
                return new PessoaTotalDto(
                    p.Id, 
                    p.Name, 
                    receitas, 
                    despesas, 
                    receitas - despesas 
                );
            }).ToList();

            var totalGeralReceitas = listaPessoasTotais.Sum(p => p.TotalReceitas);
            var totalGeralDespesas = listaPessoasTotais.Sum(p => p.TotalDespesas);
            var saldoLiquidoGeral = totalGeralReceitas - totalGeralDespesas;

            var relatorio = new RelatorioGeralDto(
                listaPessoasTotais, 
                totalGeralReceitas, 
                totalGeralDespesas, 
                saldoLiquidoGeral
            );

            return Ok(relatorio);
        }

        #endregion
    }
}