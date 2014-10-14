function [K] = polyKernel(X1,X2,bias,order)
K = (X1*X2'+bias).^order;