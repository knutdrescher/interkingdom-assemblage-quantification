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
        
        handles.handles_analysis.uicontrols.checkbox.loadPixelIdxLists.Value = true;
        [handles, status, biofilmData] = loadFiles(hObject, [], handles, data_folders(k).name);
        surfaceCoverage = zeros(length(biofilmData.data),1);
        vol = zeros(length(biofilmData.data),1);
        time = zeros(length(biofilmData.data),1);
        for j = 1:length(biofilmData.data)
            biofilmData.data(j).Connectivity = 8;
            img = labelmatrix(biofilmData.data(j));
            img_bw = bwconncomp(img>0);
            area = regionprops3(img_bw,'Volume');
            [~,ind_max] = max([area.Volume]);
            img_bw.NumObjects = 1;
            img_bw.PixelIdxList = img_bw.PixelIdxList(ind_max);
            img_bw = labelmatrix(img_bw)>0;
            proj = sum(img_bw,3)>0;
            
            vol(j) = sum(img_bw(:));
            surfaceCoverage(j) = sum(proj(:));
            time(j) = biofilmData.data(j).timeStamp/60/60;
        end
        
        results(end+1).path = fullfile(folders{i}, data_folders(k).name);
        results(end).time = time;
        results(end).surfaceCoverage = surfaceCoverage;
        results(end).volume = vol;
        
        end
        catch ERR
            
        end
        
        assignin('base', 'results', results)
        
    end
    
end