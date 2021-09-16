//               @ metodo da seção aurea @ 
function y = f(x)
    y =2*(x+47)+x^2 ;
endfunction

function resultado = Aurea(XH,XL,erro)
    x1 = XH - (XH - XL)*numaur ;
    x2 = XL + (XH - XL)*numaur ;
    while(abs(x1 - x2) > erro)
        x1 = XH - (XH - XL)*numaur ;
        x2 = XL + (XH - XL)*numaur ;
        if(f(x2)>f(x1))
            XH = x2;
        else
            XL = x1; 
        end
     end
     resultado = (x1+x2)/2 ;
     mprintf("\n O resultado é : %.7f",resultado)
     mprintf("\n O valor de f é : %.7f",f(resultado));
endfunction
//-----------------------------main---------------------------
XL = -10;
XH = 10 ;
numaur = 0.618 ;
erro = 0.0000001
Aurea(XH,XL,erro);
