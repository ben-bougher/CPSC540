addPaths;

scat_coeffs = [];
label_dir = './unit_labels/';
input_dir = './grlogs/';

filter = 'gr';

las_files = dir(strcat(input_dir, '*.las'));
label_files = dir(strcat(label_dir, '*.csv'));


data = struct('Ordovician',[], ...
              'Kope', [], ...
              'Utica', [], ...
              'PointPleasant', [], ...
              'TL',[],...
              'BlackRiver',[],...
              'GullRiver',[],...
              'WellsCreek',[]);


for f = 1:size(las_files)[1]

    % Check if the log has labels
    lfile =  las_files(f);
    api = lfile.name(1:10);
    
    if(sum(strcmp({label_files.name}, strcat(api, '.csv'))) == 0)
        continue;
    end
    
    wlog = read_las_file(strcat(input_dir, las_files(f).name));
    
    label_data = parsecsv(strcat(label_dir, strcat(api, '.csv')));
    labels = fieldnames(label_data);
    
    for group =1:size(labels,1)
        
        label = labels{group};
        range = label_data.(label);
        
        if sum(range) == 0
            continue
        end
        
        depth = wlog.curves(:,1);
        
        
        group_index = find((depth <= range(2))  & (depth > ...
                                                   range(1)));
        
        index = find(strcmp(wlog.curve_info(:,1), filter));
        y = wlog.curves(:, index);
        y = y(group_index);
        
      

        N = 2^10;
 
        % Set up default filter bank with averaging scale of samples.
        T = 128;
        filt_opt = default_filter_options('audio', T);

        % Only compute zeroth-, first- and second-order scattering.
        scat_opt.M = 2;
    
        % Prepare wavelet transforms to use in scattering.
        [Wop, filters] = wavelet_factory_1d(N, filt_opt, scat_opt);

        try
            % Compute the scattering coefficients of y.
            S = scat(y, Wop);
            signal = [S{3}.signal{:}];
            size(signal)
            data.(label) = cat(1,data.(label), signal);
            
        catch err
            err
        end
        
    end
end
   


y = [];
X = [];

ytest = [];
Xtest = [];

labels = fieldnames(data);
for j = 1:length(labels)
    
    label = labels{j};
    d_i = data.(label);
    valid = find(sum(isfinite(d_i),2) ==50);
    
    
    y_i = ones(size(d_i,1),1) * j;
    
    d_i = d_i(valid,:);
    y_i = y_i(valid);
    
    
    X = [X;d_i(1:floor(size(d_i,1)/2),:)];
    y = [y;y_i(1:floor(size(d_i,1)/2),:)];
   
    Xtest = [Xtest;d_i(ceil(size(d_i,1)/2):end,:)];
    ytest = [ytest;y_i(ceil(size(d_i,1)/2):end,:)];
end

Xtest = Xtest(1:size(X,1),:);
ytest = ytest(1:size(X,1),:);

save 'labeled_dat.mat' Xtest ytest X y;


