function [model] = gaussianMLE(X)
% w = generativeGaussian(X,options)
%
% Computes Generative Gaussian Parameters

[N,d] = size(X);

mu = mean(X,1)';
sigma = cov(X)+1e-8*eye(d); % Modify to be positive definite

model.mu = mu;
model.sigma = sigma;
model.predict = @predict;
end

function [lik] = predict(model,X)
mu = model.mu;
sigma = model.sigma;
lik = mvnpdf(X,mu',sigma);
end