function [model] = rbfRegress(X,y,lambda,sigma)

N = size(X,1);

K = rbfKernel(X,X,sigma); % Gram matrix

alpha = (K + lambda*eye(N))\y; % Dual variables

model.X = X;
model.alpha = alpha;
model.sigma = sigma;
model.predict = @predict;

end

function [yhat] = predict(model,X)
K = rbfKernel(X,model.X,model.sigma);
yhat = K*model.alpha;
end