clear all
close all

load polyData.mat
N = size(X,1);

plot(X,y,'b.');hold on
yl = ylim;

lambda = 1e-4;
sigma = .5;

nBootstraps = 100;
Xhat = [-5:.1:5]';
for j = 1:nBootstraps
    for i = 1:N
        ind = randi(100);
        Xbs(i,:) = X(ind,:);
        ybs(i,1) = y(ind);
    end
    
    model = rbfRegress(Xbs,ybs,lambda,sigma);
    
    yhat(:,j) = model.predict(model,Xhat);
    
    plot(Xhat,yhat(:,j),'y');
    plot(X,y,'b.');
    ylim(yl);
end
plot(X,y,'b.');
plot(Xhat,mean(yhat,2),'g','LineWidth',2);
ylim(yl);