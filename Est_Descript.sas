libname tfg 'C:\Users\carla\Desktop\TFG';

proc import datafile='C:\Users\carla\Desktop\TFG\depresion_depurada.xlsx'
    out=datos
    dbms=excel;
run;


*HISTOGRAMA;

*Vamos a hacerlo para cada tipo de variable para poder adaptar los ejes en cada caso;
ods graphics on;
ods select histogram; *Para que solo se muestren los histogramas;

PROC UNIVARIATE DATA=datos;
   VAR GPA;
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

*Para las de intervalo (quitamos job_satisfaction y work_pressure);

PROC UNIVARIATE DATA=datos;
   VAR Academic_pressure study_satisfaction financial_stress;
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

/* Llamada */
%boxplots(GPA Age Academic_pressure study_satisfaction work_study_hours financial_stress);

    

*Para las categóricas. Si ponemos varias, ya sale todo;

PROC FREQ DATA=datos;
   TABLES Depression gender Suicidal_thoughts family_history City degree sleep_duration dietary_habits / PLOTS=FREQPLOT;
RUN;


/* -----------  REVISAR  --------------------*/

/*Transformo a numericas las dicotomicas o aquellas categoricas con cierto orden? o solo lo hago con las numéricas*/

/*PARA MAPA DE CALOR*/
proc contents data=datos;
run;
*Salen degree y depression como char. No influye para lo anterior pq siguen siendo 2 categorias pero aquí si;

data datos_num;
    set datos;
    
    /* Convertir de char a num la variable Depression*/
    Depression_num = input(Depression, best32.);
    
    drop Depression;
    rename Depression_num=Depression;
run;

proc contents data=datos_num;
run;

/* Calcular matriz de correlación */
proc corr data=datos_num 
    outp=correlaciones 
    noprint;
    var Age Academic_Pressure Financial_Stress 
        Work_Study_Hours GPA Study_Satisfaction
        Sleep_Duration Dietary_Habits Suicidal_Thoughts
        Family_History Degree Depression;
run;

/* Transformar a formato long --> pasa de fila a tabla */
data corr_long;
    set correlaciones(where=(_TYPE_='CORR'));
    length var1 $32 var2 $32;
    var1 = _NAME_;
    
    array vars{12} Age Academic_Pressure Financial_Stress 
        Work_Study_Hours GPA Study_Satisfaction
        Sleep_Duration Dietary_Habits Suicidal_Thoughts
        Family_History Degree Depression;
    
    array varnames{12} $32 _temporary_ 
        ('Age' 'Academic_Pressure' 'Financial_Stress' 
         'Work_Study_Hours' 'GPA' 'Study_Satisfaction'
         'Sleep_Duration' 'Dietary_Habits' 'Suicidal_Thoughts'
         'Family_History' 'Degree' 'Depression');
    
    do i = 1 to 12;
        var2 = varnames{i};
        correlation = vars{i};
        output;
    end;
    
    keep var1 var2 correlation;
run;

/* 4. HEATMAP CON COLORES */
proc sgplot data=corr_long;
    heatmap x=var1 y=var2 / 
        colorresponse=correlation
        colormodel=(blue white red)  /* Azul=negativo, Blanco=0, Rojo=positivo */
        outline
        x2axis;
    
    xaxis display=(nolabel) 
        fitpolicy=rotate 
        labelattrs=(size=9pt);
    
    yaxis display=(nolabel) 
        labelattrs=(size=9pt);
    
    gradlegend / title="Correlación";
    
    title "Heatmap de Correlaciones";
run;
