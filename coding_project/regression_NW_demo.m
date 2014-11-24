%% Load the data %%
load data_regressOnOne.mat


h = .1; % Amount of smoothing
kernel_options = [];
kernel_options.h = h;

[gauss_kern] = matLearn_kernel_Gaussian(kernel_options);
[laplace_kern] = matLearn_kernel_Laplace(kernel_options);

reg_options = [];
reg_options.kernel = gauss_kern;
[model] = matLearn_regression_NW(Xtrain, ytrain, reg_options);


yhat = model.predict(model, Xtest);

figure()
scatter(Xtest, ytest);
figure()
scatter(Xtest, yhat);



