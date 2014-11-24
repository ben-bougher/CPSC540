rand('state',0);
randn('state',0);
load uspsData.mat % Loads data {X,y}
[N,d] = size(X);
nLabels = max(y);
yExpanded = linearInd2Binary(y,nLabels);
T = size(Xtest,1);

% Standardize columns and add bias
[X,mu,sigma] = standardizeCols(X);
X = [ones(N,1) X];
d = d + 1;

% Make sure to apply the same transformation to the test data
Xtest = standardizeCols(Xtest,mu,sigma);
Xtest = [ones(T,1) Xtest];

% Choose network structure
nHidden = [10];

% Count number of parameters and initialize weights 'w'
nParams = d*nHidden(1);
for h = 2:length(nHidden)
    nParams = nParams+nHidden(h-1)*nHidden(h);
end
nParams = nParams+nHidden(end)*nLabels;
w = randn(nParams,1);

% Train with stochastic gradient
maxIter = 100000;
stepSize = 1e-3;
funObj = @(w,i)MLPclassificationLoss(w,X(i,:),yExpanded(i,:),nHidden,nLabels);
for t = 1:maxIter
    if mod(t-1,round(maxIter/100)) == 0
        yhat = MLPclassificationPredict(w,Xtest,nHidden,nLabels);
        fprintf('Training iteration = %d, test error = %f\n',t-1,sum(yhat~=ytest)/T);
    end
    
    i = ceil(rand*N);
    [f,g] = funObj(w,i);
    w = w - stepSize*g;
end