function [f,sg] = SVMLoss(w,X,y)
% w(feature,1)
% X(instance,feature)
% y(instance,1)

[n,p] = size(X);

Xw = X*w;
yXw = y.*Xw;

err = 1-yXw;
SV = find(err > 0);

f = sum(err(SV));
sg = 


