function [model] = decisionStump_scott(X,y,z)
  [N, d] = size(X);
  best = -inf;
  
  for T=1:N
    for j=1:d
      % Find weighted prediction rate for -1's and 1's.
      left  = y.*z.*((X(:,j)) <= X(T,j));
      right = y.*z.*((X(:,j)) >  X(T,j));

      prediction = sum(right) + sum(left);

      % Update best prediction feature.
      if (prediction > best)
        best = prediction;
        bestfeature = j;
        model.prediction = prediction;
        model.n = T;
        threshold = X(T,bestfeature);
      end
    end
  end

  model.threshold = threshold;
  model.feature   = bestfeature;
  model.predict   = @predict;
end

function [yhat] = predict(model,X)
  N = size(X,1);
  yhat = zeros(N, 1);

  for i=1:N
    if (X(i, model.feature) > model.threshold)
      yhat(i) =  1;
    else
      yhat(i) = -1;
    end
  end
end