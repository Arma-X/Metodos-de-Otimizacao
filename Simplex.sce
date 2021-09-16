////                     @ Método Simplex  @ 
clc;
clear;

p = [2;3];
q = [3;2];
r = [1;4];

global c;
global b;
global g;
global w;
c = [0;0];
b = p;
g = q;
w = r;

function y=f(p)
//    y = (p(2)^2)/4 + (p(1)^2)/9;
  y = (p(1)+2)^2+(p(2)-10)^2;
endfunction

function y=func(x1,x2)
    y=(x1-2)^4 + (x1 - 2*x2)^2;
endfunction

function ordena(p,q,r)
    global b;
    global g;
    global w;
    
    if ((f(p) < f(q)) & f(p) < f(r)) then
        if (f(q) < f(r)) then
            b = p;
            g = q;
            w = r;
        else
            b = p;
            g = r;
            w = q;
        end
    elseif ((f(q) < f(p)) & f(q) < f(r)) then
        if (f(p) < f(r)) then
            b = q;
            g = p;
            w = r;
        else
            b = q;
            g = r;
            w = p;
        end
    elseif ((f(r) < f(p)) & f(r) < f(q)) then
        if (f(p) < f(q)) then
            b = r;
            g = p;
            w = q;
        else
            b = r;
            g = q;
            w = p;
        end
    end
endfunction

function centroide(p,q)
    global c;
    c(1) = (p(1)+q(1))/2;
    c(2) = (p(2)+q(2))/2;
endfunction

function r=reflexao()
    global c;
    global b;
    global g;
    global w;
    
    centroide(b,g);
    
    r = c+(c-w);
endfunction

function e=expansao()
    global c;
    global b;
    global g;
    global w;
    
    centroide(b,g);
    
    e=c+2*(c-w);
endfunction

function con=contracao()
    global c;
    global b;
    global g;
    global w;
    
    centroide(b,g);
    
    con=c+0.5*(c-w);
endfunction

function encolher()
    global c;
    global b;
    global g;
    global w;
    
    centroide(b,g);
    g = b + 0.5*c;

    centroide(b,w);
    w = b + 0.5*c;
endfunction

function simplex()
    global c;
    global b;
    global g;
    global w;

    n = 10000;
    i=1;
    while (i<n)
        ordena(b,g,w);
        reflete = reflexao();
        if(f(reflete)>f(b)&f(reflete)<f(g))
             w = reflete;
        end      
        if( f(reflete) <= f(b) ) then
            expande = expansao();
            if ( f(expande) < f(reflete) ) then
                w = expande;
            else
                w = reflete;
            end
        end
        if( f(reflete)>f(w)) then
            contrai = contracao();
            if ( f(contrai) < f(w) ) then
                w = contrai;
            else
                encolher();
            end
        end
        i = i + 1;
    end
    ordena(b,g,w);
endfunction
// ----------------------------- main ------------------------
simplex();
mprintf("(%.7f,%.7f)", b(1),b(2));






















