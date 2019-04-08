///////////////////////////////////////////////////////
//  Montatnte.sce
//  Programa de solucion de ecuaciones lineales por medio de una matriz a traves del metodo Montante
//
//  Este programa resuelve un sistema de ecuaciones por Montante
//   Patricio Andres Saldivar Flores y Diego Fernando Montaño Pérez
//   25 / Febrero  / 2019    version 1.0
//////////////////////////////////////////////////////


//////////////////////////////////////////////////////
//   
//
//  Funcion que resuelve un sistema de ecuaciones para obtener X a traves del metodo Montante
//
//   Parametros:
//      A    Es el parametro de la matriz MAT
//   Regresa:
//    El valor de la matriz X
/////////////////////////////////////////////////////

function X = Montante(A)
    //Se inicialza el pivote
    pivote =1
    //Por cada renglon i toma un pivote
    for i=1 : size(A,1)
        //Por cada renglon k se haran los ceros necesarios
        for k=1 : size(A,1)
            //Verifica que i y k sean differentes
            if(i<>k)
                // Para cada columna j desde i+1 se actualizan los valores
                for j=i+1 : size(A,2)
                    A(k,j)= (A(i,i)*A(k,j)-A(k,i)*A(i,j))/pivote
                end
                //Se realizan los ceros
                A(k,i)=0
            end
        end
        //El pivote se actualiza
        pivote = A(i,i)
        //Se actualizan las posiciones anteriores con los pivotes
        for(x=1 : i)
            A(x,x)=pivote
            end
        disp(A)
    end
    //  Se pasa el resultado a X, dividiendo la ultima columna entre el pivote
    for i=1 : size(A,1)
        X(i) = A(i,size(A,2))/pivote
    end


endfunction

///////////////////////
////Programa Principal
//////////////////////

//Se pide el valor de la matriz inicial [x1,x2,...,xn;x1,x2,....;...]
MAT = input ("Da la matriz")

//Se manda a llamar la funcion Montante con la matriz como parametro y regresa el valor de X
X = Montante(MAT)

//Se despliega la matriz X
disp(X)
