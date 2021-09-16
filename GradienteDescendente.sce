
//               @ metodo de Gradiente Descendente @ 
clear
clc
global d;
global x;
x = [0, 3];
global lambda;
lambda = 0;

function z = f(p)
    z = (p(1)-2)^4 + (p(1)-2*p(2))^2;
endfunction

function resp = dfdx(p)
    h = 0.00001;
    h2= [h, 0];
    resp = (f(p+h2)-f(p))/h;
endfunction

function resp = dfdy(p)
    h = 0.00001;
    h2= [0, h];
    resp = (f(p+h2)-f(p))/h;
endfunction

function resp = calculaGradiente(p)
   resp = [dfdx(p), dfdy(p)];
endfunction

function z = fLambda(lambda)
    global x;
    global d;
    z = f(x + lambda*d);
endfunction

function y1 = primeiraDerivada()
    global lambda;
    h = 0.00001;
    y1 = (fLambda(lambda+h)-fLambda(lambda))/h;
endfunction

function y2 = segundaDerivada()
    global lambda;
    h = 0.00001;
    y2 = (fLambda(lambda+h)-2*fLambda(lambda)+fLambda(lambda-h))/h^2;
endfunction

function newtonParaLambda()
    global lambda;
    for (i = 1:10)
        lambda = lambda - (primeiraDerivada()/segundaDerivada());
    end
endfunction

function gradienteDescendente()
    global x;
    global d;
    global lambda;
    
    for(k = 1:1000)
        d = -calculaGradiente(x);
        newtonParaLambda();
        x = x + lambda*d;
    end
    disp(x)
endfunction
////----------------------------- main ------------------------
gradienteDescendente();
