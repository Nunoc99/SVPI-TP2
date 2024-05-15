function M=autobin(I)

t = graythresh(I);
M = I > t;

Atotal = size(I,1)*size(I,2);
Abrancos = nnz(M);
% Apretos = Atotal - Abrancos;
Apretos = nnz (not(M));

if Abrancos > Apretos
    M = not(M);
end