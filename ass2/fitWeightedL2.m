function [w] = fitWeightedL2(X, y, z)
% z is the weights
    w = (X'*z*X)\(X'*z*y);
