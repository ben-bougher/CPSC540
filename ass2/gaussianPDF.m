function [p] = gaussianPDF(X,mu,Sigma)

[n,d] = size(X);
L = chol(Sigma);
prec = Sigma^-1;
Z = (2*pi)^(d/2)*det(Sigma)^(1/2);
for i = 1:n
    p(i) = exp(-(1/2)*(X(i,:)-mu)*(L\(L'\(X(i,:)-mu)')))/Z;
end