clear
clc
//                    @ metodo de newton (multivariável) @  
global x;
x = [0 3];

function z = f(p)
    z = (p(1)-2)^4 + (p(1)-2*p(2))^2;
endfunction

function resp = dfdx(p)
    h = 0.0000001;
    h2= [h, 0];
    resp = (f(p+h2)-f(p))/h;
endfunction

function resp = dfdy(p)
    h = 0.0000001;
    h2= [0, h];
    resp = (f(p+h2)-f(p))/h;
endfunction

function resp = calculaGradiente(p)
   resp = [dfdx(p), dfdy(p)];
endfunction

function resp = d2fdxdx(p)
    h = 0.00001;
    h2= [h, 0];
    resp = (dfdx(p+h2)-dfdx(p))/h;
endfunction

function resp = d2fdydy(p)
    h = 0.00001;
    h2= [0, h];
    resp = (dfdy(p+h2)-dfdy(p))/h;
endfunction

function resp = d2fdxdy(p)
    h = 0.00001;
    h2= [h, 0];
    resp = (dfdy(p+h2)-dfdy(p))/h;
endfunction

function resp = d2fdydx(p)
    h = 0.00001;
    h2= [0, h];
    resp = (dfdx(p+h2)-dfdx(p))/h;
endfunction

function resp = calculaHessiana(p)
    resp = [d2fdxdx(p), d2fdxdy(p); d2fdydx(p), d2fdydy(p)];
endfunction

function newtonMultivariavel()
    global x;
    
    for(k = 1:1000)
        x = (x' -inv(calculaHessiana(x))*calculaGradiente(x)')';
    end
    disp(x)
endfunction

////----------------------------- main ------------------------
newtonMultivariavel()
