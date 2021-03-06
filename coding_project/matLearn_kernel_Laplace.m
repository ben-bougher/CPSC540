

function [model] = matLearn_kernel_Laplace(options) 
% h will be the variance of the kernel, determines the amount of
% contribution of neighbouring points.
    
    model.h = options.h;
    
    model.predict = @predict;
    
end

function [w] = predict(model, z)

    h = model.h;
   
    

    w = (1/h) * exp(-abs(z)/h);

end






            