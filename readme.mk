
# 🏠 Sistema de Controle de Gastos Residenciais

<p align="center">
  <img src="https://img.shields.io/badge/.NET%208-512BD4?style=for-the-badge&logo=dotnet&logoColor=white" alt=".NET 8" />
  <img src="https://img.shields.io/badge/C%23-239120?style=for-the-badge&logo=c-sharp&logoColor=white" alt="C#" />
  <img src="https://img.shields.io/badge/Entity_Framework_Core-6C3483?style=for-the-badge" alt="EF Core" />
  <img src="https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB" alt="React" />
  <img src="https://img.shields.io/badge/TypeScript-3178C6?style=for-the-badge&logo=typescript&logoColor=white" alt="TypeScript" />
  <img src="https://img.shields.io/badge/Axios-5A29E4?style=for-the-badge" alt="Axios" />
  <img src="https://img.shields.io/badge/SQLite-003B57?style=for-the-badge&logo=sqlite&logoColor=white" alt="SQLite" />
  <img src="https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white" alt="PostgreSQL" />
</p>

Sistema Full Stack desenvolvido como solução para um desafio técnico de gerenciamento financeiro compartilhado entre moradores de uma residência. A aplicação permite cadastrar pessoas, registrar receitas e despesas, aplicar regras de negócio e visualizar um relatório consolidado com os saldos individuais e o balanço geral da residência.

---

## 📑 Índice

- [Visão Geral](#-visão-geral)
- [Tecnologias Utilizadas](#-tecnologias-utilizadas)
- [Arquitetura e Boas Práticas](#%EF%B8%8F-arquitetura-e-boas-práticas)
- [Funcionalidades](#-funcionalidades)
- [Destaques Técnicos](#-destaques-técnicos)
- [Como Executar o Projeto](#%EF%B8%8F-como-executar-o-projeto)
- [Fluxo da Aplicação](#-fluxo-da-aplicação)
- [Conceitos Demonstrados](#-conceitos-demonstrados)
- [Estrutura do Projeto](#-estrutura-do-projeto)
- [Licença](#-licença)

---

## 📖 Visão Geral

O sistema foi desenvolvido utilizando uma arquitetura organizada em camadas, separando responsabilidades entre API, regras de negócio e interface do usuário.

A aplicação permite:
- Cadastro e gerenciamento de moradores;
- Registro e classificação de receitas e despesas;
- Aplicação automatizada de regras de negócio;
- Persistência robusta em banco de dados relacional;
- Geração em tempo real do relatório financeiro consolidado da casa.

---

## 🚀 Tecnologias Utilizadas

### Back-end
- **Runtime:** .NET 8
- **Framework:** ASP.NET Core Web API
- **Linguagem:** C#
- **ORM:** Entity Framework Core
- **Banco de Dados:** SQLite / PostgreSQL

### Front-end
- **Biblioteca Base:** React
- **Linguagem:** TypeScript
- **Cliente HTTP:** Axios
- **Ícones:** Lucide React
- **Estilização:** Tailwind CSS

---

## 🏛️ Arquitetura e Boas Práticas

A aplicação foi construída seguindo princípios SOLID, focando em organização, legibilidade e manutenibilidade do ecossistema.

### ✔️ Separação de Camadas
O projeto isola de forma clara as suas responsabilidades em:
- **Controllers:** Exposição dos endpoints REST e controle de fluxo.
- **Models:** Definição das entidades de domínio e mapeamento de dados.
- **DTOs (Data Transfer Objects):** Estruturação customizada para transferência de dados sem expor entidades brutas do banco de dados.
- **Data/DbContext:** Configuração da persistência e mapeamentos do ORM.

### ✔️ DTOs (Data Transfer Objects)
Os DTOs foram peças-chave no desenvolvimento para:
- Evitar a exposição direta do modelo físico de dados;
- Formatar as respostas sob medida para o painel do Front-end;
- Consolidar as queries de relatório (agregação de receitas, despesas e saldos calculados).

### ✔️ Validação em Duas Camadas (Dual-Layer Validation)
A principal regra de negócio foi replicada simetricamente no cliente e no servidor.

> **Regra de Negócio:** Pessoas menores de 18 anos não podem cadastrar Receitas.

- **No Front-end:** Bloqueio preventivo na interface, aprimorando a experiência do usuário (UX).
- **No Back-end:** Validação estrita no controlador da API, blindando o banco de dados contra requisições inconsistentes via Swagger, Postman ou scripts externos.

---

## ✨ Funcionalidades

- ✅ Cadastro de moradores (Membros da residência)
- ✅ Listagem em tempo real de moradores
- ✅ Exclusão de moradores com integridade referencial
- ✅ Exclusão em cascata das transações vinculadas
- ✅ Cadastro e controle de receitas
- ✅ Cadastro e controle de despesas
- ✅ Validação automática de idade por tipo de movimentação
- ✅ Relatório financeiro consolidado automático
- ✅ Cálculo automático do saldo individual (Receitas - Despesas)
- ✅ Cálculo do saldo líquido residencial geral

---

## 💡 Destaques Técnicos

### 🔥 Deleção em Cascata (Cascade Delete)
Para cumprir estritamente o requisito de que a exclusão de um membro remova seu histórico financeiro, configuramos o relacionamento no Entity Framework Core para aplicar deleção em cascata automaticamente a nível de banco de dados.

### 🔥 Tipagem Forte de Ponta a Ponta
O Front-end em TypeScript consome contratos de tipos e interfaces que espelham perfeitamente os DTOs gerados pela API em C#, mitigando erros em tempo de desenvolvimento e garantindo refatorações seguras.

### 🔥 Comunicação Segura via CORS
Pipeline do ASP.NET Core configurado explicitamente com políticas de CORS restritas para permitir o consumo seguro de recursos pelo servidor de desenvolvimento do Vite/React.

---

## 🛠️ Como Executar o Projeto

### Pré-requisitos
- .NET SDK 8+
- Node.js (v18+)
- npm ou yarn

### Executando o Back-end

1. Entre na pasta da API:
```bash
cd backend
Execute o projeto:

Bash
dotnet run
A API ficará disponível em: http://localhost:5281

Interface interativa do Swagger: http://localhost:5281/swagger/index.html

Executando o Front-end
Entre na pasta do cliente:

Bash
cd frontend
Instale as dependências:

Bash
npm install
Execute o servidor de desenvolvimento:

Bash
npm run dev
Acesse a aplicação em: http://localhost:5173

📊 Fluxo da Aplicação
Plaintext
Cadastro de Moradores
         │
         ▼
Registro de Receitas/Despesas
         │
         ▼
Validação das Regras de Negócio (Front & Back)
         │
         ▼
Persistência no Banco de Dados
         │
         ▼
Geração do Relatório Consolidado (DTO)
         │
         ▼
Visualização dos Saldos Individuais e Gerais
📋 Conceitos Demonstrados
✔️ Construção de APIs RESTful estruturadas

✔️ Mapeamento de Relacionamentos com EF Core

✔️ Implementação de integridade referencial (Cascade Delete)

✔️ Segregação de modelos usando DTOs

✔️ Arquitetura de Software em Camadas

✔️ Desenvolvimento de Componentes React com TypeScript

✔️ Consumo assíncrono de APIs com Axios

✔️ Gerenciamento de Estados Globais e Locais

📂 Estrutura do Projeto
Plaintext
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
📄 Licença
Este projeto foi desenvolvido exclusivamente para fins de estudo, prática e avaliação técnica.
