function [w] = fitL2(X,y)
w = (X'*X)\X'*y;

