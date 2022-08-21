close all;
clear;

n_min = 3;

results = load('data\accumulatedMovement.mat');
results = results.results;
time = results.time/60;

mean_auto = nanmean(results.autoaggregates,2);
std_auto = nanstd(results.autoaggregates')';
n_auto = sum(~isnan(results.autoaggregates),2);

mean_co = nanmean(results.coaggregates,2);
std_co = nanstd(results.coaggregates')';
n_co = sum(~isnan(results.coaggregates),2);

mean_co_anti = nanmean(results.co_antifungal,2);
std_co_anti = nanstd(results.co_antifungal')';
n_co_anti = sum(~isnan(results.co_antifungal),2);

f = figure;
shadedPlot(time(n_auto>n_min), mean_auto(n_auto>n_min), std_auto(n_auto>n_min), [216 27 96]./255);
shadedPlot(time(n_co>n_min), mean_co(n_co>n_min), std_co(n_co>n_min), [51 34 136]./255);
shadedPlot(time(n_co_anti>n_min), mean_co_anti(n_co_anti>n_min), std_co_anti(n_co_anti>n_min), [224 141 0]./255);
xlim([0 6.5]);
box on
grid on
set(gca, 'FontSize',15);
set(gca, 'LineWidth',1.5);