function shadedPlot(x,y, err, color)
x = x(:)';
y = y(:)';
err = err(:)';

hold on;
plot(x,  y, 'Color', color, 'LineWidth', 1.5);

alpha=0.2;

y1_shaded = y-err;
y2_shaded = y+err;
nans = isnan(y1_shaded)|isnan(y2_shaded);
y1_shaded = y1_shaded(~nans);
y2_shaded = y2_shaded(~nans);
X = [x(~nans),fliplr(x(~nans))]; % Create x-array for plotting
Y = [y1_shaded,fliplr(y2_shaded)]; % Create y-array for plotting
fill(X, Y,  rand(1,3), 'EdgeColor', 'none', 'FaceAlpha', alpha);


end

