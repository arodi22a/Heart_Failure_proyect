## Proyecto: Predicción de supervivencia de pacientes con insuficiencia cardiaca

Este es un proyecto resultado de lo aprendido del curso de Ciencia de Datos de BEDU.

En este proyecto se realiza una análisis de datos de una base de datos obtenida de Kaggle (https://www.kaggle.com/fedesoriano/heart-failure-prediction). Este dataset contiene información clínica de 918 pacientes y si murieron por una deficiencia cardiaca o no. El objetivo de este proyecto es analizar las posibles relaciones que haya entre las variables clínicas para encontrar si hay una correlación las muertes por enfermedad cardiaca. Además, se usará la Regresión Logística para predecir si un paciente puede morir o no por una enfermedad cardiaca.

La variables son las siguientes.

Age: edad del paciente [años]

Sex: sexo del paciente [M: Masculino, F: Femenino].

ChestPainType: tipo de dolor de pecho [TA: angina típica, ATA: angina atípica, NAP: dolor no anginal, ASY: asintomático].

Resting_BP: presión arterial en reposo [mm Hg].

Cholesterol: colesterol sérico [mm / dl].

Fasting_BS: azúcar en sangre en ayunas [1: si BS en ayunas> 120 mg / dl, 0: en caso contrario]

Resting_ECG: resultados del electrocardiograma en reposo [Normal: Normal, ST: con anomalía de la onda ST-T (inversiones de la onda T y / o elevación o depresión del ST> 0,05 mV), HVI: que muestra una hipertrofia ventricular izquierda probable o definitiva según los criterios de Estes].

MaxHR: frecuencia cardíaca máxima alcanzada [Valor numérico entre 60 y 202]

ExerciseAngina: angina inducida por el ejercicio [Y: Sí, N: No]

Oldpeak: oldpeak = ST [Valor numérico medido en depresión]

ST_Slope: la pendiente del segmento ST del ejercicio pico [Up: uploping, Flat: flat, Down: downsloping]

HeartDisease: 1: muerte por enfermedad cardíaca, 0: muerte por otra razón.

La base da datos está compuesta por 5 bases de datos diferentes que no habian sido juntadas previamente.

Cleveland: 303 obervaciones.
Hungarian: 294 obervaciones.
Switzerland: 123 obervaciones.
Long Beach VA: 200 obervaciones.
Stalog (Heart) Data Set: 270 obervaciones.

Total: 1190 obervaciones.
Duplicated: 272 obervaciones.

Base de datos final: 918 observaciones.

