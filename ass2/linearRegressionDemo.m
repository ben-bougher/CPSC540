
% Load data
load linearRegressionData.mat

% Plot data
figure(1);
plot(X,y,'b.')
title('Training Data');
hold on
yl = ylim;
xl = xlim;

% Add a bias variable
n = size(X,1);
X = [ones(n,1) X];

% Fit least-squares estimator
z = ones(500,1);
z(400:500) = 1/10.0;
z = diag(z);
wL1 = fitL1(X,y);
wL2 = fitL2(X,y);
wL2_weighted = fitWeightedL2(X,y,z);

% Draw model prediction
plot([0 1],[[1 0]*wL1 [1 1]*wL1],'g-');
plot([0 1],[[1 0]*wL2 [1 1]*wL2],'b-');
plot([0 1],[[1 0]*wL2_weighted [1 1]*wL2_weighted],'r-');

leg1 = legend('training','L1', 'L2', 'Weighted L2');

% Compute test error
T = length(ytest);

Xtest = [ones(T,1) Xtest];
yHat_L1 = Xtest*wL1;
yHat_L2 = Xtest*wL2;
yHat_L2_weighted = Xtest*wL2_weighted;

% Draw test data
figure(2);

title('Testing Data');
hold on


ylim(yl);
xlim(xl);

plot(Xtest(:,2),ytest,'b.');
plot(Xtest(:,2), yHat_L1, 'g-');
plot(Xtest(:,2), yHat_L2, 'b-');
plot(Xtest(:,2), yHat_L2_weighted, 'r-');

leg2 = legend('testing','L1', 'L2', 'Weighted L2');



avgTestErrorL1 = sum((yHat_L1 - ytest).^2)/T
avgTestErrorL2 = sum((yHat_L2 - ytest).^2)/T
avgTestErrorL2_weighted = sum((yHat_L2_weighted - ytest).^2)/T