function [nll,g,H,T] = LogisticLoss(w,X,y,z)
% w(feature,1)
% X(instance,feature)
% y(instance,1)

[n,p] = size(X);

Xw = X*w;
yXw = y.*Xw;

% Compute NLL(w)
nll = sum(z.*log(1 + exp(-yXw)));
if isinf(nll)
    % Fallback on log-sum-exp trick if you overflow
    nll = sum(z.*mylogsumexp([zeros(n,1) -yXw]));
end

% Comptue gradient of NLL(w)
if nargout == 2
    g = -(X.'*(z.*y./(1+exp(yXw))));
end
