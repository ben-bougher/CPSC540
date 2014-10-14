
% Load data
load basisData.mat
Xtest = [min(X):.1:max(X)]';
T = size(Xtest,1);

% Plot data
figure(1);
title('Training Data');
hold on

for j = 0:8
    
    Xpoly = polyBasis(X,j);
    % Fit least-squares estimator
    w = fitL2(Xpoly,y);

    yHat = zeros(T,1);
    for i = 1:T
        % Draw model prediction
        xtestpoly = polyBasis(Xtest(i),j);
        yHat(i) = xtestpoly*w;
    end
        
  % Plot the data.
  subplot(3, 3, j+1);
  plot(X,y,'b.');
  hold on
  plot(Xtest, yHat, 'r-');
  hold off
end