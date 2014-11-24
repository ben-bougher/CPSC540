% Load training data {X,y}
load('rcv1_train.binary.mat')

% Add a bias variable
N = size(X,1);
X = [ones(N,1) X];

% Initial value of w
d = size(X,2);
w = zeros(d,1);

% Lambda value
lambda = 0.5;

% Evaluate function and gradient at initial point
[f,g] = LogisticLoss(w,X,y, lambda);
fprintf('Initial function value: %f\n',f);

% Always check your gradient code first!
% We will look at the first 25 elements of the gradient vector
wTest = randn(25,1);
[f,g] = LogisticLoss(wTest,X(:,1:25),y, lambda);
[f,g2] = autoGrad(wTest,@LogisticLoss,X(:,1:25),y, lambda);
maxDiff = fprintf('Maximum difference between user and numerical gradient: %f\n',norm(g-g2,'inf'));
pause

% Try to optimize
w = findMin(@LogisticLoss,w,500,X,y, lambda);

% Evaluate function and gradient at final point
[f,g] = LogisticLoss(w,X,y, lambda);
fprintf('Final function value: %f\n',f);