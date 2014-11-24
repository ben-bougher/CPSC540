function [model] = decisionStump(X,y,z)
    
    [N,D] = size(X);
 
    model.predict = @predict;
  
    % apply z to the data point
    best_score = -inf;
  
    for n = 1:N
        
        score1 = sum(bsxfun(@times, z(y==1), bsxfun(@ge, X(y==1,:), X(n,:))),1);
        score2 = sum(bsxfun(@times, z(y==-1),bsxfun(@lt, X(y==-1,:), X(n,:))),1);
        

        [score,feature] = max(score1+score2);
        if (score > best_score)
            model.T = X(n, feature);
            model.feature = feature;
            model.score = score;
            model.n = n;
            
            best_score = score;
        end
        
        score1 = sum(bsxfun(@times, z(y==1), bsxfun(@le, X(y==1,:), X(n,:))),1);
        score2 = sum(bsxfun(@times, z(y==-1),bsxfun(@gt, X(y==-1,:), X(n,:))),1);
        

        [score,feature] = max(score1+score2);
        if (score > best_score)
            model.T = X(n, feature);
            model.feature = feature;
            model.score = score;
            model.n = n;
            
            best_score = score;
        end
        
    end    
end

function [yhat] = predict(model, X)
    
%X = standardizeCols(Xhat, model.mu, model.sigma);
    N = size(X,1);
    yhat = zeros(N, 1);

    for i=1:N
        if (X(i, model.feature) > model.T)
            yhat(i) =  -1;
        else
            yhat(i) = 1;
        end
    end
end