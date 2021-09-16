//                @ metodo de Rosembrock @ 

global d ;
d = [1,0;0,1];
global p ;
p = [-10,10];
global lamb ;
lamb = [3,3];
N = 2 ;

function z = f(p)
    z = (p(1)+2)^2+(p(2)-10)^2;
endfunction

function y = flamb(lamb,j)
    global d ;
    y = f([p(1)+lamb*d(j,1),p(2)+lamb*d(j,2)])
endfunction

function y1 = PrimeiraDeriv(j)
    global lamb ;
    h = 1e-6 ;
    y1 = (flamb(lamb(j)+h,j) - flamb(lamb(j),j))/h ;
endfunction

function y2 = SegundaDeriv(j)
    global lamb ;
    h = 1e-3 ;
    y2 = (flamb(lamb(j)+h,j) - 2*flamb(lamb(j),j) + flamb(lamb(j)-h , j))/h^2 ;
endfunction

function Newton(j)
    global lamb ;
    for (k=1:10)
        lamb(j) = lamb(j) - (PrimeiraDeriv(j)/SegundaDeriv(j))
    end
endfunction

function rosembrock(d,p,lamb)
    global d ;
    global p ;
    global lamb ;
    for (i=1:10)
        for(j=1:N)
            Newton(j);
            for (w=1:N)
            p(w) = p(w) + lamb(j)*d(j,w);
            end
        end
        //-----------gran schimidt------------//
        for(j = 1:N)               
            a = d(j,:);
            if (lamb(j) ~= 0) then
                a = [0, 0];
                for(i = j:N)
                    a(1) = a(1) + lamb(i)*d(i, 1);
                    a(2) = a(2) + lamb(i)*d(i, 2);
                end
            end
            b = a;
            if (j >= 2) then
                for (i = 1:j-1)
                    produtoEscalar = (a(1)*d(i, 1) + a(2)*d(i, 2));
                    b(1) = b(1) -  produtoEscalar * d(i, 1);
                    b(2) = b(2) -  produtoEscalar * d(i, 2);
                end
            end
            norma = sqrt(b(1)^2 + b(2)^2);
            b = b/norma;
            d(j,:) = b;
        end
        //-----------gran schimidt------------//
    end
    mprintf("\n O ultimo ponto (x,y) é :");
    mprintf("(%.7f,%.7f)",p(1),p(2));
    mprintf("\n O valor de f no ponto é : %.7f",f(p))
endfunction

//----------------------------- main ----------------------
rosembrock(d,p,lamb);
