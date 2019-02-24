clear
///////////////////////////////////////////////////////
//  Tarea.sce
//  Programa de Solucion de una raiz de una ecuacion no lineal
//
//  Este programa aproxima la raiz de una funcion por medio del metodo de biseccion
//   Patricio Andres Saldivar Flores y Diego Montaño Pérez
//   04 / Febrero  / 2019    version 1.0
//////////////////////////////////////////////////////


//////////////////////////////////////////////////////
//   
//
//  Funcion que calcula el valor de la funcion:  f(x)=pi * x^2(9-x)/3 -30
//
//   Parametros:
//      x    Es el parametro de la funcion f(x)
//   Regresa:
//    El valor de la funcion f(x)
/////////////////////////////////////////////////////


function [a]=ValorFuncion(x)
    a=(%pi*x^2*(9-x)/3) - 30
endfunction


//////////////////////////////////////////////////////
//   MetodoBiseccion
//
//  Funcion que calcula la raiz de la funcion:  pi * x^2(9-x)/3 -30 por el metodo de biseccion
//
//   Parametros:
//      xl     Es el parametro minimo bajo de x
//      xu     es el parametro maximo de x
//      n      Es el valor maximo de iteraciones
//      e      Es el valor del error absoluto minimo que puede tener
//   Regresa:
//     Un anuncio por cada valor aproximado por iteracion mas su error absoluto, ademas regresa una de las posibles tres alternativas: 
//      que se haya dado una aproximacion con el error dado
//      el valor fue exacto
//      no se encontro un valor aproximado con valor menor al error tenido
/////////////////////////////////////////////////////


function  MetodoBiseccion(xl,xu,e,n)
    errorAproximado = 0
    i = 0
    xr = 0
    valorXl = ValorFuncion(xl)
    valorXu = ValorFuncion(xu)

    //Los dos valores son positivos entonces no se lograra encontrar raiz
    if(valorXl >0 & valorXu > 0)
        i=n
        disp("Los dos valores son positivos entonces no se lograra encontrar raiz")
    end

    //Los dos valores son negativos entonces no se lograra encontrar raiz
    if(valorXl <0 & valorXu)
        i=n;
        disp("Los dos valores son negativos entonces no se lograra encontrar raiz")
    end
    //Hace que la xl sea el que tenga el valor negativo
    if(valorXl>0)
        helper = valorXl
        valorXl = valorXu
        valorXu = helper
        helper = xl
        xl = xu
        xu = helper
    end
    //Entra en un ciclo para que se cumpla cada iteraciom
    while(i<n)
        errorAproximado = abs(((xl+xu)/2)-xr/((xl+xu)/2))* 100;
        //Se consigue el valor de XR
        xr= (xl+xu)/2
        //Se consigue el valor en la funcion de xr f(xr)
        valorXr = ValorFuncion(xr)
        //Si el valor es igual a 0 se ha encontrado la raiz
        if(valorXr == 0)
            i=n
        end
        //Si el valor en la funcion es negativo se cambia por xl, de lo contrario por xu
        if(valorXr<0)
            valorXl = valorXr
            xl = xr
        else
            valorXu = valorXr
            xu = xr
        end

        if (i>0)
            // Si no es la primera iteracion se obtiene Error Relativo
            disp("n de iteracion = "+ string(i) + " Xr =" + string(xr) + " y tiene un error aproximado de %" + string(errorAproximado))
        else
            // Si es la primera iteracion este no tiene error aproximado entonces solo despliga los datos de la iteracion
            disp("n de iteracion = "+ string(i) + " Xr =" + string(xr))
        end
        
        if (valorXr == 0)
           // Si la raiz encontrada da un valor igual a 0 se termina la funcion ya que da un valor exacto 
           disp("La raiz encontrada es exacta")
           break;
        end
        
        
        if (errorAproximado <= e)
            // Si el error aproximado caculado con el programa es igual o menor al que fue dado por el usuario entonces se despliega este mensaje y se termina la funcion 
            disp("La raiz encontrada fue aproximada con el error absoluto porcentual")
            break;
        end 
        
        if (i == n-1)
            // Si el programa se termina con las iteraciones dadas por el usuario se muestra este mensaje
            disp("La raiz encontrada fue aproximada con el numero de iteraciones dado ")
        end
            
        i= i + 1
    end
endfunction


/////// Programa Principal

// Se piden los valores
xl = input("Dame el valor de xl = ")
xu = input("Dame el valor de xu = ")
e = input("Dame el valor del error absoluto  = %")
n = input("Dame el valor del numero de iteraciones = ")


// Se despliega la suma aproximada
MetodoBiseccion(xl,xu,e,n)


