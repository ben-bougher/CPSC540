alpha = 0.0; % dirichlet value

%% Load Data
load('data.mat') % Loads {X,y,Xtest,ytest,groupnames,wordlist}
[N,P] = size(X);
C = max(y);

%% Train extra-naive Bayes
p_y = zeros(4,1); % We will store the probability of each class, p(y=c), in this vector

% Make the probability matrix that will define the probably of each feature
% being in each class
p_fc = zeros(C,P);

%% Populate the probabilities
for c = 1:C
    % probability of the class p(c)
    p_y(c) = sum(y==c)/N;
    
    % probability of finding each feature in the class p(fi|c)
    class_vectors = X(y==c,:);
    p_fc(c,:) = (sum(class_vectors, 1) + alpha)/(sum(y==c) + C);
end


%% Test extra-naive Bayes
T = size(Xtest,1);
yhat = zeros(T,1); % This will be our predictions

for i = 1:T
    
    % pull out the ith test feature vector
    vec = Xtest(i,:);
    prob = zeros(4,1);
    
    % find the probability of each class p(f|c)*p(c)
    for c = 1:C
        p_fnc = zeros(P,1);
        
        % probably of having the feature and not having a feature
        p_fnc(vec==1) = p_fc(c, vec==1);
        p_fnc(vec==0) = 1 - p_fc(c, vec==0);
    
        % p(f|c)*p(c) 
        % because naive bayes assumes independence, we can just multiply
        % each p(fi|c) to get p(f|c)
        p_fnc = cumprod(p_fnc);
        
        % p(c|f) = p(f|c)*p(c)
        prob_fc = p_fnc(end) * p_y(c); 
        
        % update the maximum likelihood
        prob(c) = prob_fc;
    end
    
    [max_prob, best_class] = max(prob);
    yhat(i) = best_class;
      
end
testError = sum(yhat ~= ytest)/T;


%% Ten most predictive words for each class
best_words = containers.Map;
for i = 1:C
    [sorted, index] = sort(max(p_fc(i,:), 1-p_fc(i,:)), 'descend');
    name = char(groupnames{i});
    splitted = strsplit(name,'.');
    best_words(splitted{1}) = wordlist(index(1:10));
end

    


