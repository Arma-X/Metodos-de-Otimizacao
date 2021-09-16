//               @ metodo de Hooke-Jeeves  com seção aurea @ 
clear;
clc ;
global d ;
d = [1,0;0,1] ;
global p ;
p = [10,-10];
global lamb ;
lamb = [2,2] ;
N = 2 ;

function z = f(p)
    z = (p(1)+2)^2+(p(2)-10)^2  ;
endfunction

function y = flamb(lamb,j)
    global d ;
    y = f([p(1)+lamb*d(j,1),p(2)+lamb*d(j,2)]);
endfunction

function Aurea(xl,xh,j)
    global lamb ;
    global d ;
    x1 = xh - (xh - xl)*0.618;
    x2 = xl + (xh - xl)*0.618;
    while(abs(x2-x1)>1e-10)
        x1 = xh - (xh - xl)*0.618;
        x2 = xl + (xh - xl)*0.618;
        if(flamb(x2,j)>flamb(x1,j))
            xh = x2 ;
        else
            xl = x1;
        end
    end
    lamb(j) = (x1+x2)/2 ;         
endfunction

function Rookjeeves(d,p,lamb)
    global d ;
    global p ;
    global lamb ;
    for (i=1:10)
        for(j=1:N)
            Aurea(xl,xh,j);
            //Newton(j);
            for (w=1:N)
            p(w) = p(w) + lamb(j)*d(j,w);
            end
        end
    end
    mprintf("\n O ultimo ponto é : ")
    mprintf("(%.7f,%.7f)",p(1),p(2));
    mprintf("\n O valor de f no ponto é : %.7f",f(p))
    
endfunction
//----------------------------- main ------------------------
xl = -1000 ;
xh = 5000 ;
Rookjeeves(d,p,lamb);
