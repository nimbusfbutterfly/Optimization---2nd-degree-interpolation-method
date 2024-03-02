clc;clear all
% Define the function
f = @(lambda) lambda.^5 + 3*lambda.^2 - 2*lambda.*exp(0.5*lambda);

a = -1.0;
b = 1.0;
epsilon = 1e-8; 
max_function_calls = 50;
num_evaluations = 0;
num_iterations = 0;

while (b - a) > epsilon
    if num_evaluations >= max_function_calls
        fprintf('Maximum number of function evaluations reached.\n');
        break;
    end

    % Calculate function values at three points
    x1 = a;
    x2 = (a + b) / 2;
    x3 = b;
    f1 = f(x1);
    f2 = f(x2);
    f3 = f(x3);

    % Fit a parabola to the three points
    A = ((f1 - f2) / (x1 - x2) - (f2 - f3) / (x2 - x3)) / (x1 - x3);
    B = (f1 - f2) / (x1 - x2) - A * (x1 + x2);
    C = f1 - A * x1^2 - B * x1;

    % Find the minimum of the parabola
    minimum_x = -B / (2 * A);
    minimum_f = f(minimum_x);
    num_evaluations = num_evaluations + 1;

    % Update the interval [a, b]
    if minimum_x < x2
        if minimum_f < f2
            b = x2;
            x2 = minimum_x;
            f2 = minimum_f;
        else
            a = minimum_x;
        end
    else
        if minimum_f < f2
            a = x2;
            x2 = minimum_x;
            f2 = minimum_f;
        else
            b = minimum_x;
        end
    end
    
    num_iterations = num_iterations + 1;
end

% Plot the function
x = linspace(-1.0, 1.0, 1000);
y = f(x);
plot(x, y);
hold on;
scatter(minimum_x, minimum_f, 'ro');
xlabel('\lambda');
ylabel('f(\lambda)');
grid on;

% The optimal point is (minimum_x, minimum_f)
fprintf('Optimal Point: (%.8f, %.8f)\n', minimum_x, minimum_f);

% Print the number of function evaluations and iterations
fprintf('Number of Function Evaluations: %d\n', num_evaluations);
fprintf('Number of Iterations: %d\n', num_iterations);

% Print a message indicating the condition
if (b - a) <= epsilon
    fprintf('Algorithm stopped because the interval size is less than or equal to epsilon.\n');
else
    fprintf('Algorithm stopped after reaching the maximum number of call function.\n');
end
