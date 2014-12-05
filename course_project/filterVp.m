% Load the well log
input_dir = './wlogs/';
output_dir = './vplogs/';

las_files = dir(strcat(input_dir, '*.las'));

count = 0

for f = 1:size(las_files)[1]
    
    try
        wlog = read_las_file(strcat(input_dir, las_files(f).name));

        sonic = strcmp(wlog.curve_info(:,2), 'us/ft');
        density = strcmp(wlog.curve_info(:,2), 'g/cm3');
        
        if sum(sonic) & sum(density)
            
            count = count +1;
            
            wlog = l_seismic_acoustic(wlog,{'rho', wlog.curve_info(find(density),1)},{'DTp',  wlog.curve_info(find(sonic),1)});
            write_las_file(wlog, strcat(output_dir, las_files(f).name)) 
        end
    catch err
    end
   
end





