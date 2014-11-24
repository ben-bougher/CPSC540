

function [model] = matLearn_regression_NW(X,y, options) 
% Uses a kernel function to do a weighted averge KNN-style
% regression
% Options
%    kernel: a kernel function that calculates a weight given the
%    difference between two vectors.
%    h: The bandwidth for the kernel calculation 
% Authors
%  Ben Bougher (2014)


    % Store the data
    model.X = X;
    model.y = y;

    % store the kernel function
    model.kernel = options.kernel;
    
    model.predict = @predict;
    
end

function [yhat] = predict(model, Xhat)
    
    [n_predict,D_predict] = size(Xhat);
    [n_train, D_train] = size(model.X);
    
    yhat = zeros(n_predict,1);
    for pred = 1:n_predict
        for data = 1:n_train
            yhat(pred) = yhat(pred) + ...
                model.y(data)*model.kernel.predict(model.kernel, Xhat(pred,:) - model.X(data,:));
        end
    end
    
    yhat = yhat ./ (n_train);
    
end










            