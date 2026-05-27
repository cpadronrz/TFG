from sklearn.model_selection import train_test_split, GridSearchCV
from sklearn.preprocessing import MinMaxScaler, OneHotEncoder
from sklearn.compose import ColumnTransformer
from sklearn.ensemble import RandomForestClassifier
import pandas as pd

# Cargamos la base de datos
df = pd.read_csv("bd_final_2.csv")
X = df.drop(columns=['Depression'])
y = df['Depression']

num = X.select_dtypes(include=["number"]).columns.tolist()
cat = X.select_dtypes(include=["object", "category", "bool"]).columns.tolist()

# Dividimos el conjunto en entrenamiento y prueba
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)


transformer = ColumnTransformer([
    ('num', MinMaxScaler(), num),
    ('cat', OneHotEncoder(drop='first'), cat)
])
X_train = transformer.fit_transform(X_train)
X_test = transformer.transform(X_test)


seed = 12345

# Parrilla para tunear los distintos parámetros
param_grid = {
    'n_estimators': [100, 200, 500, 1000, 1500],  # nº de árboles
    'max_depth': [2, 3, 4],           # Profundidad máxima
    'max_features': ['sqrt', 'log2'], # Máximo de variables a evaluar
    'min_samples_split': [2, 5, 10]   # Menor número de obs que deben quedar para dividir
}


grid_rf = GridSearchCV(
    estimator=RandomForestClassifier(random_state=seed, class_weight='balanced'), 
    param_grid=param_grid, 
    scoring='f1',  # Usamos F1 para equilibrar el modelo, con recall no ajusta bien
    cv=5, 
    n_jobs=-1
)

grid_rf.fit(X_train, y_train)

print("--- RESULTADOS DEL TUNING (PASO 1) ---")
print("Mejores parámetros encontrados:", grid_rf.best_params_)

