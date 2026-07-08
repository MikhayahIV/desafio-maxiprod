# 🏠 Sistema de Controle de Gastos Residenciais

<p align="center">
  <strong>Sistema Full Stack desenvolvido em .NET 8 e React para gerenciamento financeiro compartilhado entre moradores de uma residência.</strong>
</p>

<p align="center">

![.NET](https://img.shields.io/badge/.NET%208-512BD4?style=for-the-badge&logo=dotnet&logoColor=white)
![C#](https://img.shields.io/badge/C%23-239120?style=for-the-badge&logo=c-sharp&logoColor=white)
![ASP.NET Core](https://img.shields.io/badge/ASP.NET_Core-512BD4?style=for-the-badge&logo=dotnet&logoColor=white)
![Entity Framework Core](https://img.shields.io/badge/Entity_Framework_Core-68217A?style=for-the-badge)
![React](https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB)
![TypeScript](https://img.shields.io/badge/TypeScript-3178C6?style=for-the-badge&logo=typescript&logoColor=white)
![Tailwind CSS](https://img.shields.io/badge/Tailwind_CSS-38B2AC?style=for-the-badge&logo=tailwind-css&logoColor=white)
![Axios](https://img.shields.io/badge/Axios-5A29E4?style=for-the-badge)
![SQLite](https://img.shields.io/badge/SQLite-003B57?style=for-the-badge&logo=sqlite&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)

</p>

---

## 📖 Sobre o Projeto

Este projeto foi desenvolvido como solução para um desafio técnico de gerenciamento financeiro compartilhado.

A aplicação permite que moradores de uma residência registrem receitas e despesas individuais, aplicando regras de negócio durante os lançamentos e apresentando um relatório financeiro consolidado contendo os saldos individuais e o saldo geral da residência.

O foco do projeto foi desenvolver uma aplicação organizada, escalável e de fácil manutenção, utilizando boas práticas de arquitetura e desenvolvimento Full Stack.

---

# ✨ Funcionalidades

- ✅ Cadastro de moradores
- ✅ Listagem de moradores
- ✅ Exclusão de moradores
- ✅ Exclusão em cascata das transações
- ✅ Cadastro de receitas
- ✅ Cadastro de despesas
- ✅ Validação automática das regras de negócio
- ✅ Relatório financeiro consolidado
- ✅ Cálculo automático de receitas
- ✅ Cálculo automático de despesas
- ✅ Saldo individual por morador
- ✅ Saldo líquido da residência
- ✅ Persistência em banco de dados

---

# 🚀 Tecnologias Utilizadas

## Back-end

- .NET 8
- ASP.NET Core Web API
- C#
- Entity Framework Core
- SQLite
- PostgreSQL

## Front-end

- React
- TypeScript
- Axios
- Lucide React
- Tailwind CSS

---

# 🏛 Arquitetura

A aplicação foi construída seguindo uma arquitetura em camadas para facilitar manutenção, evolução e reutilização de código.

```
Frontend (React)
        │
        ▼
ASP.NET Core Web API
        │
        ▼
Controllers
        │
        ▼
DTOs
        │
        ▼
Models
        │
        ▼
Entity Framework Core
        │
        ▼
SQLite / PostgreSQL
```

---

# 📂 Estrutura do Projeto

```
📦 Projeto
│
├── backend
│   ├── Controllers
│   ├── DTOs
│   ├── Models
│   ├── Data
│   ├── Migrations
│   └── Program.cs
│
└── frontend
    ├── src
    │   ├── components
    │   ├── services
    │   ├── types
    │   ├── App.tsx
    │   └── main.tsx
    └── package.json
```

---

# 🧠 Boas Práticas Aplicadas

## ✔️ Separação de Camadas

O projeto foi organizado separando:

- Controllers
- Models
- DTOs
- Persistência

Essa organização reduz o acoplamento e facilita a manutenção do código.

---

## ✔️ DTOs

Os Data Transfer Objects foram utilizados para:

- Evitar exposição das entidades;
- Estruturar respostas da API;
- Gerar o relatório consolidado;
- Reduzir acoplamento entre camadas.

---

## ✔️ Entity Framework Core

O Entity Framework Core é responsável por:

- Persistência dos dados;
- Relacionamentos entre entidades;
- Exclusão em cascata;
- Migrações do banco de dados.

---

## ✔️ Persistência

Todas as informações ficam armazenadas no banco de dados.

Ao reiniciar a aplicação, nenhum dado é perdido.

---

## ✔️ Comunicação Front-end ↔ Back-end

A integração entre React e ASP.NET Core é realizada através de requisições HTTP utilizando Axios.

Foi configurada uma política de CORS permitindo a comunicação segura entre ambas as aplicações.

---

## ✔️ Validação em Duas Camadas

Uma das principais regras do sistema é:

> Pessoas menores de 18 anos não podem cadastrar receitas.

Essa regra foi implementada em duas camadas:

### Front-end

A interface impede que o usuário realize a operação, melhorando a experiência de uso.

### Back-end

A API valida novamente a regra, impedindo requisições inválidas enviadas via Swagger, Postman ou qualquer outro cliente HTTP.

Essa abordagem garante integridade dos dados.

---

# 🔥 Destaques Técnicos

### Exclusão em Cascata

Ao remover um morador, todas as transações vinculadas são removidas automaticamente através do relacionamento configurado no Entity Framework Core.

---

### Tipagem Forte

O Front-end utiliza TypeScript com interfaces equivalentes aos DTOs da API, garantindo maior segurança durante o desenvolvimento.

---

### Arquitetura Organizada

A separação entre Controllers, DTOs e Models torna a aplicação mais legível e preparada para futuras evoluções.

---

### Banco de Dados Relacional

Toda a persistência é realizada através do Entity Framework Core utilizando SQLite ou PostgreSQL.

---

# 📊 Fluxo da Aplicação

```
Cadastro de Moradores
          │
          ▼
Registro de Receitas e Despesas
          │
          ▼
Validação das Regras de Negócio
          │
          ▼
Persistência no Banco
          │
          ▼
Relatório Financeiro
          │
          ▼
Saldo Individual
          │
          ▼
Saldo Geral da Residência
```

---

# 🛠 Como Executar

## Pré-requisitos

- .NET SDK 8+
- Node.js
- npm

---

## Back-end

Entre na pasta da API:

```bash
cd backend
```

Restaure os pacotes:

```bash
dotnet restore
```

Execute:

```bash
dotnet run
```

A API ficará disponível em:

```
http://localhost:5281
```

Swagger:

```
http://localhost:5281/swagger/index.html
```

---

## Front-end

Entre na pasta:

```bash
cd frontend
```

Instale as dependências:

```bash
npm install
```

Execute:

```bash
npm run dev
```

Abra:

```
http://localhost:5173
```

---

# 📚 Conceitos Demonstrados

- Desenvolvimento de APIs REST
- ASP.NET Core
- Entity Framework Core
- React
- TypeScript
- Axios
- DTOs
- Persistência de Dados
- Relacionamentos entre Entidades
- Exclusão em Cascata
- Validação de Regras de Negócio
- Comunicação Front-end ↔ Back-end
- Organização em Camadas
- Tipagem Forte
- Interface Responsiva

---

# 🎯 Próximas Melhorias

- Autenticação de usuários
- Dashboard com gráficos financeiros
- Filtros por período
- Exportação para PDF
- Exportação para Excel
- Paginação das consultas
- Testes automatizados
- Docker Compose
- Deploy em ambiente de produção

---

# 📄 Licença

Este projeto foi desenvolvido para fins de estudo e avaliação técnica.
