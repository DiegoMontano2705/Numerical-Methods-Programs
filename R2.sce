///////////////////////////////////////////////////////
//  R2.sce
//  Programa que dados los puntos de las coordenadas X,Y y un valor de x dado despliga : 
//    Regresión Lineal y la aproximación para y
//    Regresión Cuadrática y la aproximación para y
//    Regresión Exponencial y la aproximación para y
//    Regresión Potencia y la aproximación para y
//    La mejor regresión

//
//  Este programa hace aproximaciones a traves de diferentes regresiones y muestra cual de estas fue mejor
//   Patricio Andres Saldivar Flores y Diego Fernando Montaño Pérez
//   1 / Abril  / 2019    version 1.0
//////////////////////////////////////////////////////

//////////////////////////////////////////////////////
//   
//
//  Funcion que resuelve un sistema de ecuaciones para obtener X a traves del metodo Gauss Jordas
//
//   Parametros:
//      A    Es el parametro de la matriz MAT
//   Regresa:
//    El valor de la matriz X
/////////////////////////////////////////////////////

function X = Gauss(A)
    // Para cada renglon se obtiene un pivote y habra una iteracion cada numero de renglones 
    for i=1 : size(A,1)
        pivote = A(i,i)
        // Se dividen todos los valores del renglon de cada columna entre el pivote
        for j=1 : size(A,2)
            A(i,j) = A(i,j)/pivote
        end
        // Entra ciclo para checar los demas renglones de la matriz 
        for k=1 : size(A,1)
            //Si el renglon k es diferente al renglon i se saca el factorial
            if(k<>i)
                fact= -A(k,i)
                // Para cada columna j se hace una suma de la matriz en (k,j) mas la matriz en (i,j) por el factorial
                for j=1 : size(A,2)
                    A(k,j)= A(k,j)+ fact*A(i,j)
                end
            end
        end
    end
    //Se le regresa el valor de matriz A a X
    for i=1 : size(A,1)
        X(i,1)= A(i,size(A,2))
    end
endfunction


//////////////////////////////////////////////////////
//   
//
//  Funcion que resuelve la aproximacion para y con regresion lineal
//
//   Parametros:
//      A    Es el conjunto de valores en x
//      B    Es el conjunto de valores en y
//      V    Valor que sea estimar ("X")
//   Regresa:
//    El valor de la matriz X
/////////////////////////////////////////////////////


function X=Lineal(A,B,V)
    //Valores inicializados en 0 que se usaran en la funcion
    x=0
    xAlCuadrado=0
    y=0
    yx=0
    //Por cada columna de arreglo iniciando en 1
    for i=1 : size(A,2)
        //Operaciones para sacar la sumatoria de X al cuadrado y x por y
        x=A(i)+x
        xAlCuadrado=A(i)*A(i)+xAlCuadrado
        y=B(i)+y
        yx=B(i)*A(i)+yx
    end
    //Se crea matriz que guarda los valores de las sumatorias
    Matriz=[size(A,2),x, y; x, xAlCuadrado, yx]
    //Se manda a llamar a la funcion Gauss para obtener el reusltado de a
    a=Gauss(Matriz)
    SST=0
    SSE=0
    //Se incializa ymedia
    ymedia= y/size(B,2)
    //Por cada  columna del arreglo en y se va calculando SST sumando los resultados anteriores
    for i=1 : size(B,2)
        SST= (B(i)-ymedia)^2+SST
    end
     //Por cada  columna del arreglo en y se va calculando SSE sumando los resultados anteriores
    for i=1 : size(B,2)
        SSE= (B(i)-(A(i)*a(2)+a(1)))^2+SSE
    end
    //Se calcula R2 con su formula
    R2= (SST-SSE)/SST
     disp("Lineal: " + string(a(2)) + " * x + " + string(a(1))+ " r^2: " + string(R2))
     //Se regresa el valor para X para usarlo despues
    X= [R2,V*a(2)+a(1)]

endfunction

//////////////////////////////////////////////////////
//   
//
//  Funcion que resuelve la aproximacion para y con regresion cuadratica
//
//   Parametros:
//      A    Es el conjunto de valores en x
//      B    Es el conjunto de valores en y
//      V    Valor que sea estimar ("X")
//   Regresa:
//    El valor de la matriz X
/////////////////////////////////////////////////////

