# COVID-19 Analysis Pipeline

Проект автоматизирует обработку и анализ медицинских данных COVID-19 с использованием Hadoop, Hive, Spark и PySpark. В результате работы строятся отчёты и визуализации по эпидемиологическим данным, выгружаются parquet-файлы для дальнейшей аналитики.

ℹ️ Описание проекта

Проект представляет собой ETL-пайплайн для анализа медицинских изображений и метаданных COVID-19. Основные этапы пайплайна:

#### 1. Загрузка сырых данных в HDFS

#### 2. Предобработка CSV-файлов (очистка, унификация диагнозов)

#### 3. Создание Hive-таблиц с партиционированием и бакетированием

#### 4. SQL-аналитика (окна, join-операции, агрегации)

#### 5. PySpark UDF-обработка

#### 6. Машинное обучение (кластеризация KMeans)

#### 7. Выгрузка результатов в Parquet

#### 8. Визуализация данных в Jupyter Notebook

# Цель проекта — подготовить качественные данные для аналитических отчётов и BI-платформ.

## 📂 Структура проекта
```bash
TSU/
│
├── data/
│   ├── images/                         # Исходные изображения (если используются)
│   ├── processed/                      # Итоговые parquet-файлы после пайплайна
│      ├── covid_only.parquet
│      ├── kmeans_clusters.parquet
│      ├── metadata_with_udf.parquet
│      ├── query1_top_patients.parquet
│      ├── query2_views_join.parquet
│      ├── query3_covid_stats.parquet
│   ├── metadata.csv                    # Исходный CSV с метаданными
│   ├── metadata_cleaned.csv            # Очищенный CSV-файл
├── docker/
│   ├── postgresql-42.5.0.jar           # Драйвер для работы hive metastore с postgresql
├── hadoop-conf/                        # Конфигурация hadoop
├── hive-conf/                          # Конфигурация hive metastore
├── notebooks/                          # Рабочая папка
│   ├── hadoop.ipynb                    # Скрипт для загрузки изображений в hdfs и предобратонного csv
│   ├── preprocess.ipynb                # Скрипт для предобработки данных  csv и первоначальной визуализации
│   ├── spark.ipynb                     # Скрипт для работы с hive metastore и hdfs с помощью spark. Создание аналитических запросов, сохранение в parquet файлы
│   ├── visualize.ipynb                 # Скрипт для визуализации итогов
├── .gitignore
├── docker-compose.yml                  # Конфигурация сервисов Docker
├── dockerile                           # Dockerfile для Jupiter
└── README.md
```
## 🚀 Полная инструкция запуска проекта

### 1. Сборка Docker-образов
```bash
docker-compose build
```
### 2. Запуск контейнеров в фоне
```bash
docker-compose up -d
```
### 3. Вход в контейнер hadoop-namenode и создание папок с нужными правами
```bash
docker exec -it hadoop-namenode sh
hdfs dfs -mkdir /user

# Сделай под неё папку под своего пользователя
hdfs dfs -mkdir /user/hadoop

# Дай на неё права
hdfs dfs -chown hadoop:hadoop /user/hadoop

hdfs dfs -chmod 777 /user/hadoop/metadata

```
### 7. Запуск ноутбуков
Внутри jupiter ноутбука на localhost:8888 запускаем скрипты в следующей посоледовательности:
1.preprocess.ipynb
2.hadoop.ipynb
3.spark.ipynb

### 8. Вход в контейнер NameNode
```bash
docker exec -it namenode sh
```
### 9. Выгрузка результатов из HDFS в контейнер
💡 
```bash
hdfs dfs -get /user/hadoop/covid_dataset/processed /data/results
```
После завершения пайплайна выйти из контейнера:
```bash
exit
```
### 10. Выгрузка файлов с контейнера на хост-машину
```
Для Linux:
```bash
docker cp namenode:/data/results ./data/processed
```
## ✅ После выгрузки
Все parquet-файлы будут находиться в папке:
```text
data/processed
```
на вашей хост-машине. Эти данные можно использовать для визуализаций и анализа в Jupyter Notebook или других BI-инструментах.

📊 Работа с визуализациями

Запустите Jupyter Notebook:
```text
visualize.ipynb
```
