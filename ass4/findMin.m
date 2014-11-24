function [w,f] = findMin(funObj,w,maxEvals,varargin)

% Parameters of the Optimizaton
optTol = 1e-2;
gamma = 1e-4;

% Evaluate the initial function value and gradient
[f,g] = funObj(w,varargin{:});
funEvals = 1;
alpha = 1;
g_old  = zeros(size(g));

while 1
    %% Line-search to find an acceptable value of alpha
    y = g-g_old;
    
    % Quasi Newton
    alpha = -alpha*y'*g_old/(y'*y);
    
    if ((alpha < 1e-10) || (alpha > 1e10))
        alpha = 1;
    end
    
    
    w_new = w - alpha*g;
    [f_new,g_new] = funObj(w_new,varargin{:});
    funEvals = funEvals+1;
    
    while f_new > f - gamma*alpha*g'*g
        fprintf('Backtracking...\n');
        %alpha = alpha/2;
        
        [f_w_alpha_grad, dummy] = funObj(w_new-alpha*g_new, varargin{:}); 
        alpha = (alpha^2) *g_new'* g_new/(2*(f_w_alpha_grad - f_new ...
                                            + (alpha*g_new'*g_new)));
        
        w_new = w - alpha*g;
        [f_new,g_new] = funObj(w_new,varargin{:});
        funEvals = funEvals+1;
    end
    
    %% Update parameters/function/gradient
    g_old = g;
    w = w_new;
    f = f_new;
    g = g_new;
	
    %% Test termination conditions
	optCond = norm(g,'inf');
	fprintf('%6d %15.5e %15.5e %15.5e\n',funEvals,alpha,f,optCond);
	
	if optCond < optTol
        fprintf('Problem solved up to optimality tolerance\n');
		break;
	end
	
	if funEvals >= maxEvals
        fprintf('At maximum number of function evaluations\n');
		break;
	end
end