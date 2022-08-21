
foldername = 'data';
[~, ~, biofilmData] = loadFiles([], [], handles, foldername);
data = biofilmData.data;
data = data(1:end);
timepoints = 0.5*(0:length(data)-1);
scaling = biofilmData.params.scaling_dxy;

center = zeros(length(timepoints),3);
dist = zeros(length(timepoints)-1,1);

for j = 1:length(timepoints)
   stats = data(j).stats;
   vol = [stats.Shape_Volume];
   centroid_x = [stats.CentroidCoordinate_x];
   centroid_y = [stats.CentroidCoordinate_y];
   centroid_z = [stats.CentroidCoordinate_z];
   


   center(j,1) = sum(vol.*centroid_x)/sum(vol);
   center(j,2) = sum(vol.*centroid_y)/sum(vol);
   center(j,3) = sum(vol.*centroid_z)/sum(vol);
   
   % invert z
   maxZ = data(j).ImageSize(3);
   center(j,3) = maxZ - center(j,3);
   
   % Calculate distance moved
    if j>1
        dist(j-1) = sqrt((center(j,1)-center(j-1,1))^2 + (center(j,2)-center(j-1,2))^2+ (center(j,3)-center(j-1,3))^2);
    end 
end
center = center*scaling/1000;
dist = dist*scaling/1000;

% Centroid plot
figure; plot3(center(1:end,1), center(1:end,2), center(1:end,3), 'LineWidth', 1.5);
hold on; scatter3(center(1:end,1), center(1:end,2), center(1:end,3), 40, timepoints(1:end), 'filled');
scatter3(center(1:end,1)-50, center(1:end,2)-30, zeros(12,1),40, [0.33 0.33 0.33], 'filled');
plot3(center(1:end,1)-50, center(1:end,2)-30, zeros(12,1),'Color',[0.33 0.33 0.33], 'LineWidth', 2.5);

% Distance plot
figure; scatter(timepoints(2:end), dist, 30, [1 0 0], 'filled');
hold on; plot(timepoints(2:end), dist, 'LineWidth', 1.5);xlim([0 60]);

