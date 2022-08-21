clear; 
%close all;

% Set to 1 to plot biovolume over time and 0 to plot surface coverage over
% time.
plotVolume = 0;

coaggregates_antifungal = load('data\antifungal_biovolume_surfaceCoverage.mat');
co_anti_results = coaggregates_antifungal.results;

autoaggregates = load('data\auto-aggregates_biovolume_surfaceCoverage.mat');
auto_results = autoaggregates.results;

coaggregates = load('data\co-aggregates_biovolume_surfaceCoverage.mat');
co_results = coaggregates.results;



% get normalized data for each set
[auto_data, auto_time] = prepBiomassData(auto_results, plotVolume);

[co_data, co_time] = prepBiomassData(co_results, plotVolume);

[co_anti_data, co_anti_time] = prepBiomassData(co_anti_results, plotVolume);


% interpolation and averaging
time_max = max(max(auto_time(:)), max(co_time(:)));
times = linspace(0, time_max, max(size(auto_time,2),size(co_time,2)));

auto_data_interp = [];
for k = 1:size(auto_data,1)
    auto_data_interp(k,:) = interp1(auto_time(k,:),auto_data(k,:),times);    
end
mean_auto = nanmean(auto_data_interp);
std_auto = nanstd(auto_data_interp);
n_auto = sum(isnan(auto_data_interp));

co_data_interp = [];
for k = 1:size(co_data,1)
    co_data_interp(k,:) = interp1(co_time(k,:),co_data(k,:),times);    
end
mean_co = nanmean(co_data_interp);
std_co = nanstd(co_data_interp);
n_co = sum(isnan(co_data_interp));

co_anti_data_interp = [];
for k = 1:size(co_anti_data,1)
    co_anti_data_interp(k,:) = interp1(co_anti_time(k,:),co_anti_data(k,:),times);    
end
mean_co_anti = nanmean(co_anti_data_interp);
std_co_anti = nanstd(co_anti_data_interp);
n_co_anti = sum(isnan(co_anti_data_interp));


nan_max = 2;

f = figure;
shadedPlot(times(n_auto<nan_max), mean_auto(n_auto<nan_max), std_auto(n_auto<nan_max), [216 27 96]./255);
shadedPlot(times(n_co<nan_max), mean_co(n_co<nan_max), std_co(n_co<nan_max), [51 34 136]./255);
shadedPlot(times(n_co_anti<nan_max), mean_co_anti(n_co_anti<nan_max), std_co_anti(n_co_anti<nan_max), [224 141 0]./255);
xlim([0 6.5]);
box on
grid on
set(gca, 'FontSize',15);
set(gca, 'LineWidth',1.5);
