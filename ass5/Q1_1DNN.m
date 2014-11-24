load nnetData.mat % Loads data {X,y}
[N,d] = size(X);

% Add bias
X = [ones(N,1) X];
d = d + 1;

% Choose network structure
nHidden = [3,7];

% Count number of parameters and initialize weights 'w'
nParams = d*nHidden(1);
for h = 2:length(nHidden)
    nParams = nParams+nHidden(h-1)*nHidden(h);
end
nParams = nParams+nHidden(end);
w = randn(nParams,1);

% Train with stochastic gradient
maxIter = 100000;
stepSize = 1e-2;
funObj = @(w,i)MLPregressionLoss(w,X(i,:),y(i),nHidden);

old_misfit = 1
for t = 1:maxIter
    if mod(t-1,round(maxIter/100)) == 0
        fprintf('Training iteration = %d\n',t-1);
        
        % Plot results
        figure(1);clf;hold on
        Xhat = [-5:.05:5]';
        Xhat = [ones(size(Xhat,1),1) Xhat];
        yhat = MLPregressionPredict(w,Xhat,nHidden);
        plot(X(:,2),y,'.');
        h=plot(Xhat(:,2),yhat,'g-');
        set(h,'LineWidth',3);
        legend({'Data','Neural Net'});    
        drawnow;
        
    end
    

    
    
    
    i = ceil(rand*N);
    [f,g] = funObj(w,i);
    
    if isfinite(f)
        new_misfit = f;
    
        progress = new_misfit/old_misfit;
        
        
        stepSize = stepSize*new_misfit/old_misfit;
        
        
    

        old_misfit = f;
    end
    w = w - stepSize*g;
end