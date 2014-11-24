function [nll,g,H,T] = LogisticLoss(w,X,y, lambda)
% w(feature,1)
% X(instance,feature)
% y(instance,1)

[n,p] = size(X);

Xw = X*w;
yXw = y.*Xw;

% Compute NLL(w)
nll = sum(log(1 + exp(-yXw))) + (.5*lambda*w'*w);
if isinf(nll)
    % Fallback on log-sum-exp trick if you overflow
    nll = sum(mylogsumexp([zeros(n,1) -yXw]) + (0.5*lambda*w'*w));
end

% Comptue gradient of NLL(w)
if nargout == 2
    g = -(X.'*(y./(1+exp(yXw)))) + (lambda*w);
end

% Compute gradient and Hessian of NLL(w)
if nargout == 3
    sig = 1./(1+exp(-yXw));
    g = -X.'*(y.*(1-sig));
    H = X.'*diag(sparse(sig.*(1-sig)))*X + (lambda);
end
