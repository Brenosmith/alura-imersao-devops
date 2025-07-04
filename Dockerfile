FROM python:3.13.4-alpine3.22

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Copia o arquivo de requisitos para e instala as dependências
# Usado --no-cache-dir para evitar o cache de pacotes do pip, reduzindo o tamanho da imagem
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho
COPY . .

# Expõe a porta 8000 para acesso externo
EXPOSE 8000

# Comando para iniciar a aplicação usando o Uvicorn
# O host 0.0.0.0 permite que a aplicação seja acessível de fora do container
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]

# Instrucções para construir e executar o container
# docker build -t fastapi-app
# docker run -p 8000:8000 fastapi-app

# Instruções para verificar as imagens Docker disponíveis
# docker images

# Executar em: localhost:8000/docs