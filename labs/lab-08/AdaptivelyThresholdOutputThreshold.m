%Adaptive threshoding
%Used in lab 8_1
%HKa oct. 2008
function J=AdaptivelyThreshold(I)
%Adaptiv threshold        
T=.5;
a=1;
while (a)
    s1=find(I<=T);
    my1=mean(I(s1));
    s2=find(I>T);
    my2=mean(I(s2));
    T1=(1/2)*(my1+my2);
    if (abs(T1-T)<.0001) a=0; end;
    T=T1;
end;
J=T*ones(size(I));
