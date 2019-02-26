///////////////////////////////////////////////////////
//  ELIM GAUSS_SUST.sce
//  Programa de solucion de ecuaciones lineales por medio de una matriz a traves del metodo de Elimiacion Gaussiana con Sustitucion
//
//  Este programa resuelve un sistema de ecuaciones por Elimiacion Gaussiana con Sustitucion
//   Patricio Andres Saldivar Flores y Diego Fernando Montaño Pérez
//   28 / Febrero  / 2019    version 1.0
//////////////////////////////////////////////////////

//////////////////////////////////////////////////////
//   
//
//  Funcion que resuelve un sistema de ecuaciones para obtener X a traves del metodo de Eliminacion Gaussiana por sustitucion
//
//   Parametros:
//      A    Es el parametro de la matriz MAT
//   Regresa:
//    El valor de la matriz X
/////////////////////////////////////////////////////

function X = ELIMGAUSS(A)
    //Por cada renglon i hasta el numero de renglones menos uno
    for i = 1 : size(A,1)-1
        //Por cada renglon k que empezara en i +1 hasta el numero total de renglones 
        for k = i + 1 : size(A,1)
            //Se inicializa el factorial
            fact = -A(k,i) / A(i,i)
            //Para cada columna j hasta el numero total de columnas se da valor a la matriz en (k,j)
            for j = 1 : size(A,2)
                A(k,j) = A(k,j) + fact * A(i,j)
            end
        end
        //Se despliega la matriz A
        disp(A)
    end
   
    //Por cada renglon i que inicializa en el numero total de renglones hasta 1 
    for i = size(A,1) : -1 : 1
        Suma = 0
        //Por cada columna j que inicializa en i+1 hasta el numero de renglones (la primera ves no entra el ciclo)
        for j = i + 1 : size(A,1)
            Suma = Suma + A(i,j) * X(j)
        end
        //Se regresa el valor de la ultima columna de la matriz A a X
        X(i) = (A(i,size(A,1)+1) - Suma) / A(i,i)
    end
endfunction


///////////////////////
////Programa Principal
//////////////////////

//Se pide el valor de la matriz inicial [x1,x2,...,xn;x1,x2,....;...]
MAT = input("Da la matriz ")
//Se manda a llamar la funcion ELIMGAUSS con la matriz como parametro y regresa el valor de X
X = ELIMGAUSS(MAT)
//Se despliega la matriz X
disp(X)


