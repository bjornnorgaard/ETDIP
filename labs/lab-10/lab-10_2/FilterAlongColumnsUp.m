%Filter along Columns in image and up by 2 along columns
%HKa Feb 2015
function J=FilterAlongColumnsUp(g0, I)

I2=zeros(size(I,1),2*size(I,2));
I2(:,1:2:end)=I;
for r=1:size(I2,1)
    J(r,:)=filter(g0, 1, I2(r,:));
end