# Imersão DevOps - Alura Google Cloud

Este projeto é uma API desenvolvida com FastAPI para gerenciar alunos, cursos e matrículas em uma instituição de ensino.

## Pré-requisitos

- [Python 3.10 ou superior instalado](https://www.python.org/downloads/)
- [Git](https://git-scm.com/downloads)
- [Docker](https://www.docker.com/get-started/)

## Passos para subir o projeto

1. **Faça o download do repositório:**
   [Clique aqui para realizar o download](https://github.com/guilhermeonrails/imersao-devops/archive/refs/heads/main.zip)

2. **Crie um ambiente virtual:**
   ```sh
   python3 -m venv ./venv
   ```

3. **Ative o ambiente virtual:**
   - No Linux/Mac:
     ```sh
     source venv/bin/activate
     ```
   - No Windows, abra um terminal no modo administrador e execute o comando:
   ```sh
   Set-ExecutionPolicy RemoteSigned
   ```

     ```sh
     venv\Scripts\activate
     ```

4. **Instale as dependências:**
   ```sh
   pip install -r requirements.txt
   ```

5. **Execute a aplicação:**
   ```sh
   uvicorn app:app --reload
   ```

6. **Acesse a documentação interativa:**

   Abra o navegador e acesse:  
   [http://127.0.0.1:8000/docs](http://127.0.0.1:8000/docs)

   Aqui você pode testar todos os endpoints da API de forma interativa.

---

## Estrutura do Projeto

- `app.py`: Arquivo principal da aplicação FastAPI.
- `models.py`: Modelos do banco de dados (SQLAlchemy).
- `schemas.py`: Schemas de validação (Pydantic).
- `database.py`: Configuração do banco de dados SQLite.
- `routers/`: Diretório com os arquivos de rotas (alunos, cursos, matrículas).
- `requirements.txt`: Lista de dependências do projeto.

---

- O banco de dados SQLite será criado automaticamente como `escola.db` na primeira execução.
- Para reiniciar o banco, basta apagar o arquivo `escola.db` (isso apagará todos os dados).

---

# Alterações realizadas

## Containerização com Docker e CI

O projeto foi atualizado para incluir suporte a Docker e um fluxo de Integração Contínua (CI) básico com GitHub Actions.

### Docker

- **`Dockerfile`**: Define o ambiente para a aplicação, criando uma imagem Docker com Python e todas as dependências necessárias.
- **`.dockerignore`**: Garante que arquivos desnecessários (como o ambiente virtual `venv`) não sejam incluídos na imagem Docker, mantendo-a leve.

**Para construir e executar com Docker:**
```sh
# Construir a imagem
docker build -t imersao-devops-app .

# Executar o container
docker run -p 8000:8000 imersao-devops-app
```

### Docker Compose

- **`docker-compose.yml`**: Orquestra a execução do container da aplicação para facilitar o ambiente de desenvolvimento. Ele utiliza o `Dockerfile` para construir a imagem e monta o código-fonte local dentro do container, permitindo que alterações no código sejam refletidas em tempo real.

**Para executar com Docker Compose:**
```sh
docker compose up
```

### Integração Contínua (CI)

- **`.github/workflows/docker-image.yml`**: Define um workflow de GitHub Actions que é acionado a cada `push` ou `pull request` na branch `main`. A principal função deste workflow é construir a imagem Docker para garantir que ela continua funcional após novas alterações.


### Deploy no Google Cloud

#### 1. Autenticação

Autentique-se com sua conta do Google Cloud:
```sh
gcloud auth login
```

#### 2. Configurar o Projeto

Defina o projeto do Google Cloud que você deseja usar (substitua `PROJECT_ID` pelo ID do seu projeto):
```sh
gcloud config set project PROJECT_ID
```

#### 3. Realizar o Deploy
Para fazer o deploy da aplicação no Cloud Run a partir do código-fonte local, use o comando:
```sh
gcloud run deploy imersao-devops-app --source . --port 8000
```

**Parâmetros do comando:**
- `imersao-devops-app`: Nome do serviço que será criado no Cloud Run
- `--source .`: Define que o deploy será feito a partir da pasta atual (use `--source` seguido do caminho se for outro diretório)
- `--port 8000`: Porta na qual a aplicação será executada

Ao executar o comando acima pela primeira vez, o gcloud fará algumas perguntas interativas para configurar o ambiente:

1. **Habilitar APIs**: Ele pedirá para habilitar as APIs do Artifact Registry e do Cloud Build. Digite **y** (sim).
   - **Artifact Registry**: Armazena a imagem Docker criada
   - **Cloud Build**: Realiza o processo de build da imagem
   - **Cloud Run**: Executa a aplicação containerizada

2. **Região do Deploy**: Escolha a região onde sua aplicação será hospedada. Selecione **southamerica-east1** para hospedar no Brasil.

3. **Criar Artifact Registry**: Perguntará se deseja criar um repositório no Artifact Registry para armazenar a imagem. Digite **y** (sim).

4. **Acesso não autenticado**: Para permitir que a API seja acessível publicamente sem necessidade de autenticação, digite **y** (sim) quando perguntado sobre "allow unauthenticated invocations".

O Google Cloud Build irá automaticamente construir a imagem Docker usando seu Dockerfile, enviá-la para o Artifact Registry e, em seguida, fazer o deploy no Cloud Run.