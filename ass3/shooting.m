function[w] = shooting(X, y, lambda,w)

    [N,d] = size(X);
    
    converged = 0;
    

    while (converged < d)
        
        for j =1:d
            
            aj = 2*sum(X(:,j).^2);
            cj = 2 * sum(X(:,j)'*(y-X*w + w(j)*X(:,j)));
            
            a = cj/aj;
            delta = lambda/aj;
            
            % eqn 13,55/13.56
            w_new = sign(a)* max((abs(a) - delta), 0);
    
            if w_new == w(j)
                converged = converged +1;
                break
            else
                w(j) = w_new;
            end
        end
    end
end

