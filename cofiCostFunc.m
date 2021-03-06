function [J, grad] = cofiCostFunc(params, Y, R, num_users, num_movies, ...
                                  num_features, lambda)
%COFICOSTFUNC Collaborative filtering cost function
%   [J, grad] = COFICOSTFUNC(params, Y, R, num_users, num_movies, ...
%   num_features, lambda) returns the cost and gradient for the
%   collaborative filtering problem.
%

% Unfold the U and W matrices from params
X = reshape(params(1:num_movies*num_features), num_movies, num_features);
Theta = reshape(params(num_movies*num_features+1:end), ...
                num_users, num_features);

differences = ((X * Theta') .- Y) .* R;

% calculate cost
J = sum(sum(differences .^ 2)) / 2 + lambda * (sum(sum(X .^ 2)) + sum(sum(Theta .^ 2))) / 2;

% calculate gradients
X_grad = differences * Theta + lambda .* X;
Theta_grad = differences' * X + lambda .* Theta;

grad = [X_grad(:); Theta_grad(:)];

end
