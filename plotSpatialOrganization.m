clear; 
close all;

coaggregates = load('data\spatialOrganization.mat');

co_results = coaggregates.results;

f_shaded = figure;
hold on;
g_shaded = figure;
hold on;
h_shaded = figure;
hold on;

distance = 2.5;
minP = 3;

useTimepoints = 1:3;
xs = {};

for j = 1:length(co_results)

   zCoords = co_results(j).distToSubstrate;  
   zCoords = [zCoords{useTimepoints}]./1000;

   abundance_bact = co_results(j).abundance_bact;  
   abundance_bact = [abundance_bact{useTimepoints}];
   bact_center = sum(abundance_bact.*zCoords)/sum(abundance_bact);

   abundance_fung = co_results(j).abundance_fung;  
   abundance_fung = [abundance_fung{useTimepoints}];

   abundance_mat = co_results(j).abundance_mat;  
   abundance_mat = [abundance_mat{useTimepoints}];

   minZ = prctile(zCoords, 0.5);
   maxZ = prctile(zCoords, 99.5);

   dists = minZ:distance:maxZ;
   abundance_bact_mean = zeros(length(dists)-1,1);
   abundance_fung_mean = zeros(length(dists)-1,1);
   abundance_mat_mean = zeros(length(dists)-1,1);
   nPoints = zeros(length(dists)-1,1);
   for k = 1:length(dists)-1
      indices = zCoords>=dists(k) & zCoords < dists(k+1);
      abundance_bact_mean(k) = nanmean(abundance_bact(indices));
      abundance_fung_mean(k) = nanmean(abundance_fung(indices));
      abundance_mat_mean(k) = nanmean(abundance_mat(indices));
      nPoints(k) = sum(indices);
   end
   %smoothing
   abundance_bact_mean = smooth(abundance_bact_mean,5);
   abundance_fung_mean = smooth(abundance_fung_mean,5);
   abundance_mat_mean = smooth(abundance_mat_mean,5);

   x = 0.5*(dists(1:end-1)+dists(2:end));
   [~,bact_max] = max(abundance_bact_mean);
   x = x-bact_center;

   normFact = max(abundance_bact_mean);
   xs{end+1,1} = x;
   xs{end,2} = abundance_bact_mean/normFact;

   normFact = max(abundance_fung_mean);
   xs{end,3} = abundance_fung_mean/normFact;

   normFact = max(abundance_mat_mean);
   xs{end,4} = abundance_mat_mean/normFact;

end


maxVals = cellfun(@(x) max(x), xs(:,1));
minVals = cellfun(@(x) min(x), xs(:,1));
dists = min(minVals):distance:max(maxVals);
interpVals = cellfun(@(x,y) interp1(x,y,dists)', xs(:,1),xs(:,2), 'UniformOutput', false);
interpMat = [interpVals{:}];
means = zeros(length(dists),1);
stds = zeros(length(dists),1);
n = zeros(length(dists),1);
for j = 1:length(dists)
    means(j) = nanmean(interpMat(j,:));
    stds(j) = nanstd(interpMat(j,:));
    n(j) = sum(~isnan(interpMat(j,:)));
end
figure(f_shaded);
hold on;
shadedPlot(dists(n>minP), means(n>minP), stds(n>minP), [69 164 64]./255);
ylim([0 1.2]);
box on
grid on
set(gca, 'FontSize',15);
set(gca, 'LineWidth',1.5);


interpVals = cellfun(@(x,y) interp1(x,y,dists)', xs(:,1),xs(:,3), 'UniformOutput', false);
interpMat = [interpVals{:}];
means = zeros(length(dists),1);
stds = zeros(length(dists),1);
n = zeros(length(dists),1);
for j = 1:length(dists)
    means(j) = nanmean(interpMat(j,:));
    stds(j) = nanstd(interpMat(j,:));
    n(j) = sum(~isnan(interpMat(j,:)));
end
figure(g_shaded);
shadedPlot(dists(n>minP), means(n>minP), stds(n>minP), [43 124 188]./255)
ylim([0 1.2]);
box on
grid on
set(gca, 'FontSize',15);
set(gca, 'LineWidth',1.5);


interpVals = cellfun(@(x,y) interp1(x,y,dists)', xs(:,1),xs(:,4), 'UniformOutput', false);
interpMat = [interpVals{:}];
means = zeros(length(dists),1);
stds = zeros(length(dists),1);
n = zeros(length(dists),1);
for j = 1:length(dists)
    means(j) = nanmean(interpMat(j,:));
    stds(j) = nanstd(interpMat(j,:));
    n(j) = sum(~isnan(interpMat(j,:)));
end
figure(h_shaded);
shadedPlot(dists(n>minP), means(n>minP), stds(n>minP), [1 0 0])
ylim([0 1.2]);
box on
grid on
set(gca, 'FontSize',15);
set(gca, 'LineWidth',1.5);


