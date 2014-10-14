
% Load data
warning off all
close all
clear all
load kernelData.mat
[N,d] = size(X);

% Plotting Code
plot(X,y,'b.');hold on
plot(Xtest,ytest,'g.');
xl = xlim;
yl = ylim;
Xvals = [xl(1):.1:xl(2)]';
pause

% Display result of fitting with polynomial kernel
lambda = 1;
bias = 1;
for m = 0:15
    %% Train on X, test on Xtest (with given m)
    yhat = polyKernel(X(1:N/2),X(51:end),bias,m)*((polyKernel(X(1:50),X(1:50),bias,m) + lambda*eye(50))\y(1:50));
    fprintf('Test error with order %d = %f\n',m,sum((yhat-y(51:end)).^2));
    
    
    %% Plotting Code
    figure(1);clf;
    plot(X,y,'b.');hold on
    plot(Xtest,ytest,'g.');
    yvals = polyKernel(Xvals,X,bias,m)*((polyKernel(X,X,bias,m) + lambda*eye(N))\y);
    plot(Xvals,yvals,'r-');
    legend({'Train','Test'});
    ylim(yl);
    title(sprintf('Polynomial Kernel (order = %d, lambda =%f)',m,lambda));
    pause
end

% Display result of fitting with RBF kernel
for sigma = 2.^[3:-1:-7]
    for lambda = 2.^[2:-1:-12]
        %% Train on X, test on Xtest (with given lambda,sigma)
        yhat = rbfKernel(Xtest,X,sigma)*((rbfKernel(X,X,sigma) + lambda*eye(N))\y);
        fprintf('Test error with lambda = %f and sigma = %f is %f\n',lambda,sigma,sum((yhat-ytest).^2));
        
        
        %% Plotting Code
        figure(1);clf;
        plot(X,y,'b.');hold on
        plot(Xtest,ytest,'g.');
        yvals = rbfKernel(Xvals,X,sigma)*((rbfKernel(X,X,sigma) + lambda*eye(N))\y);
        plot(Xvals,yvals,'r-');
        legend({'Train','Test'});
        ylim(yl);
        title(sprintf('RBF Kernel (sigma = %f, lambda =%f)',sigma,lambda));
        pause
    end
end