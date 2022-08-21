cd(fileparts(which('BiofilmQ')));

range = 1:numel(folders);

handles = handles.handles_GUI;
hObject = handles.mainFig;
evendata = [];

results = struct.empty;
for i = range
    if isfolder(fullfile(folders{i}))
        handles.settings.directory = folders{i};
        
        data_folders = dir(fullfile(folders{i}, '*data*'));
        data_folders = data_folders([data_folders.isdir]);
        
        try
        for k = 1:length(data_folders)
        
        [handles, status, biofilmData] = loadFiles(hObject, [], handles, data_folders(k).name);
        abundance_ch1 = cell(length(biofilmData.data),1);
        abundance_ch2 = cell(length(biofilmData.data),1);
        abundance_ch3 = cell(length(biofilmData.data),1);
        vol = cell(length(biofilmData.data),1);
        zCoord = cell(length(biofilmData.data),1);
        time = zeros(length(biofilmData.data),1);
        for j = 1:length(biofilmData.data)
            stats = biofilmData.data(j).stats;
            abundance_ch1{j} = [stats.Cube_RelativeAbundance_ch1];
            abundance_ch2{j} = [stats.Cube_RelativeAbundance_ch2];
            abundance_ch3{j} = [stats.Cube_RelativeAbundance_ch3];
            vol{j} = [stats.Shape_Volume];
            zCoord{j} = cellfun(@(x) x(3), {stats.Centroid}).*biofilmData.data(j).metadata.data.scaling.dxy*1000;
            time(j) = biofilmData.data(j).timeStamp/60/60;
        end
        
        results(end+1).path = fullfile(folders{i}, data_folders(k).name);
        results(end).time = time;
        results(end).distToSubstrate = zCoord;
        results(end).abundance_bact = abundance_ch1;
        results(end).abundance_mat = abundance_ch2;
        results(end).abundance_fung = abundance_ch3;
        results(end).volume = vol;
        
        end
        catch err
            
        end
        
        assignin('base', 'results', results)
        
    end
    
end