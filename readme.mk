# 🏠 Sistema de Controle de Gastos Residenciais

Sistema desenvolvido como solução para um desafio técnico de gerenciamento financeiro compartilhado entre moradores de uma residência. A aplicação permite cadastrar pessoas, registrar receitas e despesas, além de gerar um relatório consolidado com os saldos individuais e o balanço financeiro geral.

---

## 🚀 Tecnologias Utilizadas

### Back-end
- .NET 8
- C#
- ASP.NET Core Web API
- Entity Framework Core
- SQLite / PostgreSQL

### Front-end
- React
- TypeScript
- Axios
- Lucide React
- Tailwind CSS

---

## 🏛️ Arquitetura e Boas Práticas

O projeto foi estruturado priorizando organização, manutenção e separação de responsabilidades.

### Separação de Camadas
A aplicação está organizada em camadas distintas, separando:

- Models
- DTOs (Data Transfer Objects)
- Controllers

Essa abordagem evita o acoplamento entre as entidades do banco de dados e os objetos expostos pela API.

### Data Transfer Objects (DTOs)

Os DTOs foram utilizados para:

- Evitar exposição direta das entidades do banco;
- Estruturar respostas da API;
- Gerar o relatório consolidado da residência;
- Facilitar agregações de receitas, despesas e saldos.

### Persistência de Dados

Toda a aplicação utiliza banco de dados relacional através do Entity Framework Core, garantindo persistência completa das informações mesmo após o encerramento da aplicação.

### CORS

Foi configurada uma política de CORS para permitir a comunicação segura entre a API (.NET) e o Front-end React.

### Validação em Duas Camadas

A principal regra de negócio foi implementada tanto no Front-end quanto no Back-end.

**Regra:**

> Pessoas menores de 18 anos não podem cadastrar Receitas.

Essa validação foi aplicada:

- no Front-end, melhorando a experiência do usuário;
- no Back-end, impedindo requisições inválidas vindas de ferramentas externas como Swagger ou Postman.

Essa abordagem garante maior segurança e integridade dos dados.

---

## ✨ Funcionalidades

- ✅ Cadastro de moradores
- ✅ Listagem de moradores
- ✅ Exclusão de moradores
- ✅ Cadastro de receitas
- ✅ Cadastro de despesas
- ✅ Validação de idade para receitas
- ✅ Relatório financeiro consolidado
- ✅ Cálculo automático de saldo individual
- ✅ Cálculo do saldo líquido da residência

---

## 🔥 Destaques Técnicos

### Deleção em Cascata

Ao remover um morador, todas as transações vinculadas são excluídas automaticamente através do relacionamento configurado no Entity Framework Core.

Essa implementação atende integralmente ao requisito de exclusão em cascata.

### Tipagem Forte

O Front-end utiliza TypeScript com interfaces que refletem exatamente os DTOs retornados pela API, garantindo:

- maior segurança durante o desenvolvimento;
- redução de erros;
- melhor manutenção do código.

### Persistência

Como toda a aplicação utiliza banco de dados relacional, nenhuma informação é perdida ao reiniciar a API.

---

# 🛠️ Como Executar o Projeto

## Pré-requisitos

- .NET SDK 8+
- Node.js
- npm

---

## Executando o Back-end

Entre na pasta do projeto:

```bash
cd backend
```

Execute a API:

```bash
dotnet run
```

A aplicação ficará disponível em:

```
http://localhost:5281
```

Documentação Swagger:

```
http://localhost:5281/swagger/index.html
```

---

## Executando o Front-end

Entre na pasta:

```bash
cd frontend
```

Instale as dependências:

```bash
npm install
```

Inicie o servidor:

```bash
npm run dev
```

A aplicação ficará disponível em:

```
http://localhost:5173
```

---

# 📊 Fluxo da Aplicação

1. Cadastrar moradores
2. Registrar receitas e despesas
3. Aplicar validações de negócio
4. Armazenar dados no banco
5. Gerar relatório consolidado
6. Exibir saldos individuais e saldo geral

---

# 📋 Checklist Técnico

Este projeto demonstra diversos conceitos importantes de desenvolvimento Full Stack:

- ✅ API REST com ASP.NET Core
- ✅ Entity Framework Core
- ✅ Persistência de dados
- ✅ DTOs
- ✅ Relacionamentos entre entidades
- ✅ Exclusão em cascata
- ✅ Validação de regras de negócio
- ✅ React + TypeScript
- ✅ Consumo de API com Axios
- ✅ Organização em camadas
- ✅ Comunicação Front-end ↔ Back-end
- ✅ Tipagem forte
- ✅ Interface responsiva

---

# 💡 Observações

Durante uma avaliação técnica, alguns pontos que se destacam são:

- Organização do projeto em camadas;
- Uso correto de DTOs;
- Validação de regras de negócio tanto no cliente quanto no servidor;
- Persistência utilizando banco relacional;
- Relacionamentos corretamente configurados no Entity Framework;
- Tipagem forte utilizando TypeScript;
- Interface simples, limpa e funcional.

---

# 📄 Licença

Projeto desenvolvido para fins de estudo e avaliação técnica.