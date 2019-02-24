clear
///////////////////////////////////////////////////////
//  Raices.sce
//
//  Este programa aproxima la raíz de una ecuación no lineal
//  con el método de Bisección
//
//   Gerardo   Silva
//   Eugenio   González
//   05 / feb  / 2019    version 1.0
//////////////////////////////////////////////////////

//////////////////////////////////////////////////////
//
//  Funcion que evalua x en la ecuación
//
//   Parametros:
//      iX     es el valor a evaluar

//   Regresa:
//     iX      es el valor de iX evaluado en la ecuación
//
/////////////////////////////////////////////////////
function dVal = Evalua(dX)
    // inicializo la suma
    dVal = (-%pi * (dX ^ 3)/3) + (3 * %pi * (dX ^ 2)) - 30
endfunction

//////////////////////////////////////////////////////
//
//  Función que calcula la raíz por método Bisección
//
//   Parametros:
//      dXl     es el valor de Xl
//      dXu     es el valor de Xu
//      dEa     es el valor del error absoluto
//      iN      es el valor máximo de iteraciones
//
/////////////////////////////////////////////////////
function [] = Biseccion(dXl, dXu, dEa, iN)
    //  Declaración de variables
    dXr = 0
    dXrAnterior = 0;
    dFXl = 0
    dFXu = 0
    dFXr = 0
    iCont = 0
    dError = 0
    bEntra = %t
    
    //  Cada ciclo es una iteración del método Bisección
    //  mientras el número de iteraciones no pase el especificado 
    //  y el error sea mayor al que se solicita, entra 
    while bEntra == %t && iCont < iN
        //  Evalua Xl en la ecuación
        dFXl = Evalua(dXl)
        //  Evalua Xu en la ecuación
        dFXu = Evalua(dXu)
        //  Calcula Xr
        dXr = (dXl + dXu) / 2
        //  Evalua Xr en la ecuación 
        dFXr = Evalua(dXr)
        
        //  Calcula Error absoluto
        if iCont > 0 then
            dError = abs((dXr - dXrAnterior) / dXr) * 100
        end
        
        //  Valida el signo de Xr evaluado en la ecuación para pasarlo a Xl o Xu
        if dFXr < 0 then
            
            if dFXl < 0 then
                dFXl = dFXr
            else
                dFXu = dFXr
            end
            
        end 
        
        //  Actualiza bEntrada
        if dError < dEa then
            bEntra = %f
        end
        
        //  Actualiza dXrAnterior
        dXrAnteior = dXr
        
        //  Actualiza iCont
        iCont = iCont + 1
        
        disp("Iteración " + (iCont+1))
        disp("Xl: " + dXl + " f(Xl): "+ dFXl + " Xu: " + dXu + " f(Xu): " + dFXu + " Xr: " + dXr + "f(Xr): " + dFXr + " Error: " + dError)
        disp("")
    end
     
endfunction




/////// Programa Principal

// pido los valores
//dA = input("Dame el limite inferior")
//dB = input("Dame el limite superior")
//iN = input("Dame el numero de rectangulos")

// despliego la integral aproximada
//disp(" Area Aproximada = " + string(Area(dA, dB, iN)))
