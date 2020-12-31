syms x y;
eqn = [x^2 + x * y + y == 3, x^2 - 4 * x + 3 == 0];
vars = [x y];
[x,y] = solve(eqn, vars);
[x,y]
