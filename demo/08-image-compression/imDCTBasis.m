%DCT basis
%See GW3e fig. 8.23 p.569
%HKa Feb. 2015


clear, close all;

N=4;
Z=zeros(N,N);
DCTM=dct(eye(N))%DCT-transformation
for r=1:N
    for s=1:N
        Irs=Z;
        Irs(r,s)=1;
        J=DCTM'*Irs*DCTM;
        str=strcat('DCT basis, r =',num2str(r),', s = ',num2str(s));
        imagesc(J);colormap(gray(256));title(str)
        pause(2)
    end
end
