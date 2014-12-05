addPaths
% Load the well log
input_dir = './wlogs/';
output_dir = './grlogs/';

mkdir(output_dir);

las_files = dir(strcat(input_dir, '*.las'));

count = 0

for f = 1:size(las_files)[1]
    
    try
        wlog = read_las_file(strcat(input_dir, las_files(f).name));

     
        
        gr = strcmp(wlog.curve_info(:,1), 'gr');
        
        if(sum(gr))
            count = count +1;
            write_las_file(wlog,strcat(output_dir, ...
                                       las_files(f).name))
        end
        
   
    catch err
    end
   
end





