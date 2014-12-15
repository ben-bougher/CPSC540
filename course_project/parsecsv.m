function [data] = parsecsv(file)
    
    fid = fopen(file);
    
    % skip the header and blank line
    tline = fgetl(fid);
    tline = fgetl(fid);
    
    data = struct();
    while ischar(tline)
        
        tline = fgetl(fid);
        
        if ischar(tline)
            field = strsplit(tline,',');
            if( str2num(field{2}) & str2num(field{3}))
    
                data.(field{1}) = [str2num(field{2}), str2num(field{3})];
            end
        end
        
    end
  fclose(fid);
    
end 