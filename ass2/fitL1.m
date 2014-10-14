function [w] = fitL1(X, y)
    
    % Get the size parameters
    X_size = size(X);
    d = X_size(2);
    y_size = size(y);
    n = y_size(1);

    % use variable names that match the matlab apis
    f = zeros(d + n,1);
    f(d + 1:end) = 1.0;
    
    % lower bound
    lb = zeros(d + n, 1);
    lb(1:d) = -10000000000.0; % large negative number
   

    % our constrained y
    b = ones(2 * n, 1);
    b(1:n) = y;
    b(n+1:end) = -y;
    
    % Make the operator
    A = zeros(2 * n, d +n);
    
    A(1:n, 1:d) = X;
    A(n+1:end, 1:d) = -X;
    A(1:n, d+1:end) = -eye(n);
    A(n+1:end, d+1:end) = -eye(n);
  
  
    w = linprog(f, A,b, [], [], lb, +Inf((d+n),1));
     w = w(1:2); 


