import { useEffect, useState } from 'react';
import api from './services/api';
import type { Pessoa, RelatorioGeralDto, TipoTransacao } from './types';
import { UserPlus, DollarSign, BarChart3, Trash2, ShieldAlert } from 'lucide-react';

function App() {
  const [relatorio, setRelatorio] = useState<RelatorioGeralDto | null>(null);
  const [pessoas, setPessoas] = useState<Pessoa[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  const [erro, setErro] = useState<string | null>(null);

  const [nomePessoa, setNomePessoa] = useState('');
  const [idadePessoa, setIdadePessoa] = useState('');

  const [descricaoTransacao, setDescricaoTransacao] = useState('');
  const [valorTransacao, setValorTransacao] = useState('');
  const [tipoTransacao, setTipoTransacao] = useState<TipoTransacao>('Despesa');
  const [pessoaSelecionada, setPessoaSelecionada] = useState('');

  const carregarDados = async () => {
    try {
      setLoading(true);
      setErro(null);

      const [resRelatorio, resPessoas] = await Promise.all([
        api.get<RelatorioGeralDto>('/api/Gastos/relatorio'),
        api.get<Pessoa[]>('/api/Gastos/pessoas')
      ]);

      setRelatorio(resRelatorio.data);
      setPessoas(resPessoas.data);
    } catch (err: any) {
      console.error(err);
      setErro('Erro ao ligar à API do Back-end. Certifique-se de que o .NET está a correr!');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    carregarDados();
  }, []);

  const handleCadastrarPessoa = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!nomePessoa || !idadePessoa) return;

    try {
      const novaPessoa: Pessoa = {
        name: nomePessoa,
        age: Number(idadePessoa)
      };

      await api.post('/api/Gastos/pessoas', novaPessoa);
      setNomePessoa('');
      setIdadePessoa('');
      carregarDados();
    } catch (err: any) {
      alert(err.response?.data || 'Erro ao cadastrar pessoa.');
    }
  };

  const handleCadastrarTransacao = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!descricaoTransacao || !valorTransacao || !pessoaSelecionada) {
      alert('Preencha todos os campos da transação.');
      return;
    }

    const pessoaObj = pessoas.find(p => p.id === pessoaSelecionada);
    if (pessoaObj && pessoaObj.age < 18 && tipoTransacao === 'Receita') {
      alert('Regra de Negócio: Menores de idade não podem registar Receita!');
      return;
    }

    try {
      const tipoEnum = tipoTransacao === 'Receita' ? 1 : 0 ;

      const novaTransacao = {
        Description: descricaoTransacao,
        Valor: Number(valorTransacao),
        Tipo: tipoEnum,
        PessoaId: pessoaSelecionada
      };

      await api.post('/api/Gastos/transacoes', novaTransacao);
      setDescricaoTransacao('');
      setValorTransacao('');
      carregarDados(); 
    } catch (err: any) {
      console.error("Erro completo da API:", err.response?.data);
      if (err.response?.data && typeof err.response.data === 'object') {
        alert(JSON.stringify(err.response.data));
      } else {
        alert(err.response?.data || 'Erro ao criar transação.');
      }
    }
  };

  const handleDeletarPessoa = async (id: string) => {
    if (!confirm('Tem a certeza que deseja eliminar esta pessoa e todas as suas transações?')) return;
    try {
      await api.delete(`/api/Gastos/pessoas/${id}`);
      carregarDados();
    } catch (err: any) {
      alert('Erro ao eliminar pessoa.');
    }
  };

  if (loading && !relatorio) {
    return <div style={{ padding: '40px', textAlign: 'center', fontFamily: 'sans-serif' }}>A carregar ecossistema e dados...</div>;
  }

  return (
    <div style={{ maxWidth: '1200px', margin: '0 auto', padding: '20px', fontFamily: 'sans-serif', color: '#333' }}>
      
      <header style={{ borderBottom: '2px solid #eee', paddingBottom: '10px', marginBottom: '30px' }}>
        <h1 style={{ margin: 0, color: '#1e3a8a' }}>🏠 Gestor de Gastos Residenciais</h1>
        <p style={{ color: '#666', margin: '5px 0 0 0' }}>Balanço financeiro partilhado e controlo de transações</p>
      </header>

      {erro && (
        <div style={{ backgroundColor: '#ffeeef', border: '1px solid #fda4af', padding: '15px', borderRadius: '6px', color: '#9f1239', marginBottom: '20px', display: 'flex', alignItems: 'center', gap: '10px' }}>
          <ShieldAlert size={20} />
          <span>{erro}</span>
        </div>
      )}

      <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '20px', marginBottom: '30px' }}>
        
        <div style={{ border: '1px solid #e2e8f0', borderRadius: '8px', padding: '20px', backgroundColor: '#f8fafc' }}>
          <h2 style={{ fontSize: '18px', margin: '0 0 15px 0', display: 'flex', alignItems: 'center', gap: '8px', color: '#1e40af' }}>
            <UserPlus size={20} /> Registar Pessoa
          </h2>
          <form onSubmit={handleCadastrarPessoa} style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
            <div>
              <label style={{ display: 'block', fontSize: '14px', marginBottom: '4px', fontWeight: 'bold' }}>Nome:</label>
              <input type="text" value={nomePessoa} onChange={e => setNomePessoa(e.target.value)} placeholder="Ex: Vitor Dias" style={{ width: '100%', padding: '8px', boxSizing: 'border-box', borderRadius: '4px', border: '1px solid #cbd5e1' }} required />
            </div>
            <div>
              <label style={{ display: 'block', fontSize: '14px', marginBottom: '4px', fontWeight: 'bold' }}>Idade:</label>
              <input type="number" value={idadePessoa} onChange={e => setIdadePessoa(e.target.value)} placeholder="Ex: 21" style={{ width: '100%', padding: '8px', boxSizing: 'border-box', borderRadius: '4px', border: '1px solid #cbd5e1' }} required />
            </div>
            <button type="submit" style={{ backgroundColor: '#2563eb', color: 'white', border: 'none', padding: '10px', borderRadius: '4px', cursor: 'pointer', fontWeight: 'bold', marginTop: '5px' }}>Adicionar Membro</button>
          </form>

          <h3 style={{ fontSize: '14px', margin: '20px 0 10px 0', color: '#475569' }}>Membros da Casa:</h3>
          <ul style={{ listStyle: 'none', padding: 0, margin: 0 }}>
            {pessoas.map(p => (
              <li key={p.id} style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '8px', borderBottom: '1px solid #e2e8f0', fontSize: '14px' }}>
                <span><strong>{p.name}</strong> ({p.age} anos)</span>
                <button onClick={() => p.id && handleDeletarPessoa(p.id)} style={{ background: 'none', border: 'none', color: '#dc2626', cursor: 'pointer', padding: '4px' }} title="Remover Pessoa">
                  <Trash2 size={16} />
                </button>
              </li>
            ))}
            {pessoas.length === 0 && <li style={{ color: '#94a3b8', fontSize: '14px', fontStyle: 'italic' }}>Nenhuma pessoa registada.</li>}
          </ul>
        </div>

        <div style={{ border: '1px solid #e2e8f0', borderRadius: '8px', padding: '20px', backgroundColor: '#f8fafc' }}>
          <h2 style={{ fontSize: '18px', margin: '0 0 15px 0', display: 'flex', alignItems: 'center', gap: '8px', color: '#0f766e' }}>
            <DollarSign size={20} /> Lançar Transação (Receita/Despesa)
          </h2>
          <form onSubmit={handleCadastrarTransacao} style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
            <div>
              <label style={{ display: 'block', fontSize: '14px', marginBottom: '4px', fontWeight: 'bold' }}>Quem efetuou?</label>
              <select value={pessoaSelecionada} onChange={e => setPessoaSelecionada(e.target.value)} style={{ width: '100%', padding: '8px', borderRadius: '4px', border: '1px solid #cbd5e1' }} required>
                <option value="">Selecione um membro...</option>
                {pessoas.map(p => (
                  <option key={p.id} value={p.id}>{p.name} ({p.age} anos)</option>
                ))}
              </select>
            </div>
            <div>
              <label style={{ display: 'block', fontSize: '14px', marginBottom: '4px', fontWeight: 'bold' }}>Descrição:</label>
              <input type="text" value={descricaoTransacao} onChange={e => setDescricaoTransacao(e.target.value)} placeholder="Ex: Aluguer, Compras do Mês, Salário" style={{ width: '100%', padding: '8px', boxSizing: 'border-box', borderRadius: '4px', border: '1px solid #cbd5e1' }} required />
            </div>
            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '10px' }}>
              <div>
                <label style={{ display: 'block', fontSize: '14px', marginBottom: '4px', fontWeight: 'bold' }}>Valor (€):</label>
                <input type="number" step="0.01" value={valorTransacao} onChange={e => setValorTransacao(e.target.value)} placeholder="0.00" style={{ width: '100%', padding: '8px', boxSizing: 'border-box', borderRadius: '4px', border: '1px solid #cbd5e1' }} required />
              </div>
              <div>
                <label style={{ display: 'block', fontSize: '14px', marginBottom: '4px', fontWeight: 'bold' }}>Tipo:</label>
                <select value={tipoTransacao} onChange={e => setTipoTransacao(e.target.value as TipoTransacao)} style={{ width: '100%', padding: '8px', borderRadius: '4px', border: '1px solid #cbd5e1' }}>
                  <option value="Despesa">Despesa 🔴</option>
                  <option value="Receita">Receita 🟢</option>
                </select>
              </div>
            </div>
            <button type="submit" style={{ backgroundColor: '#0d9488', color: 'white', border: 'none', padding: '10px', borderRadius: '4px', cursor: 'pointer', fontWeight: 'bold', marginTop: '5px' }}>Registar Movimentação</button>
          </form>
        </div>

      </div>

      <div style={{ border: '1px solid #e2e8f0', borderRadius: '8px', padding: '20px', backgroundColor: '#ffffff', boxShadow: '0 4px 6px -1px rgb(0 0 0 / 0.05)' }}>
        <h2 style={{ fontSize: '18px', margin: '0 0 15px 0', display: 'flex', alignItems: 'center', gap: '8px', color: '#1e293b' }}>
          <BarChart3 size={20} /> Relatório de Saldos Totais
        </h2>
        
        <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left', fontSize: '15px' }}>
          <thead>
            <tr style={{ backgroundColor: '#f1f5f9', borderBottom: '2px solid #cbd5e1' }}>
              <th style={{ padding: '12px' }}>Membro</th>
              <th style={{ padding: '12px', color: '#16a34a' }}>Total Receitas</th>
              <th style={{ padding: '12px', color: '#dc2626' }}>Total Despesas</th>
              <th style={{ padding: '12px' }}>Saldo Individual</th>
            </tr>
          </thead>
          <tbody>
            {relatorio?.pessoas.map(p => (
              <tr key={p.id} style={{ borderBottom: '1px solid #e2e8f0' }}>
                <td style={{ padding: '12px', fontWeight: '500' }}>{p.nome}</td>
                <td style={{ padding: '12px', color: '#16a34a' }}>+ {p.totalReceitas.toFixed(2)} €</td>
                <td style={{ padding: '12px', color: '#dc2626' }}>- {p.totalDespesas.toFixed(2)} €</td>
                <td style={{ padding: '12px', fontWeight: 'bold', color: p.saldo >= 0 ? '#15803d' : '#b91c1c' }}>
                  {p.saldo.toFixed(2)} €
                </td>
              </tr>
            ))}
            {(!relatorio || relatorio.pessoas.length === 0) && (
              <tr>
                <td colSpan={4} style={{ padding: '20px', textAlign: 'center', color: '#94a3b8' }}>Nenhum dado financeiro consolidado.</td>
              </tr>
            )}
          </tbody>
          {relatorio && relatorio.pessoas.length > 0 && (
            <tfoot>
              <tr style={{ backgroundColor: '#f8fafc', borderTop: '2px solid #cbd5e1', fontWeight: 'bold', fontSize: '16px' }}>
                <td style={{ padding: '16px' }}>TOTAL GERAL RESIDENCIAL</td>
                <td style={{ padding: '16px', color: '#16a34a' }}>+ {relatorio.totalGeralReceitas.toFixed(2)} €</td>
                <td style={{ padding: '16px', color: '#dc2626' }}>- {relatorio.totalGeralDespesas.toFixed(2)} €</td>
                <td style={{ padding: '16px', backgroundColor: relatorio.saldoLiquidoGeral >= 0 ? '#dcfce7' : '#fee2e2', color: relatorio.saldoLiquidoGeral >= 0 ? '#15803d' : '#b91c1c' }}>
                  {relatorio.saldoLiquidoGeral.toFixed(2)} €
                </td>
              </tr>
            </tfoot>
          )}
        </table>
      </div>

    </div>
  );
}

export default App;