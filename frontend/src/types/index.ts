export interface Pessoa {
  id?: string; 
  name: string;
  age: number;
}

export type TipoTransacao = 'Receita' | 'Despesa';

export interface Transacao {
  id?: string;
  description: string;
  valor: number;
  tipo: TipoTransacao;
  pessoaId: string;
}

export interface PessoaTotalDto {
  id: string;
  nome: string;
  totalReceitas: number;
  totalDespesas: number;
  saldo: number;
}

export interface RelatorioGeralDto {
  pessoas: PessoaTotalDto[];
  totalGeralReceitas: number;
  totalGeralDespesas: number;
  saldoLiquidoGeral: number;
}