function X = Cuadratica(A,B,V)
    //Valores inicializados en 0 que se usaran en la funcion
    x=0
    xAlCuadrado=0
    xAlCubo=0
    xAlCuatro=0
    y=0
    yx=0
    yx2=0
    //Por cada columna de arreglo iniciando en 1
    for i=1 : size(A,2)
        //Operaciones para sacar la sumatoria de X al cuadrado, sumatoria de x por y, sumatoria de y, sumatoria de x cuadrada por y, sumatoria x al cubo, sumatoria de x al cuatro
        x=A(i)+x
        xAlCuadrado=A(i)*A(i)+xAlCuadrado
         y=B(i)+y
         yx=B(i)*A(i)+yx
         yx2=B(i)*A(i)*A(i)+yx2
         xAlCubo= A(i)^3+xAlCubo
         xAlCuatro= A(i)^4+xAlCuatro
         
    end
    //Se crea matriz en donde se ponen los valores de las sumatorias
    Matriz=[size(A,2),x, xAlCuadrado, y; x, xAlCuadrado, xAlCubo, yx; xAlCuadrado, xAlCubo, xAlCuatro, yx2]
    //Se resuelve la matriz con Gauss para obtener el valor de a
    a=Gauss(Matriz)
    SST=0
    SSE=0
    //Se incializa ymedia
    ymedia= y/size(B,2)
    //Por cada  columna del arreglo en y se va calculando SST sumando los resultados anteriores
    for i=1 : size(B,2)
        SST= (B(i)-ymedia)^2+SST
    end
    //Por cada  columna del arreglo en y se va calculando SSE sumando los resultados anteriores
    for i=1 : size(B,2)
        SSE= SSE + ((a(3)*A(i)*A(i)+a(2)*A(i)+a(1))-B(i))^2
    end
    //Se calcula R2 con su formula
    R2= (SST-SSE)/SST
     disp("Cuadratica: " + string(a(3)) + " * x^2 + " + string(a(2))+ " * x + "+string(a(1))+" r^2: " + string(R2))
     //Se regresa valor de x para usarlo despues
    X= [R2,(V^2)*a(3)+V*a(2)+a(1)]
endfunction

//////////////////////////////////////////////////////
//   
//
//  Funcion que resuelve la aproximacion para y con regresion exponencial
//
//   Parametros:
//      A    Es el conjunto de valores en x
//      B    Es el conjunto de valores en y
//      V    Valor que sea estimar ("X")
//   Regresa:
//    El valor de la matriz X
/////////////////////////////////////////////////////

function X = Exponencial(A,B,V)
    //Valores inicializados en 0 que se usaran en la funcion
    x=0
    xAlCuadrado=0
    y=0
    yx=0
       //Por cada columna de arreglo iniciando en 1
    for i=1 : size(A,2)
        //Se hacen sumatorias de los valores de x, x al cuadrado, de y , x por y
        x=A(i)+x
        xAlCuadrado=A(i)*A(i)+xAlCuadrado
        y=log(B(i))+y
        yx=log(B(i))*A(i)+yx
    end
    //Se crea matriz con los valores de las sumatorias antes hechas
    Matriz=[size(A,2),x, y; x, xAlCuadrado, yx]
     //Se resuelve la matriz con Gauss para obtener el valor de a
    a=Gauss(Matriz)
    SST=0
    SSE=0
    res=0
    //Se inicializa ymedia
    ymedia= y/size(B,2)
    //Por cada  columna del arreglo en y se va calculando el SST,res y SSE a traves de una sumatoria
    for i=1 : size(B,2)
        SST= (log(B(i))-ymedia)^2+SST
        res= exp(a(1))*exp(A(i)*a(2))
        SSE= (log(B(i))-log(res))^2+SSE
    end
    //Se obtiene el R2 con su formula
    R2= (SST-SSE)/SST
     disp("Exponencial: " + string(exp(a(1))) + " * e^( " + string(a(2))+ " * x ) r^2: " + string(R2))
     // Se regresa el valo de X para usarlo despues
    X= [R2,exp(a(1))*exp(V*a(2))]
