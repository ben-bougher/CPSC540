clear all
close all

load binary.mat
N = size(X,1);

% Fit Single model
fprintf('Fitting Single model...\n');
z = (1/N)*ones(N,1);
%model = logisticRegress(X,y,z);
model = decisionStump(X,y,z);

% Compute training error
yhat = model.predict(model,X);
trainingError = sum(yhat ~= y)/N

%model.feature
%model.T
% Show data and decision boundaries
plot2DClassifier(X,y,model);
%pause

% Fit Boosted model
fprintf('Fitting boosted model...\n');
nBoosts = 50;
%model = adaBoost(X,y,nBoosts,@logisticRegress);
model = adaBoost(X,y,nBoosts,@decisionStump);

% Compute training error
yhat = model.predict(model,X);
trainingError = sum(yhat ~= y)/N
%figure()
% Show data and decision boundaries
%plot2DClassifier(X,y,model);


