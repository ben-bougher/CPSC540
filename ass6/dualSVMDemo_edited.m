X = load('statlog.heart.data');
b = X(:,end);
b(b==2) = -1;
A = X(:,1:end-1);
N = size(A,1);

% Add bias and standardize
A = [ones(N,1) standardizeCols(A)];
d = size(A,2);

% Set regularization parameter
lambda = 1;

% Initialize dual variables
y = zeros(N,1);

% Some values used by the dual
bA = diag(b)*A;
G = bA*bA';
 
% Convert from dual to primal variables
x = (1/lambda)*(bA'*y);

% Evaluate primal objective:
P = sum(max(1-b.*(A*x),0)) + (lambda/2)*(x'*x)

old_D = -inf
for iter=1:2000
    % Run coordinate ascent
    for i = 1 : N 
       G_other = G(i,:);
       y_other = y;

       % Delete elements corresponding to y_i
       G_other(i) = [];
       y_other(i) = [];

       tmp = (lambda - G_other * y_other) / G(i,i);

       % clip values between 0 and 1
       if tmp > 1
           tmp = 1;
       elseif tmp <0
           tmp = 0;
       end

       y(i) = tmp;
       % Evaluate dual objective:


    end
   D =   sum(y) - (y'*G*y)/(2*lambda)
   if old_D == D
       fprintf('converged!');
       break
   end
   old_D = D;
   
end 
x = (bA' *y)/lambda;
P = sum(max(1-b.*(A*x),0)) + (lambda/2)*(x'*x)