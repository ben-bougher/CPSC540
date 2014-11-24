clear
load mixtureData.mat

[N, n_features] = size(X);
D = n_features;
% Not working yet
% Fit Model
models =  [gaussianMLE(X+ randn(N,D)), gaussianMLE(X+ randn(N,D)), ...,
           gaussianMLE(X+ randn(N,D))];

K = 3;

% P(Z=k|xi) = P(xi|Z=k) * P(Z=k) / sum_k(P(xi|Z=k)P(Z=k)) 
p_Z_x = zeros(N, K);
p_x_Z = zeros(N, K);
P_Z = zeros(K);
P_Z(:) = 1/K;

for iter=1:100
    % Step 1 - Expectation
    for i=1:N
        for k=1:K
            % compute liklihood P(xi|Z=k) 
            p_x_Z(i, k) =  models(k).predict(models(k), X(i, :));        
        end
    end

    for i=1:N
        for k=1:K
            % compute membership 
            % P(Z=k | xi) = P(xi|Z=k) * P(Z=k) / sum_k(P(xi|Z=k)P(Z=k)
            p_Z_x(i, k) =  p_x_Z(i, k) .* P_Z(k) ./ sum(p_x_Z(i, :) * P_Z);         
        end
    end
    
    % Step 2 - Maximization
    for k=1:K
        % update prior
        N_k = sum(p_Z_x(:, k),1);
        P_Z(k) = N_k / N;
        % update mean = sum_i ( P(Z=k | xi) * xi) / sum_i ( P(Z=k | xi))
        models(k).mu = zeros(n_features, 1);
        for i=1:N
            models(k).mu = models(k).mu + p_Z_x(i, k) * X(i, :)';
        end
        models(k).mu = models(k).mu / N_k;
        % update covariance 
        % = sum_i ( P(Z=k | xi) * (xi - mean^2)) / sum_i ( P(Z=k | xi))
        models(k).sigma = zeros(n_features, n_features);
        for i=1:N
            spread = (X(i,:) - models(k).mu'); 
            models(k).sigma = models(k).sigma + ... 
                             p_Z_x(i, k) * (spread' * spread);                 
        end
        models(k).sigma = models(k).sigma / N_k;
    end
end
% Display contours of PDF
plotPDF(X,models);