endfunction

//////////////////////////////////////////////////////
//   
//
//  Funcion que resuelve la aproximacion para y con regresion exponencial
//
//   Parametros:
//      A    Es el conjunto de valores en x
//      B    Es el conjunto de valores en y
//      V    Valor que sea estimar ("X")
//   Regresa:
//    El valor de la matriz X
/////////////////////////////////////////////////////

function X = Potencial(A,B,V)
    //Valores inicializados en 0 que se usaran en la funcion
    x=0
    xAlCuadrado=0
    y=0
    yx=0
    for i=1 : size(A,2)
        //Se hacen sumatorias de los valores de x, x al cuadrado, de y , x por y
        x=log(A(i))+x
        xAlCuadrado=log(A(i))^2+xAlCuadrado
        y=log(B(i))+y
        yx=log(B(i))*log(A(i))+yx
    end
     //Se crea matriz con los valores de las sumatorias antes hechas
    Matriz=[size(A,2),x, y; x, xAlCuadrado, yx]
    //Se resuelve la matriz con Gauss para obtener el valor de a
    a=Gauss(Matriz)
    SST=0
    SSE=0
    //Se inicializa ymedia
    ymedia= y/size(B,2)
    //Por cada  columna del arreglo en y se va calculando el SST,res y SSE a traves de una sumatoria
    for i=1 : size(B,2)
        SST= (log(B(i))-ymedia)^2+SST
        res= exp(a(1))*(A(i)^(a(2)))
        SSE= (log(B(i))-log(res))^2+SSE
    end
    //Se obtiene el R2 con su formula
    R2= (SST-SSE)/SST
     disp("Potencial: " + string(exp(a(1))) + " * x^( " + string(a(2))+ " ) r^2: " + string(R2))
     // Se regresa el valo de X para usarlo despues
    X= [R2,exp(a(1))*(V^(a(2)))]
endfunction

///////////////////////
////Programa Principal
//////////////////////

//Se pide el valor del conjunto de valores de x [1,3,4,...,n]
ARRX = input ("Conjunto de valores x : ")
//Se pide el valor del conjunto de valores de y [1,3,4,...,n]
ARRY = input ("Conjunto de valores y : ")
//Se pide el valor que se desea estimar
x = input("Valor que desea estimar : ")
//Se mandan a llamar todas las funciones de regresion con los datos antes ingresados
RLineal=Lineal(ARRX,ARRY,x)
RCuadratico=Cuadratica(ARRX,ARRY,x)
RPotencial=Potencial(ARRX,ARRY,x)
RExponencial=Exponencial(ARRX,ARRY,x)
//Se calcula cual regresion fue la que dio el mejor valor estimado
Rmayor=RLineal(1)
if(Rmayor<RCuadratico(1))
    Rmayor=RCuadratico(1)
end
if(Rmayor<RPotencial(1))
    Rmayor=RPotencial(1)
end
if(Rmayor<RExponencial(1))
    Rmayor=RExponencial(1)
end
//Se despliguan conclusiones, basandose de que regresion fue mejor, muestra los resultados de esa regresion
disp("Conclusiones:")
if(Rmayor==RExponencial(1))
    disp("El mejor modelo es el exponencial con r2 =" + string(Rmayor))
    disp("Usando el mejor modelo el valor estimado para" + string(x) + "es: "+string(RExponencial(2)))
elseif(Rmayor == RLineal(1))
        disp("El mejor modelo es el lineal con r2 =" + string(Rmayor))
        disp("Usando el mejor modelo el valor estimado para" + string(x) + "es: "+string(RLineal(2)))
    elseif(Rmayor == RPotencial(1))
            disp("El mejor modelo es el potencial con r2 =" + string(Rmayor))
            disp("Usando el mejor modelo el valor estimado para" + string(x) + "es: "+string(RPotenciall(2)))
       elseif(Rmayor == RCuadratico(1))
                disp("El mejor modelo es el cuadratico con r2 =" + string(Rmayor))
                disp("Usando el mejor modelo el valor estimado para" + string(x) + "es: "+string(RCuadratico(2)))
            end
/////////////////
//Termina programa
/////////////////
