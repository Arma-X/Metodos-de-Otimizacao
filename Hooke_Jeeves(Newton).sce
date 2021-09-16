//                    @ metodo de Hooke-Jeeves  com newton @   
global d;
d = [1, 0; 0, 1];           
global p;
p = [-10, 10];                     
global lamb;
lamb = [2,2]             
N = 2 

function z =f(p)
    z = (p(1)+2)^2+(p(2)-10)^2;
endfunction

function y = flamb(lamb,j)
    global d ;
    y = f([p(1) + lamb*d(j,1) , p(2) + lamb*d(j,2)]);
endfunction 

function y1 = PrimeiraDeriv(j)
    global lamb ;
    h = 1e-6 ;
    y1 = (flamb(lamb(j)+h,j) - flamb(lamb(j),j))/h ;
endfunction

function y2 = SegundaDeriv(j)
    global lamb ;
    h = 1e-3 ;
    y2 = (flamb(lamb(j)+h,j)-2*flamb(lamb(j),j)+flamb(lamb(j)-h,j))/h^2 ;
endfunction

function Newton(j)
    global lamb ;
    for(k = 1:10)
        lamb(j) = lamb(j) - (PrimeiraDeriv(j)/SegundaDeriv(j))
    end
endfunction

function HookJeeves(d,p,lamb)
    global d;
    global p ;
    global lamb ;
    for(k=1:10)
        for(j = 1:N)
           Newton(j);
           for (w=1:N)
               p(w) = p(w) + lamb(j)*d(j,w);
           end
        end
    end
    mprintf("\n O ultimo ponto (x,y) é :");
    mprintf("(%.7f,",p(1));
    mprintf("%.7f)",p(2));
    mprintf("\n valor de f no ponto é : %.6f",f(p))
endfunction
//----------------------------- main ------------------------
HookJeeves(d,p,lamb);
