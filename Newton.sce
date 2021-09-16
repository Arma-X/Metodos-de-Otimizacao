//                    @ metodo de Newton @       
function y = f(x)
    y = 2*(x+47)+x^2 ;
endfunction

function y1 = PrimeiraDeriv(x)
    h = 1e-6 ;
    y1 = (f(x + h)-f(x))/h;
endfunction

function y1 = SegundaDeriv(x)
    h = 1e-3 ;
    y1 = (f(x + h)-2*f(x) + f(x - h))/(h^2);
endfunction

function resultado = Newton(x0,erro)
    x1 = x0 - (PrimeiraDeriv(x0)/SegundaDeriv(x0));
    while(abs(x0 - x1)> erro)
        x0 = x1 ;
        x1 = x0 - (PrimeiraDeriv(x0)/SegundaDeriv(x0));
    end
    resultado = x1 ;
     mprintf("\n O resultado é : %.7f ",resultado)
     mprintf("\n O valor de f é : %.7f",f(resultado)) 
endfunction

// ----------------------------- main ------------------------
x = -3 ;
erro = 0.01 ;
Newton(x , erro )
