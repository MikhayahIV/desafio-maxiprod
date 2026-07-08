namespace WebApplication1.DTOs
{
    public record PessoaTotalDto(
        Guid Id, 
        string Nome, 
        decimal TotalReceitas, 
        decimal TotalDespesas, 
        decimal Saldo
    );

    public record RelatorioGeralDto(
        List<PessoaTotalDto> Pessoas,
        decimal TotalGeralReceitas,
        decimal TotalGeralDespesas,
        decimal SaldoLiquidoGeral
    );
}