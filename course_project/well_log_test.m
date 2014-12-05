addPaths;

scat_coeffs = [];
input_dir = './grlogs/';

filter = 'gr';

las_files = dir(strcat(input_dir, '*.las'));

for f = 1:size(las_files)[1]

    % Load the well log
    wlog = read_las_file(strcat(input_dir, las_files(f).name));

    index = find(strcmp(wlog.curve_info(:,1), filter));
    y = wlog.curves(:, index);
    y = y(find(isfinite(y)));

    N = 2^15;
 
    % Set up default filter bank with averaging scale of  samples.
    T = 128;
    filt_opt = default_filter_options('audio', T);

    % Only compute zeroth-, first- and second-order scattering.
    scat_opt.M = 2;

    % Prepare wavelet transforms to use in scattering.
    [Wop, filters] = wavelet_factory_1d(N, filt_opt, scat_opt);

    % Compute the scattering coefficients of y.
    S = scat(y, Wop);
    layer =  scattergram_layer(S{3},[]);
    
    % First five coeff's are undefined
    layer = layer(5:end,:);
    
    % average over the whole log so the coefficients aren't time
    % dependent
    scat_coeffs = [scat_coeffs, mean(layer,2)];
    
end
   

% We end with 3 coefficients, plot the  histograms
figure();
hist(scat_coeffs(1,:)', 100);
figure();
hist(scat_coeffs(2,:)',100);
figure();
hist(scat_coeffs(3,:)',100);



