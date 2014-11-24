load mixtureData.mat

[N,D] = size(X);


% number of modes
K = 3;
for k = 1:K
% Fit Model
   models(k) = gaussianMLE(X + randn(N,D));
end

% probability of distribution (start equally probable)
pz = ones(K,1)./K;
px_musig = zeros(N,K);
px = zeros(N,1);

r = zeros(N,K);

for t =1:50
    
    for n =1:N
        for k=1:K
            px_musig(n,k) = models(k).predict(models(k),X(n,:));
            % px(n) = pz(k) * px_musig(n,k);
        end 
    end
    
 
        
    norm = sum(bsxfun(@times,px_musig, pz'),2);
    r = bsxfun(@rdivide,bsxfun(@times,px_musig, pz'), norm);
   
    
    %% Now we update for the next step
    
    pz = sum(r, 1)' / N;
    
    for k = 1:K
        models(k).mu = (sum(bsxfun(@times,r(:,k),X), 1) / sum(r(:,k)))';
        models(k).sigma = sum(bsxfun(@times,r(:,k), bsxfun(@minus,X,models(k).mu').^2)) ...
                                   / sum(r(:,k));
    end
    
end

% Display contours of PDF
plotPDF(X,models);
