

function [model] = matLearn_kernel_Laplace(options) 
    
    model.h = options.h;
    
    model.predict = @predict;
    
end

function [w] = predict(model, z)
   
    h = model.h;
    

    w = (1/h) * exp(-abs(z)/h);

end






            