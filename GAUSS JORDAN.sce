///////////////////////////////////////////////////////
//  Tarea.sce
//  Programa de solucion de ecuaciones lineales por medio de una matriz a traves del metodo Gauss Jordan
//
//  Este programa aproxima 
//   Patricio Andres Saldivar Flores y Diego Fernando Montaño Pérez
//   25 / Febrero  / 2019    version 1.0
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
        //Se muestra la matriz A antes de finalizar cada iteracion
         disp(A)
     end
     //Se le regresa el valor de matriz A a X
     X=A()
endfunction

///////////////////////
////Programa Principal
//////////////////////

//Se pide el valor de la matriz inicial [x1,x2,...,xn;x1,x2,....;...]
MAT = input ("Da la matriz")

//Se manda a llamar la funcion Gauss con la matriz como parametro y regresa el valor de X
X = Gauss(MAT)

//Se despliega la matriz X
disp(X)
