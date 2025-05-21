# Backend - Teste Técnico

## Pré-requisitos
- Node.js >= 16
- Docker e Docker Compose

## Instalação

```bash
npm install
```

## Scripts
- `npm run dev` — inicia o servidor em modo desenvolvimento (nodemon)
- `npm start` — inicia o servidor em modo produção
- `npm run lint` — executa o linter

## Variáveis de Ambiente
Crie um arquivo `.env` na raiz do backend com o seguinte conteúdo:

```
PORT=3000
MONGODB_URI=mongodb://mongo:27017/erictel
JWT_SECRET=sua_chave_secreta
COINMARKETCAP_API_KEY=sua_api_key_aqui
```

## Executando o Projeto

### Com Docker Compose

```bash
docker-compose up --build
```
Acesse a API em http://localhost:3000
Acesse a documentação Swagger em http://localhost:3000/api/docs

### Sem Docker (apenas Node.js)

1. Instale as dependências:
   ```bash
   npm install
   ```
2. Crie o arquivo `.env` conforme exemplo acima.
3. Inicie o MongoDB localmente (porta 27017).
4. Inicie o servidor:
   ```bash
   npm run dev
   ```

## Exemplos de Requisições

### Cadastro
```http
POST /api/auth/register
Content-Type: application/json
{
  "nome": "João",
  "email": "joao@email.com",
  "senha": "123456"
}
```

### Login
```http
POST /api/auth/login
Content-Type: application/json
{
  "email": "joao@email.com",
  "senha": "123456"
}
```

### Listar Criptomoedas (autenticado)
```http
GET /api/crypto/
Authorization: Bearer <token>
```

Para mais exemplos, consulte a documentação Swagger em `/api/docs`. 
