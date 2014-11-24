function lse = mylogsumexp(b)
% does log(sum(exp)) across columns without overflowing
B = max(b,[],2);
lse = log(sum(exp(b-repmat(B,[1 size(b,2)])),2))+B;
