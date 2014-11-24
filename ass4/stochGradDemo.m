% Load training data {X,y}
load('rcv1_train.binary.mat')

% Set the regularization parameter on the average loss to 1/N
lambda = 1/N;

% Add a bias variable
N = size(X,1);
X = [ones(N,1) X];

% Initial value of w
d = size(X,2);
w = zeros(d,1);

% Evaluate function and gradient at initial point
f = (1/N)*sum(max(0,1-y.*(X*w))) + (lambda/2)*(w'*w);
fprintf('Initial function value: %f\n',f);

% Matlab stores sparse vectors as columns, so when accessing individual
% rows it is much faster to work with X^T
Xt = X';


% Try to optimize with 50000 iterations of stochastic gradient
maxIter = 50000;
for t = 1:maxIter
    % Choose a random integer between 1 and N
    i = ceil(N*rand); 
    
    % Compute a subgradient with respect to example i
    if 1-y(i)*(w'*Xt(:,i)) > 0
        sg = -y(i)*Xt(:,i) + lambda*w;
    else
        sg = lambda*w;
    end
    
    % Choose step-size
    alpha = 1/(lambda*t);
    
    % Update parameters
    w = w - alpha*sg;
end

% Evaluate function and gradient at final point
f = (1/N)*sum(max(0,1-y.*(X*w))) + (lambda/2)*(w'*w);
fprintf('Final function value: %f\n',f);