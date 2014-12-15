%% Load Data
load('labeled_dat.mat') % Loads
                        % {X,y,Xtest,ytest,groupnames,wordlist}

%X = X(:,10:25);
%Xtest = Xtest(:,10:25);

[N,P] = size(X);



C = max(y);

% No need to train, simply storing X and y is training

% Find the euclidean distance for all of the test vectors
closeness = X.^2*ones(P,N) + ones(N,P)*(Xtest').^2 - 2*X*Xtest';


classifications = zeros(N,10);
test_error = zeros(10,1);
for k = 1:10
    
    for i=1:N
        
        % could have called sort outside of the loop, which should be faster,
        % but I wanted to explicitly track the indices
        [sorted, index] = sort(closeness(:,i), 'ascend');
        values = y(index(1:k));
        class = mode(values);
        classifications(i,k) = class;
    end
    
    test_error(k) = sum(classifications(:,k) == ytest)/N; 
end


testError = test_error;



    


