%Filter along Columns i image and downsample by 2 along columns
%HKa Feb. 2015
function J=FilterAlongColumnsDown(h0, I)

for r=1:size(I,1)
    l=filter(h0, 1, I(r,:));
    dl=l(1:2:end);
    J(r,:)=dl;
end