using System.ComponentModel.DataAnnotations;

namespace WebApplication1.models
{
    
    public class Pessoa
    {
        [Key]
        public Guid Id {get;set;} = Guid.NewGuid();

        [Required]
        public string Name {get;set;} = string.Empty;

        [Required]
        public int Age {get;set;} 

        public ICollection<Transacao> Transacoes {get; set;} = new List<Transacao>();
    }
}