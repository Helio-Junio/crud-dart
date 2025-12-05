# CRUD - DESAFIO FINAL MOBILE II
Este repositório contém o backend desenvolvido em Dart utilizando shelf, mysql1 e arquitetura limpa simplificada, além da integração com um aplicativo Flutter que consome o CRUD.

## O objetivo principal é demonstrar domínio de:

Estrutura de API RESTful

Regras de CRUD completo (Create, Read, Update, Delete)

Conexão com banco MySQL

Organização em camadas (DAO → Service → API → Router)

Persistência e tratamento de erros

Boas práticas para desenvolvimento backend

## 🚀 Tecnologias utilizadas
### Backend

Dart SDK

Shelf (servidor HTTP)

mysql1 (driver MySQL)

dotenv (variáveis de ambiente)

Architecture clean (API → Service → DAO → Infra)

### Frontend

Flutter

HTTP Client

SharedPreferences

Navegação por rotas

Telas de CRUD completas (clientes e produtos)

Banco de dados

MySQL 8

Workbench para administração

## 📂 Estrutura do Projeto
/bin
  └── dart_server.dart         # arquivo principal que inicia o servidor

/lib
  ├── apis/                    # controladores de rotas
  ├── dao/                     # acesso ao banco de dados
  ├── dependency_injector/     # container DI
  ├── infra/                   # conexão MySQL
  ├── models/                  # classes model
  ├── routers/                 # rotas expostas
  └── services/                # regras de negócio

## 🛠️ Como rodar o backend
1️⃣ Instale as dependências
dart pub get

2️⃣ Configure as variáveis de ambiente

Crie um arquivo .env na raiz:

DB_HOST=localhost
DB_PORT=3306
DB_USER=seu_usuario
DB_PASS=sua_senha
DB_NAME=crud_cliente
HOST=0.0.0.0
PORT=3000

3️⃣ Suba o servidor
dart run bin/dart_server.dart


Se tudo estiver certo, aparecerá:

🔥 Servidor rodando em http://0.0.0.0:3000
🟢 Conectado ao MySQL!

## 🧪 Testes no Postman / Thunder Client
✔ Listar clientes
GET http://localhost:3000/clientes

✔ Listar produtos
GET http://localhost:3000/produtos

✔ Criar cliente
POST http://localhost:3000/clientes
Content-Type: application/json

{
  "nome": "João",
  "sobrenome": "Silva",
  "email": "joao@email.com",
  "idade": 25,
  "foto": "https://i.pravatar.cc/150?img=1"
}

## 🗄️ Scripts SQL (MySQL)

Crie seu banco usando o Workbench ou terminal:

### 📌 Tabela clientes
CREATE TABLE clientes (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(150) NOT NULL,
  sobrenome VARCHAR(150) NOT NULL,
  email VARCHAR(255) NOT NULL,
  idade INT,
  foto VARCHAR(300)
);

### 📌 Tabela produtos
CREATE TABLE produtos (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(150) NOT NULL,
  descricao TEXT,
  preco DECIMAL(10,2) NOT NULL DEFAULT 0.00
);

### 📌 Seed (opcional)
INSERT INTO clientes (nome, sobrenome, email, idade, foto) VALUES
('João', 'Silva', 'joao.silva@example.com', 30, 'https://i.pravatar.cc/150?img=1'),
('Maria', 'Oliveira', 'maria.oliveira@example.com', 27, 'https://i.pravatar.cc/150?img=2');

## 📱 Integração com Flutter

O app Flutter se conecta ao backend usando:

const baseUrl = "http://localhost:3000";


Para Android Emulator:

const baseUrl = "http://10.0.2.2:3000";


Para dispositivo físico:

Use o IP da sua máquina:

const baseUrl = "http://192.168.x.x:3000";

## 🎨 Telas do App Flutter

Tela de clientes → lista, cadastro, edição e exclusão

Tela de produtos → lista, cadastro, edição e exclusão

Uso de SharedPreferences

Rotas organizadas

Layout simples e intuitivo

(adicione prints do seu app aqui 🎉)

## 💡 Destaques do Projeto

Backend completo em Dart (raro e valioso no mercado)

Arquitetura modular e escalável

Flutter consumindo API real

Integração com MySQL

Pronto para deploy no Docker, Railway, Render, etc.

## 🧑‍💻 Autores

Hélio Ferreira
Guilherme Salatiel
Oscar Lara
Matheus Lima
