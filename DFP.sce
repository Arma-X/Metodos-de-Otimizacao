//                  @ metodo Davidon-Fletcher-Powell (DFP) @ 
global d;
global x;
x = [-5,-5];
global lamb;
lamb = 1 ;
global N ;
N = 2 ;
global p ;
global q ;

function z =f(x)
    z = ((x(1)-5)^2 +(x(2)-350)^4) ;
endfunction

function dfdx = derivadaParcial_x(x)
   h = 1e-6 ;
   h2 = [h, 0] ;
   dfdx = (f(x+h2)-f(x))/h
endfunction

function dfdy = derivadaParcial_y(x)
    h = 1e-6 ;
    h2 =[0, h] ;
    dfdy = (f(x+h2)-f(x))/h 
endfunction

function result = gradiente(x)
    result = [derivadaParcial_x(x),derivadaParcial_y(x)] ;
endfunction

function y = flamb(lamb)
    global d ;
    global x ;
    y = f(x + lamb*d);
endfunction

function y1 = primeiraDerivada()
    global lamb; 
    h = 1e-6 ;
    y1 = (flamb(lamb+h)-flamb(lamb))/h
endfunction

function y2 = segundaDerivada()
    global lamb ;
    h = 1e-3 ;
    y2 = (flamb(lamb+h)-2*flamb(lamb)+flamb(lamb-h))/h^2 ;
endfunction

function Newton(lamb)
    global lamb ;
    for (i=1:100)
        lamb = lamb -(primeiraDerivada()/segundaDerivada())
    end
endfunction
function DFP()
    global lamb ;
    global p ; 
    global d ;
    global x ;
    global q ;
    for(k=1:100)
        q = gradiente(x)';
        for(j=1:N)
            D = [1,0;0,1];
            if(j==2)
                q = gradiente(x)' - q ;
                p = (lamb*d)' ;
                D = D + ((p*p')/(p'*q)) - ((D*q*q'*D)/(q'*D*q)) ;
            end
             d = (-D*gradiente(x)')' ;
             Newton(lamb);
             x = x +lamb*d        
        end
    end
        mprintf("\n O ultimo Ponto é : (%.7f,%.7f)",x(1),x(2));
        mprintf("\n O valor de f no ponto é : %.7f",f(x));
endfunction

//--------------------------------main------------------------------
DFP() ;
