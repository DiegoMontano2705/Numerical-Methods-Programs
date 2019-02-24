   //                       Programa de Aproximación utilizando la serie de Maclaurin
   // Aproxima el valor del coseno de una x dada para una serie de términos dado
   // y despliega el error real  relativo % en cada aproximación y si es su caso debe desplegar el
   // error aproximado relativo % a partir de la segunda aproximación
   
   // autor: Diego Fernando Montaño Pérez A01282875
   // fecha: 22/01/19
   
   //Funcion en donde se llevan acabo las operaciones para sacar el Cos(x), el error real relativo y el error aproximado relativo
   function cosx = Suma(iX,iN)
       //Contadores para ayudar en las operaciones e inicador para el cosx 
       iHelp = 0;
       cosx = 0;
       iCont = 0;
       //Ciclo en donde se llevan acabo las opraciones, empieza siempre en cero y da salto de 2 en 2 hasta llegar al número ingresado por el usuario
       for i=0:2:(iN)
           //Condicional para saber si en la suma de números se le restara o se le suamara
           if modulo(i/2,2) == 0 then
               cosx = cosx + (iX^iHelp)/factorial(iHelp);
           else
               cosx = cosx - (iX^iHelp)/factorial(iHelp);
           end   
           //Calculo para obtener el error real relativo
           iErrorReal = abs((cos(iX)-cosx)/cos(iX))*100;
           //Condicional para que la primera ves que pase el ciclo no muestre el error relativo y solo el real
           if iCont == 0 then
           disp("n = " + string(iHelp) + " " + "suma = " + string(cosx) + " Error Real rel % = " + string(iErrorReal));
           else
           //Calculo para obtener el error relativo
           iErrorRelativo = abs((cosx-iCosxAnterior)/cosx)*100;
           disp("n = " + string(iHelp) + " " + "suma = " + string(cosx) + " Error Real rel % = " + string(iErrorReal) + " Error aprox rel % = " + string(iErrorRelativo));
           end 
           //Se guarda el valor se la suma en la variable iCosxAnterior para poder usarse en la siguiente pasada para calcular el error relativo
           iCosxAnterior = cosx;
           //Actulizacion de contadores
           iHelp = iHelp + 2;
           iCont = iCont + 1;
       end
   endfunction   
   
   
   //               Programa Principal
   //Parametros:
   // iX = Valor del coseno del número x
   // iN = Valor del exponente hasta el cual se quiere sumar
    iX = input("Dame el valor de x = ");
    iN = input("Dame el valor de n = ");
    //Validacion si n es par, en caso de que no, se muestra mensaje de error y se cierra programa
    if iN < 0 | modulo(iN,2) ~= 0  then
        disp("Error número no es positivo o par");
        break;
    end
    //Se llama metodo suma en donde se llevan acabo las operaciones y se muestran estas mismas
    Suma(iX,iN)
    
    return
