% Test the neural network on a pattern recognition problem
% HKa april 2003
%Based on code by, Todd K. Moon

%Make some training data
d = [];  x = [];  xl = 0:.1:1;
for i=1:100
  x1 = rand ;  x2 = rand ; xn = [x1;x2];
  if(x1 < .5 & x2 < .5)
    d1 = .8;
  else
     d1=.2;
  end;
  
  d2 = 1-d1;
  d(1,i) = d1;  d(2,i) = d2;
  x = [x xn];
end


% Make some training data
%   d(n)   what we what.
%   x(:,n) what we have.
% % d = [];  x = [];  xl = 0:.1:1;
% % for i=1:100
% %   x1 = rand * 1.4 - .2;  x2 = rand * 1.2; xn = [x1;x2];
% %   if(x1 < 0 | x1 > 1)
% %   d1 = .8;
% %   else
% %   if(x2 > sin(pi*x1)) d1 = .8; else d1 = .2; end
% %   end
% %   d2 = 1-d1;
% %   d(1,i) = d1;  d(2,i) = d2;
% %   x = [x xn];
% % end


% Set up and train the Neural Network
m = [2 5 2];      % numbers of neurons in the layers
mu = .1;  alpha = 0;
[wt,err] = nntrain1(x,d,2,m,mu,alpha,200);
dnew = [];
for xn = x
  dn   = nn1(xn,wt);
  dnew = [dnew dn];
end

% Plot the classification results 
dAll=[dnew;d];
idx1OK    = find(dAll(1,:) >  dAll(2,:) & dAll(3,:) >   dAll(4,:)); 
idx2OK    = find(dAll(1,:) <= dAll(2,:) & dAll(3,:) <=  dAll(4,:));
idx1NotOK = find(dAll(1,:) >  dAll(2,:) & dAll(3,:) <=  dAll(4,:)); 
idx2NotOK = find(dAll(1,:) <= dAll(2,:) & dAll(3,:) >   dAll(4,:));

plot(x(1,idx1OK),x(2,idx1OK),'gx',x(1,idx2OK),x(2,idx2OK),'go',x(1,idx1NotOK),x(2,idx1NotOK),'rx',x(1,idx2NotOK),x(2,idx2NotOK),'ro');
xlabel('x_1'); ylabel('x_2');title('groen<=>OK klassifikation, roed<=>NotOK klassifikation')