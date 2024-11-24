# API Documentation: Rexcycle ♻️

Este projeto é uma API desenvolvida para o projeto [**Rexcycle**](https://github.com/JackGear0/Rexcycle). Desenvolvida com **Vapor**, um framework Swift para criação de aplicações web e APIs, o foco deste projeto é gerenciar vouchers, usuários (transportadoras e empresas) e interações em uma base de dados SQLite.

---

## 📋 **Funcionalidades**

- **Gerenciamento de Vouchers**  
  Inclui recursos para criar e interagir com vouchers.
  
- **Migração e Persistência de Dados**  
  Gerenciamento de dados utilizando **Fluent** com suporte ao SQLite.

- **Manipulação de Arquivos**  
  Criação de diretórios e suporte para arquivos públicos e documentação.

---

## 🚀 **Configuração do Ambiente**

### Pré-requisitos  
- **Swift** 5.7 ou superior  
- **Vapor** CLI (instalado via `brew install vapor`)  
- Banco de dados **SQLite**  

---

### **Instalação**

1. Clone este repositório:  
   ```bash
   git clone <url-do-repositorio>
   cd <nome-do-repositorio>
   ```

2. Instale as dependências:  
   ```bash
   vapor update
   ```

3. Configure o servidor:  
   A API está configurada para rodar no host `0.0.0.0` e utiliza um banco de dados SQLite chamado `db.sqlite`.

4. Crie as migrações e prepare o banco:  
   ```bash
   vapor run migrate
   ```

5. Execute a API:  
   ```bash
   vapor run serve
   ```

---

## 🛠️ **Estrutura do Projeto**

- **Middleware**:  
  O `ReportMiddleware` registra os caminhos das requisições feitas à API.

- **Migrações**:  
  Contém modelos como `CreateUser`, `CreateVoucher`, e outros para configurar as tabelas no banco SQLite.

- **Codificação JSON**:  
  Configurações específicas para codificação de chaves em **snake_case** e datas em formato ISO8601.

- **Diretórios Públicos**:  
  - `media`: Armazenamento de arquivos de mídia gerados pela aplicação.  
  - `documentation`: Documentação estática da API.

---

## 🧩 **EndPoints**

### Exemplos:
- **GET** `/vouchers`  
  Retorna a lista de vouchers disponíveis.

- **POST** `/reports`  
  Cria um novo relatório.

- **GET** `/users/{id}`  
  Retorna informações do usuário.

---

## 📚 **Tecnologias Utilizadas**

- **[Vapor](https://vapor.codes/)**  
- **[Fluent](https://docs.vapor.codes/fluent/overview/)**  
- **SQLite**  

---

## 🛡️ **Contribuindo**

1. Faça um fork deste repositório.  
2. Crie uma nova branch para sua funcionalidade:  
   ```bash
   git checkout -b feature/minha-funcionalidade
   ```
3. Submeta suas mudanças via PR.

---

## 📄 **Licença**

Este projeto está sob a licença **MIT**. Consulte o arquivo `LICENSE` para mais detalhes.

--- 
