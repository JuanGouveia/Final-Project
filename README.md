# Final-Project

![Proyecto Final](visualization/images/readme.jpg)

## Índice

1. [Descripción](#descripción)
2. [Objetivo principal](#objetivo)
3. [Análisis](#análisis)
4. [Extracción, Transformación y Carga (ETL)](#etl)
5. [Consultas](#consultas)
4. [Conclusiones](#conclusiones)

<a name="descripción"/>

## Descripción

Este proyecto se enfoca en la obtención de una base de datos histórica de la Fórmula 1 y posteriormente en la obtención y visualización de información relevante. Además, se desarrollará una página web que servirá para materializar los objetivos del proyecto.

### Objetivos y Metodología

El proyecto aborda múltiples objetivos de manera secuencial:

**1. Extracción, Transformación y Carga (ETL):** En una primera etapa, llevamos a cabo un proceso de Extracción, Transformación y Carga (ETL) de datos. Extraemos datos necesarios de diversas fuentes, como Kaggle, librerías de Python y una página web especializada. Luego, aplicamos transformaciones para adecuar los datos a nuestros objetivos específicos y finalmente los cargamos en nuestra base de datos.

**2. Análisis Exploratorio de Datos (EDA):** En la siguiente fase, realizamos un análisis exploratorio de datos (EDA) en busca de información relevante, patrones, tendencias y relaciones en los datos recopilados. Utilizamos técnicas como correlaciones de Spearman y pruebas de chi-cuadrado para profundizar en el análisis.

**3. Desarrollo de la Página Web:** El proyecto incluye la creación de una página web que se basa en los datos recopilados. Esta web se enfoca en los datos históricos de carreras, pilotos y otros aspectos relacionados con la Fórmula 1. Además, integramos visualizaciones que explican el desempeño de cada carrera mediante gráficos explicativos.

**4. Modelo de Aprendizaje:** Por último, creamos un modelo de aprendizaje automático para predecir la probabilidad de que aparezca un Safety Car en una carrera de Fórmula 1. Utilizamos datos históricos y la biblioteca Selenium para llevar a cabo este análisis.

<a name="objetivo"/>

## Objetivo Principal

Nuestro objetivo principal como analistas de datos es realizar procesos de ETL y EDA excepcionales. Esto implica recopilar una buena cantidad y calidad de datos, transformarlos de manera efectiva para alcanzar nuestros objetivos y conseguir una base de datos sólida que nos permita obtener información relevante. A través de un análisis exhaustivo de los datos, buscamos identificar insights valiosos. Finalmente, nos esforzamos por presentar de manera efectiva las conclusiones a través de visualizaciones.

Un objetivo secundario consiste en materializar todo lo anterior en una página web. Esta plataforma permitirá una visualización más accesible y táctil de nuestro trabajo. Además, elaboraremos un modelo de aprendizaje para lograr el objetivo de predecir la aparición de un Safety Car en una carrera de Fórmula 1.

<a name="análisis"/>

## Análisis

En esta sección, vamos a explicar y desarrollar cada uno de los componentes en los que hemos trabajado para la creación de este proyecto.

<a name="etl"/>

## Extracción, Transformación y Carga (ETL)

**Extracción:**

En la fase de extracción, nos enfocamos en recopilar información histórica de la Fórmula 1. Utilizamos un dataset de Kaggle como nuestra principal referencia, pero también exploramos otras fuentes para enriquecer nuestros datos. Las principales metodologías de extracción que empleamos son las siguientes:

- Descargamos archivos CSV desde [kaggle](https://www.kaggle.com/datasets/rohanrao/formula-1-world-championship-1950-2020), que contienen datos valiosos sobre la Fórmula 1.

- Utilizamos Selenium para realizar web scraping en la página de [f1.fandom.com](https://f1.fandom.com/wiki/Safety_Car), con el objetivo de obtener información adicional relevante.

- Instalamos la librería de Python [fastf1](https://pypi.org/project/fastf1/), para extraer datos detallados sobre el desempeño de las carreras y obtener gráficos relacionados.

**Transformación:**

En la fase de transformación, realizamos varias acciones en los datos recopilados:

- Descargamos y procesamos los archivos CSV de kaggle, renombrando las columnas según nuestros objetivos, eliminando las columnas innecesarias para nuestra investigación y refinando los detalles.

<details>
<summary><b>https://www.kaggle.com/</b></summary>
<br>

![F1 Dataset](visualization/images/kaggle.png)

</details>

- Al realizar el web scraping, ajustamos los nombres de las columnas, creamos una nueva columna para separar los años de los grandes premios y realizamos otros ajustes finales.

<details>
<summary><b>https://f1.fandom.com/</b></summary>
<br>

![F1 Dataset](visualization/images//wiki_f1.png)

</details>

- Utilizamos la librería 'fastf1' para obtener datos sobre el rendimiento de las carreras, lo que nos permite generar gráficos informativos.

<details>
<summary><b>https://pypi.org/</b></summary>
<br>

![F1 Dataset](visualization/images//fast_f1.png)

</details>

**Carga:**

- En la fase de carga, después de transformar todos los dataframes que utilizaremos para crear nuestro archivo de datos históricos, los cargamos en una base de datos MySQL. Para lograr esto, empleamos la biblioteca SQLAlchemy. A continuación, se muestran diagramas representativos de la estructura de la base de datos:

![Diagrama 1](visualization/images/diagrama1.png)
![Diagrama 2](visualization/images/diagrama2.png)

<details>
<summary><b>EXPLICACIÓN DEL MODELO ENTIDAD-RELACIÓN</b></summary>
<br>

El modelo entidad-relación de nuestra base de datos consta de varias tablas que representan diferentes aspectos de la historia de la Fórmula 1. A continuación, se describen las tablas y sus relaciones clave:

1. **Tabla 'races':** Contiene información sobre cada carrera en la historia de la Fórmula 1 y se relaciona con la mayoría de las otras tablas de la base de datos.

2. **Tabla 'drivers':** Almacena información sobre todos los pilotos que han participado en la Fórmula 1. Esta tabla se relaciona principalmente con 'driver_standings', que incluye detalles sobre la posición y los puntos de los pilotos en cada carrera.

3. **Tabla 'constructors':** Registra datos de todas las escuderías que han competido en la Fórmula 1 y se relaciona principalmente con 'constructor_standings' y 'constructor_results', que detallan la posición y los puntos de los equipos.

4. **Tabla 'results':** Contiene resultados de cada carrera en la historia de la Fórmula 1 y se relaciona con 'status', que describe eventos ocurridos en las carreras.

5. **Tabla 'sprint_results':** Registra resultados de las carreras de sprint recientes, que son un nuevo formato de competencia en la Fórmula 1. Se relaciona con 'status' y otras tablas.

6. **Tabla 'qualifying':** Contiene información sobre las clasificaciones en la historia de la Fórmula 1 y se relaciona con 'races', 'drivers' y 'constructors'.

7. **Tabla 'lap_times':** Registra tiempos por vuelta en cada Gran Premio y se relaciona con 'races' y 'drivers'.

8. **Tabla 'pit_stops':** Almacena detalles de las paradas en los pits de los pilotos en cada carrera y se relaciona con 'races' y 'drivers'.

9. **Tabla 'circuits':** Contiene datos sobre los circuitos utilizados en la Fórmula 1 y se relaciona exclusivamente con 'races'.

10. **Tabla 'safety_car':** Registra información sobre los coches de seguridad que han aparecido en la historia de la Fórmula 1 y se relaciona exclusivamente con 'races'.

</details>

<a name="consultas"/>

## Consultas

