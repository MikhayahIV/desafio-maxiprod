# 🏠 Sistema de Controle de Gastos Residenciais

<p align="center">

![.NET](https://img.shields.io/badge/.NET%208-512BD4?style=for-the-badge&logo=dotnet&logoColor=white)
![C#](https://img.shields.io/badge/C%23-239120?style=for-the-badge&logo=c-sharp&logoColor=white)
![Entity Framework Core](https://img.shields.io/badge/Entity_Framework_Core-6C3483?style=for-the-badge)
![React](https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB)
![TypeScript](https://img.shields.io/badge/TypeScript-3178C6?style=for-the-badge&logo=typescript&logoColor=white)
![Axios](https://img.shields.io/badge/Axios-5A29E4?style=for-the-badge)
![SQLite](https://img.shields.io/badge/SQLite-003B57?style=for-the-badge&logo=sqlite&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)

</p>

Sistema Full Stack desenvolvido como solução para um desafio técnico de gerenciamento financeiro compartilhado entre moradores de uma residência. A aplicação permite cadastrar pessoas, registrar receitas e despesas, aplicar regras de negócio e visualizar um relatório consolidado com os saldos individuais e o balanço geral da residência.

---

## 📑 Índice

- [Visão Geral](#-visão-geral)
- [Tecnologias Utilizadas](#-tecnologias-utilizadas)
- [Arquitetura e Boas Práticas](#-arquitetura-e-boas-práticas)
- [Funcionalidades](#-funcionalidades)
- [Destaques Técnicos](#-destaques-técnicos)
- [Como Executar o Projeto](#-como-executar-o-projeto)
- [Fluxo da Aplicação](#-fluxo-da-aplicação)
- [Conceitos Demonstrados](#-conceitos-demonstrados)
- [Estrutura do Projeto](#-estrutura-do-projeto)
- [Licença](#-licença)

---

# 📖 Visão Geral

O sistema foi desenvolvido utilizando uma arquitetura organizada em camadas, separando responsabilidades entre API, regras de negócio e interface.

A aplicação permite:

- Cadastro de moradores;
- Registro de receitas e despesas;
- Aplicação de regras de negócio;
- Persistência em banco de dados;
- Geração automática do relatório financeiro consolidado.

---

# 🚀 Tecnologias Utilizadas

## Back-end

- .NET 8
- ASP.NET Core Web API
- C#
- Entity Framework Core
- SQLite / PostgreSQL

## Front-end

- React
- TypeScript
- Axios
- Lucide React
- Tailwind CSS

---

# 🏛️ Arquitetura e Boas Práticas

A aplicação foi construída seguindo princípios de organização, legibilidade e separação de responsabilidades.

## ✔️ Separação de Camadas

O projeto é dividido em:

- Controllers
- Models
- DTOs
- DbContext

Essa estrutura facilita manutenção, evolução do sistema e reutilização de código.

---

## ✔️ DTOs (Data Transfer Objects)

Os DTOs foram utilizados para:

- Evitar exposição das entidades do banco;
- Estruturar as respostas da API;
- Gerar o relatório consolidado;
- Reduzir acoplamento entre camadas.

---

## ✔️ Persistência

Toda a aplicação utiliza Entity Framework Core com banco relacional.

Os dados permanecem armazenados mesmo após o encerramento da aplicação.

---

## ✔️ Comunicação Front-end ↔ Back-end

Foi configurada uma política de CORS permitindo a comunicação segura entre a API ASP.NET Core e a aplicação React.

---

## ✔️ Validação em Duas Camadas

A principal regra de negócio foi implementada tanto no Front-end quanto no Back-end.

### Regra

> Pessoas menores de 18 anos não podem cadastrar Receitas.

Essa validação ocorre:

- No Front-end, melhorando a experiência do usuário;
- No Back-end, impedindo requisições inválidas via Swagger, Postman ou qualquer outro cliente HTTP.

Essa abordagem garante integridade e segurança dos dados.

---

# ✨ Funcionalidades

- ✅ Cadastro de moradores
- ✅ Listagem de moradores
- ✅ Exclusão de moradores
- ✅ Exclusão em cascata das transações
- ✅ Cadastro de receitas
- ✅ Cadastro de despesas
- ✅ Validação automática da idade
- ✅ Relatório financeiro consolidado
- ✅ Cálculo do saldo individual
- ✅ Cálculo do saldo líquido da residência

---

# 💡 Destaques Técnicos

## 🔥 Deleção em Cascata

Ao remover um morador, todas as transações associadas são excluídas automaticamente através do relacionamento configurado no Entity Framework Core.

Essa implementação atende integralmente ao requisito do desafio.

---

## 🔥 Tipagem Forte

O Front-end foi desenvolvido utilizando TypeScript.

As interfaces refletem exatamente os DTOs retornados pela API, garantindo:

- Maior segurança;
- Melhor experiência de desenvolvimento;
- Redução de erros de tipagem.

---

## 🔥 Persistência

Toda a aplicação utiliza banco de dados relacional, garantindo que nenhuma informação seja perdida após reiniciar a API.

---

## 🔥 Organização

O código foi estruturado visando:

- Legibilidade;
- Facilidade de manutenção;
- Separação de responsabilidades;
- Escalabilidade.

---

# 🛠️ Como Executar o Projeto

## Pré-requisitos

- .NET SDK 8+
- Node.js
- npm

---

## Executando o Back-end

Entre na pasta da API:

```bash
cd backend
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

## Executando o Front-end

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

Acesse:

```
http://localhost:5173
```

---

# 📊 Fluxo da Aplicação

```text
Cadastro de Moradores
          │
          ▼
Registro de Receitas/Despesas
          │
          ▼
Validação das Regras de Negócio
          │
          ▼
Persistência no Banco de Dados
          │
          ▼
Geração do Relatório Consolidado
          │
          ▼
Visualização dos Saldos Individuais e Gerais
```

---

# 📋 Conceitos Demonstrados

- ✔️ Desenvolvimento de API REST
- ✔️ Entity Framework Core
- ✔️ Relacionamentos entre entidades
- ✔️ Exclusão em cascata
- ✔️ Persistência de dados
- ✔️ DTOs
- ✔️ Validação de regras de negócio
- ✔️ React + TypeScript
- ✔️ Consumo de API com Axios
- ✔️ Comunicação Front-end ↔ Back-end
- ✔️ Organização em camadas
- ✔️ Tipagem forte
- ✔️ Interface responsiva

---

# 📂 Estrutura do Projeto

```text
📦 Projeto
├── backend
│   ├── Controllers
│   ├── DTOs
│   ├── Models
│   ├── Data
│   └── Program.cs
│
└── frontend
    ├── components
    ├── services
    ├── types
    ├── App.tsx
    └── main.tsx
```

---

# 📄 Licença

Este projeto foi desenvolvido exclusivamente para fins de estudo, prática e avaliação técnica.
