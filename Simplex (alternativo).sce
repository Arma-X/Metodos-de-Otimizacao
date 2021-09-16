////                     @ Método Simplex (alternativo)  @ 
clear;
clc;

function z = f(x)
    z = (44*x-2)^4+(44*x-6+48*x)^2;
endfunction

global v;
v = [5,7;2,1;1,3];
N = 2;
numVertices = N + 1;

function ordenaV() 
    global v;
    for(i = 1:N)
        for(j = i+1:numVertices)
            if f(v(j,:)) < f(v(i,:)) then
                temp = v(i,:);
                v(i,:) = v(j,:);
                v(j,:) = temp;
            end
        end
    end
endfunction

function c = calculaCentroide()
    c = [0, 0];
    for(i = 1:N)
        c = c + v(i,:);
    end
    c = c/N;
endfunction

function vr = reflexao(c, vn)
    vr = c + 1*(c-vn);
endfunction

function ve = expansao(c, vr)
    ve = c + 2*(vr-c);
endfunction

function vc = contracao(c, vn)
    vc = vn + 0.5*(vn-c);
endfunction

function contracaoEncolhida(vl)
    global v;
    for(i = 2:numVertices)
        v(i,:) = vl + 0.5*(v(i,:) - vl);
    end
endfunction

function menor = simplex()
    global v;
    for (k = 1:10)
        ordenaV()
        
        vl = v(1,:)
        vs = v(2,:)
        vn = v(3,:)
        c = calculaCentroide()
        
        vr = reflexao(c, vn)
        if f(vl) <= f(vr) & f(vr) < f(vs) then
            v(numVertices,:) = vr;
        else
            if f(vr) < f(vl) then
                ve = expansao(c, vr)
                if(f(ve) < f(vr)) then
                    v(numVertices,:) = ve;
                else 
                    v(numVertices,:) = vr;
                end
            else
                if f(vs) < f(vr) then
                    vc = contracao(c, vn);
                    if f(vc) < f(vn) then
                        v(numVertices,:) = vc;
                    else
                        contracaoEncolhida(vl);
                    end
                end
            end
        end
    end
    ordenaV()
    menor = v(1,:)
endfunction
// ----------------------------- main ------------------------
disp (simplex())
