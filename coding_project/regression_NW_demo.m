%% Load the data %%
load data_regressOnOne.mat


%% Set the amount of smoothing
h = .1;
kernel_options = [];
kernel_options.h = h;

%% Generate the kernels
[kern] = matLearn_kernel_Gaussian(kernel_options);
%[kern] = matLearn_kernel_Laplace(kernel_options);


%% Generate the NW regression object
reg_options = [];
reg_options.kernel = kern;
[model] = matLearn_regression_NW(Xtrain, ytrain, reg_options);

%% Make predictions on test data
yhat = model.predict(model, Xtest);


%% Plot the results
figure()
scatter(Xtest, ytest);
figure()
scatter(Xtest, yhat);



