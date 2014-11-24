function [model] = logisticRegress(X,y,z)

N = size(X,1);
[X,mu,sigma] = standardizeCols(X);
X = [ones(N,1) X];
d = size(X,2);

options.useMex = 0;
options.Display = 'none';
w = minFunc(@LogisticLoss,zeros(d,1),options,X,y,z);

model.w = w;
model.mu = mu;
model.sigma = sigma;
model.predict = @predict;

end

function [yhat] = predict(model,Xhat)
T = size(Xhat,1);
Xhat = [ones(T,1) standardizeCols(Xhat,model.mu,model.sigma)];
yhat = sign(Xhat*model.w);
end