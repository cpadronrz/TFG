# Aplicación de técnicas de Machine Learning para la detección temprana de la depresión en población estudiantil

<div align="center">
  <img src="https://img.shields.io/badge/Languages-R%20%7C%20SAS-276DC3?style=for-the-badge" height="35">
  <img src="https://img.shields.io/badge/Main%20Model-Logistic%20Regression-purple?style=for-the-badge" height="35">
  <img src="https://img.shields.io/badge/Sensitivity-91.59%25-brightgreen?style=for-the-badge" height="35">
</div>


## 📑 Table of Contents

* [Descripción](#descripcion)
* [Estructura del proyecto](#estructura)
* [Metodología y Reproducibilidad](#metodologia)
* [Conclusiones Clave](#conclusiones)


## 📝 Descripción <a id="descripcion"></a>
Este proyecto tiene como objetivo principal diseñar una herramienta capaz de identificar indicadores de riesgo de depresión de forma preventiva en entornos educativos, utilizando una muestra de **27.829 estudiantes**.

A través de este repositorio, comparto todo mi flujo de trabajo, desde el preprocesamiento de datos crudos hasta la validación de modelos de alta precisión como **Random Forest** y **Árboles de Decisión**, concluyendo con un modelo de **Regresión Logística** optimizado para la detección clínica.

---

## 📂 Estructura del Proyecto <a id="estructura"></a>

He dividido mi código en módulos específicos para que el análisis sea totalmente reproducible:

| Archivo | Descripción |
| :--- | :--- |
| **`depuracion.Rmd`** | Mi proceso de limpieza: gestión de NAs, corrección tipográfica de ciudades e imputación por mediana. |
| **`relaciones.Rmd`** | Mi análisis exploratorio. Uso de Spearman para variables ordinales y $\chi^{2}$ de Pearson para categóricas. |
| **`RLB.Rmd`** | Desarrollo del modelo de Regresión Logística. Comparativa de criterios AIC/BIC y optimización del umbral. |
| **`ARBOLES.Rmd`** | Ajuste y poda (*pruning*) de árboles de clasificación hasta alcanzar la estructura óptima de 8 hojas. |
| **`RF.Rmd`** | Entrenamiento del Random Forest optimizando hiperparámetros ($mtry=2$, $ntree=200$). |
| **`Comparacion_modelos.Rmd`** | Evaluación final comparativa para seleccionar el modelo con mejor rendimiento y parsimonia. |
| **`student_depresion.csv`** | El dataset utilizado en el proyecto. |

---

## 🛠️ Metodología y Reproducibilidad <a id="metodologia"></a>

Para asegurar reproducibilidad, he seguido estas pautas técnicas:

* **Semilla fija:** Utilizo `set.seed(12345)` en todos los procesos que implican aleatoriedad (partición de datos y Random Forest).
* **Partición de muestra:** He destinado un 80% de los datos para entrenamiento y un 20% para validación externa (test).
* **Librerías clave:** `caret`, `rpart`, `randomForest`, `pROC`, `corrplot` y `tidyverse`.

---

## 📈 Conclusiones Clave <a id="conclusiones"></a>

Tras comparar los distintos algoritmos, seleccioné la **Regresión Logística (Modelo 1)** por su excelente equilibrio entre simplicidad y capacidad diagnóstica:

* **Sensibilidad:** 91,59% (priorizando minimizar falsos negativos en salud pública).
* **AUC:** 0,9204.
* **Factores Críticos:** He identificado que los **pensamientos suicidas** multiplican el riesgo por 12 y la **presión académica** y una **dieta poco saludable** son factores de riesgo determinantes.

---

## ✍️ Autora
**Carla Padrón Rodríguez** *Grado en Estadística Aplicada*
