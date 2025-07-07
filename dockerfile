# Базовый образ
FROM python:3.12-slim

# Установим зависимости
RUN apt-get update && \
    apt-get install -y default-jdk build-essential && \
    rm -rf /var/lib/apt/lists/*

# Установим Python зависимости
RUN pip install --no-cache-dir \
    jupyterlab \
    ipykernel \
    pyspark \
    pandas \
    matplotlib \
    hdfs \
    seaborn

# Настроим JAVA_HOME
ENV JAVA_HOME=/usr/lib/jvm/default-java
ENV PATH="$JAVA_HOME/bin:$PATH"

# Создаём рабочую папку
WORKDIR /workspace
RUN chmod -R 777 /workspace

RUN python -m ipykernel install --name=myenv --display-name "Python (myenv)"

COPY data /data

# Пробрасываем порт
EXPOSE 8888

# Запускаем JupyterLab с токеном по умолчанию (лучше оставить)
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--NotebookApp.token=''"]
