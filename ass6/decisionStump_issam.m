function [model] = decisionStump_issam(X,y,z)

N = size(X,1);
[X,mu,sigma] = standardizeCols(X);
X = [ones(N,1) X];
d = size(X,2);

step_size = 1;
T = -inf;
best_score = -inf;

for j=1:d
    score = 0;
    max_ = max(X(:, j));
    min_ = min(X(:, j));
    for T=min_:(max_-min_)/10:max_

        weighted_points = z .* X(:,j);
        
        right_side = weighted_points > T;
        left_side = weighted_points <= T;

        score = max(score, sum(y(right_side)==1) + ...
                           sum(y(left_side)==-1));
        
    end
    if best_score < score
       best_T = T;
       best_feature = j;
    end
end    

model.T = best_T;
model.j = best_feature;
model.mu = mu;
model.sigma = sigma;
model.predict = @predict;

end

function [yhat] = predict(model,Xhat)
T = size(Xhat,1);
Xhat = [ones(T,1) standardizeCols(Xhat,model.mu,model.sigma)];
yhat = sign(model.T - Xhat(:, model.j));
end