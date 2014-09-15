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

% For normalizing
if alpha > 0
    class_norm = C;
else
    class_norm = 0.0;
end


%% Populate the probabilities
for c = 1:C
    % probability of the class p(c)
    p_y(c) = sum(y==c)/N;
    
    % probability of finding each feature in the class p(fi|c)
    class_vectors = X(y==c,:);
    
    % alpha parameter is for dirichlet distribution
    p_fc(c,:) = (sum(class_vectors, 1) + alpha)/(sum(y==c) + class_norm);
end




%% Test extra-naive Bayes
T = size(Xtest,1);
yhat = zeros(T,1); % This will be our predictions

for i = 1:T
    
    % pull out the ith test feature vector
    vec = Xtest(i,:);
    
    % initialize a probability vector
    prob = zeros(4,1);
    
    % find the probability of each class p(f|c)*p(c)
    for c = 1:C
        p_fnc = zeros(P,1);
        
        % probably of having the feature and not having a feature
        p_fnc(vec==1) = p_fc(c, vec==1);
        p_fnc(vec==0) = 1 - p_fc(c, vec==0);
    
        % p(f|c)*p(c) 
        % because naive bayes assumes independence, we can just multiply
        % each p(fi|c) to get p(f|c). cumprod should be faster than a loop.
        p_fnc = cumprod(p_fnc);
        
        % p(c|f) = p(f|c)*p(c)
        prob_fc = p_fnc(end) * p_y(c); 
        
        % update the likelihood vector
        prob(c) = prob_fc;
    end
    
    % maximum likelihood
    [max_prob, best_class] = max(prob);
    yhat(i) = best_class;
      
end
testError = sum(yhat ~= ytest)/T;


%% Ten most predictive words for each class
best_words = containers.Map;
for i = 1:C
    
    % Not sure about this method. We use both the positive and
    % negative probabilities when classifying, so I considered
    % the negative probability in finding the most predictive
    % words.
    [sorted, index] = sort(max(p_fc(i,:), 1-p_fc(i,:)), 'descend');
    name = char(groupnames{i});
    splitted = strsplit(name,'.');
    best_words(splitted{1}) = wordlist(index(1:10));
end

    


