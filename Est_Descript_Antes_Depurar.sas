/*ESTADÍSTICOS DESCRIPTIVOS PREVIOS A LA DEPURACIÓN*/

libname tfg 'C:\Users\carla\Desktop\TFG';

proc import datafile='C:\Users\carla\Desktop\TFG\student_depresion.csv'
    out=datos
    dbms=csv;
run;

*HISTOGRAMA;

*Vamos a hacerlo para cada tipo de variable para poder adaptar los ejes en cada caso;
ods graphics on;

PROC UNIVARIATE DATA=datos;
   VAR CGPA;
   HISTOGRAM / NORMAL(MU=EST SIGMA=EST)
                CFILL=GRAY
                MIDPOINTS=2 TO 12 BY 0.5;
RUN;

PROC UNIVARIATE DATA=datos;
   VAR Age;
   HISTOGRAM / NORMAL(MU=EST SIGMA=EST)
                CFILL=GRAY
                MIDPOINTS=16 TO 42 BY 1;
RUN;

*Para las de intervalo;

PROC UNIVARIATE DATA=datos;
   VAR Academic_pressure study_satisfaction financial_stress job_satisfaction work_pressure;
   HISTOGRAM / NORMAL(MU=EST SIGMA=EST)
                CFILL=GRAY
                MIDPOINTS=0 TO 6 BY 1;
RUN;

PROC UNIVARIATE DATA=datos;
   VAR work_study_hours ;
   HISTOGRAM / NORMAL(MU=EST SIGMA=EST)
                CFILL=GRAY
                MIDPOINTS=0 TO 14 BY 1;
RUN;

*BOX-PLOT;

%macro boxplots(vars); *Recibe una lista de variables separada por espacios;
    %local i var; *Declaramos las variablles i y var que serán las que usaremos a lo largo de la macro;
    %let i=1; *Inicializamos el contador;

    %do %while(%scan(&vars, &i) ne ); *Con scan(&vars, &i) extraemos la i-ésima palabra de la lista vars (cuando acabe devolverá vacío) y con el while(... ne) nos encargamos de ir ejecutando mientras la lista no esté vacía;
        %let var = %scan(&vars, &i); *Asigna a var el valor de vars en el que nos encontramos;
        proc sgplot data=datos; *Generamos el boxplot;
            vbox &var;
        run;
        %let i = %eval(&i+1); *Incrementamos el contador para que pase a la siguiente variable;
    %end;
%mend;

* Llamada;
%boxplots(CGPA Age Academic_pressure Work_pressure study_satisfaction job_satisfaction work_study_hours financial_stress);


*Para las categóricas. Si ponemos varias, ya sale todo;

PROC FREQ DATA=datos;
   TABLES Depression gender Have_you_ever_had_Suicidal_thoug family_history_of_mental_illness degree sleep_duration 
	dietary_habits profession / PLOTS=FREQPLOT;
RUN;

*Ampliamos los márgenes para City para que no se solapen las etiquetas;

ODS GRAPHICS / WIDTH=12in HEIGHT=6in;

PROC FREQ DATA=datos;
   TABLES City / PLOTS=FREQPLOT;
RUN;
