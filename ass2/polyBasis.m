function [Xpoly] = polyBasis(X,degree)

[n,d] = size(X);
    
Xpoly = zeros(n, degree);

for j = 1:degree+1
    
    Xpoly(:, j) = X.^(j-1);
end
