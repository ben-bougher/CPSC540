function [] = plotPDF(X,model)

increment = 100;

% Plot Data
figure(1);clf;hold on
plot(X(:,1),X(:,2),'.','color','b');

% Now Grid up the plot
domain1 = xlim;
domain1 = domain1(1):(domain1(2)-domain1(1))/increment:domain1(2);
domain2 = ylim;
domain2 = domain2(1):(domain2(2)-domain2(1))/increment:domain2(2);
d1 = repmat(domain1',[1 length(domain1)]);
d2 = repmat(domain2,[length(domain2) 1]);


for i =1:3
    vals = model(i).predict(model(i),[d1(:) d2(:)]);

    % Plot Contour
    contour(d1,d2,reshape(vals,size(d1)));

    % Plot Data on top of contours
    plot(X(:,1),X(:,2),'.','color','b');
end
