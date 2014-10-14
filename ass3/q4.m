
% Load data
warning off all
close all
clear all
load kernelData.mat
[N,d] = size(X);

% Make the play data set
X_train = X(1:N/2);
X_test = X(N/2 +1:end);
y_train = y(1:N/2);
y_test = y(N/2+1:end);


% Display result of fitting with polynomial kernel
lambda = 1;
bias = 1;
max_fit = 15;
poly_errors = zeros(max_fit,1);
for m = 0:max_fit
    %% Train on X, test on X (with given m)
    yhat = polyKernel(X_test,X_train,bias,m)*((polyKernel(X_train,X_train,bias,m) + lambda*eye(N/2))\y_train);
    poly_errors(m+1) = sum((yhat-y_test).^2);
    
end

[error, order] = min(poly_errors);
order = order-1;
% on the real data
yhat = polyKernel(Xtest,X_train,bias,order)*((polyKernel(X_train,X_train,bias,order) + lambda*eye(N/2))\y_train);
fprintf('polyfiterror for order: %d = %f\n', order, sum((yhat-ytest).^2));

min_error = Inf;

% Display result of fitting with RBF kernel
for sigma = 2.^[3:-1:-7]
    for lambda = 2.^[2:-1:-12]
        %% Train on X, test on Xtest (with given lambda,sigma)
        yhat = rbfKernel(X_test,X_train,sigma)*((rbfKernel(X_train,X_train,sigma) + lambda*eye(N/2))\y_train);
        error = sum((yhat-y_test).^2);
        if error < min_error
            min_error = error;
            sig_lam = [sigma, lambda];
        end
        
        
        
    end
end

yhat = rbfKernel(Xtest,X_train,sig_lam(1))*((rbfKernel(X_train,X_train,sig_lam(1)) + sig_lam(2)*eye(N/2))\y_train);

fprintf('sigma, lambda, error = %f, %f, %f', sig_lam(1), sig_lam(2),sum((yhat-ytest).^2));


