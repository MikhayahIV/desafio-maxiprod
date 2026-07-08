using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication1.models
{
    public enum TipoTransacao
    {
        DESPESA,
        RECEITA
    }
    public class Transacao
    {
        [Key]
        public Guid Id { get; set; } = Guid.NewGuid();

        [Required]
        public string Description { get; set; } = string.Empty;

        [Required]
        public decimal Valor { get; set; }

        [Required]
        public TipoTransacao Tipo { get; set; }

        [Required]
        public Guid PessoaId { get; set; }

        [ForeignKey("PessoaId")]
        public Pessoa? Pessoa { get; set; }
    }
}