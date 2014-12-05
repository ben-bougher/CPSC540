scat_coeffs = [];
input_dir = './vplogs/';

las_files = dir(strcat(input_dir, '*.las'));

for f = 1:size(las_files)[1]

    % Load the well log
    wlog = read_las_file(strcat(input_dir, las_files(f).name));
    
    % Get the Vp log
    y = wlog.curves(:, end-1);
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
    layer = layer(:,1:50);
    
    scat_coeffs = [scat_coeffs, layer(:)];
    size(layer)
    
end
   

