function [model] = matLearn_kernel_Gaussian(options) 
    
    model.h = options.h;
    
    model.predict = @predict;
    
end

function [w] = predict(model, z)
   
    h = model.h;
    

    w = (1/(h*sqrt(2*pi))) * exp(-(z'/h)*(z/h)/2);

end






            