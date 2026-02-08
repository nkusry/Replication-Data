function RES=quarter(DAT)

[r,c]=size(DAT);
L=reshape(DAT,3,r/3,c);
M=mean(L,1);
RES=shiftdim(M);