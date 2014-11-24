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


for iter = 1 : 1000

    for i =1:N
    
        % Get the vector product where i ne j
        g = G(i,:);
        gii = G(i,i);
        gy = (g*y) - gii*y(i);
        yi = (lambda - gy) / gii;
    
       
        if yi > 1
            yi = 1;
        elseif yi < 0
            yi = 0;
        end 
    
        y(i) = yi;

    end
            
    % Evaluate dual objective:
    D = sum(y) - (y'*G*y)/(2*lambda)
end

% Convert from dual to primal variables
x = (1/lambda)*(bA'*y);



% Evaluate primal objective:
P = sum(max(1-b.*(A*x),0)) + (lambda/2)*(x'*x)