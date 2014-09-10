%% Load Data
load('data.mat') % Loads {X,y,Xtest,ytest,groupnames,wordlist}
[N,P] = size(X);
C = max(y);

%% Train extra-naive Bayes
p_y = zeros(4,1); % We will store the probability of each class, p(y=c), in this vector
for c = 1:C
    p_y(c) = sum(y==c)/N;
end

%% Test extra-naive Bayes
T = size(X,1);
yhat = zeros(T,1); % This will be our predictions
for i = 1:T
    prob = p_y; % Extra-naive Bayes method ignores the features and just uses the class prior
    [maximumProb,maximumIndex] = max(prob);
    yhat(i) = maximumIndex;
end
testError = sum(yhat ~= ytest)/T