function [data,timepoints] = prepBiomassData(results, plotVolume)

t_min = 1;
t_max = 2;

data = [];
timepoints = [];


n = 20;
for j = 1:length(results)     
   if plotVolume 
       volume = results(j).volume; 
   else
       volume = results(j).surfaceCoverage; 
   end
   time = results(j).time; 
   time = 0.5*(1:length(time))'-0.5;
   indicesForAverage = t_min<=time & time<=t_max;
   averageInitialVolume = mean(volume(indicesForAverage));

   if length(volume)<(n+1)
       volume(end+1:(n+1)) = NaN;
   elseif length(volume)>(n+1)
       volume = volume(1:(n+1));
   end
   data(end+1,:) = volume./averageInitialVolume; 
   timepoints(end+1,:) = 0:0.5:10;

end




end

