# Aplicación de técnicas de Machine Learning para la detección temprana de la depresión en población estudiantil

<p align="center">
  <img src="https://img.shields.io/badge/Main_Model-Logistic_Regression-purple?style=for-the-badge" />
  <img src="https://img.shields.io/badge/R_Language-276DC3?style=for-the-badge&logo=r&logoColor=white" />
  <img src="https://img.shields.io/badge/AUC-0.9204-green?style=for-the-badge" />
</p>

## 📝 Descripción
Este proyecto tiene como objetivo principal diseñar una herramienta capaz de identificar indicadores de riesgo de depresión de forma preventiva en entornos educativos, utilizando una muestra de **27.829 estudiantes**.

A través de este repositorio, comparto todo mi flujo de trabajo, desde el preprocesamiento de datos crudos hasta la validación de modelos de alta precisión como **Random Forest** y **Árboles de Decisión**, concluyendo con un modelo de **Regresión Logística** optimizado para la detección clínica.

---

## 📂 Estructura del Proyecto

He dividido mi código en módulos específicos para que el análisis sea totalmente reproducible:

| Archivo | Descripción |
| :--- | :--- |
| **`depuracion.Rmd`** | [cite_start]Mi proceso de limpieza: gestión de NAs, corrección tipográfica de ciudades e imputación por mediana[cite: 34, 35, 40]. |
| **`relaciones.Rmd`** | Mi análisis exploratorio. [cite_start]Uso de Spearman para variables ordinales y $\chi^{2}$ de Pearson para categóricas[cite: 73, 78]. |
| **`RLB.Rmd`** | Desarrollo del modelo de Regresión Logística. [cite_start]Comparativa de criterios AIC/BIC y optimización del umbral[cite: 91, 103, 111]. |
| **`ARBOLES.Rmd`** | [cite_start]Ajuste y poda (*pruning*) de árboles de clasificación hasta alcanzar la estructura óptima de 8 hojas[cite: 123, 138, 140]. |
| **`RF.Rmd`** | [cite_start]Entrenamiento del Random Forest optimizando hiperparámetros ($mtry=2$, $ntree=200$)[cite: 148, 155, 159]. |
| **`Comparacion_modelos.Rmd`** | [cite_start]Evaluación final comparativa para seleccionar el modelo con mejor rendimiento y parsimonia[cite: 168, 178]. |
| **`student_depresion.csv`** | [cite_start]El dataset utilizado en el proyecto[cite: 49]. |

---

## 🛠️ Metodología y Reproducibilidad

Para asegurar reproducibilidad, he seguido estas pautas técnicas:

* [cite_start]**Semilla fija:** Utilizo `set.seed(12345)` en todos los procesos que implican aleatoriedad (partición de datos y Random Forest)[cite: 89, 170].
* **Partición de muestra:** He destinado un 80% de los datos para entrenamiento y un 20% para validación externa (test)[cite: 88, 170].
* **Librerías clave:** `caret`, `rpart`, `randomForest`, `pROC`, `corrplot` y `tidyverse`.

---

## 📈 Conclusiones Clave

[cite_start]Tras comparar los distintos algoritmos, seleccioné la **Regresión Logística (Modelo 1)** por su excelente equilibrio entre simplicidad y capacidad diagnóstica[cite: 178, 219]:

* [cite_start]**Sensibilidad:** 91,59% (priorizando minimizar falsos negativos en salud pública)[cite: 181, 182].
* **AUC:** 0,9204[cite: 120, 179].
* [cite_start]**Factores Críticos:** He identificado que los **pensamientos suicidas** multiplican el riesgo por 12 y la **presión académica** y una dieta poco saludable son factores de riesgo determinantes[cite: 208, 210, 222].

---

## ✍️ Autora
[cite_start]**Carla Padrón Rodríguez** *Grado en Estadística Aplicada* [cite: 3, 5]
