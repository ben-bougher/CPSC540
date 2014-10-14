%% Load Data
load gaussianDemoData.mat

% Setup the axis and points at which we will evaluate the contour
axisLimits = [-3 9];
[xPos,yPos] = meshgrid([-3:.25:9]);
close all

%% First row (fit identity matrix times scalar covariance)

% Fit X1
[n,d] = size(X1);
mu = sum(X1)/n;
sigma = sum(sum((X1-repmat(mu,[n 1])).^2))/(n*d);
Sigma = sigma*eye(2);
% Plot Data
subplot(3,2,1);
plot(X1(:,1),X1(:,2),'b.');
xlim(axisLimits);
ylim(axisLimits);
% Draw Contour
hold on
pdfVals = gaussianPDF([xPos(:) yPos(:)],mu,Sigma);
contour(xPos,yPos,reshape(pdfVals,size(xPos)));

% Fit X2
[n,d] = size(X2);
mu = sum(X2)/n;
sigma = sum(sum((X2-repmat(mu,[n 1])).^2))/(n*d);
Sigma = sigma*eye(2);
% Plot Data
subplot(3,2,2);
plot(X2(:,1),X2(:,2),'b.');
xlim(axisLimits);
ylim(axisLimits);
% Draw Contour
hold on
pdfVals = gaussianPDF([xPos(:) yPos(:)],mu,Sigma);
contour(xPos,yPos,reshape(pdfVals,size(xPos)));


%% Second row (fit diagonal covariance)

% Fit X1
sigma = var(X1,0,1);
Sigma = diag(sigma);

% Plot Data
subplot(3,2,3);
plot(X1(:,1),X1(:,2),'b.');
xlim(axisLimits);
ylim(axisLimits);


% Draw Contour
hold on
pdfVals = gaussianPDF([xPos(:) yPos(:)],mu,Sigma);
contour(xPos,yPos,reshape(pdfVals,size(xPos)));

% Fit X2
sigma = var(X2,0,1);
Sigma = diag(sigma);

% Plot Data
subplot(3,2,4);
plot(X2(:,1),X2(:,2),'b.');
xlim(axisLimits);
ylim(axisLimits);
% Draw Contour
hold on
pdfVals = gaussianPDF([xPos(:) yPos(:)],mu,Sigma);
contour(xPos,yPos,reshape(pdfVals,size(xPos)));

%% Third row (fit full covariance)

% Fit X1
Sigma = cov(X1);


% Plot Data
subplot(3,2,5);
plot(X1(:,1),X1(:,2),'b.');
xlim(axisLimits);
ylim(axisLimits);
% Draw Contour
hold on
pdfVals = gaussianPDF([xPos(:) yPos(:)],mu,Sigma);
contour(xPos,yPos,reshape(pdfVals,size(xPos)));

% Fit X2
Sigma = cov(X2);

% Plot Data
subplot(3,2,6);
plot(X2(:,1),X2(:,2),'b.');
xlim(axisLimits);
ylim(axisLimits);
% Draw Contour
hold on
pdfVals = gaussianPDF([xPos(:) yPos(:)],mu,Sigma);
contour(xPos,yPos,reshape(pdfVals,size(xPos)));
