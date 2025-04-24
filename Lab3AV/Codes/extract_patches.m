%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%              LABORATORY #3 
%%%              ARTIFICIAL VISION 2024-2025
%%%              Exemplar-based methods and applications
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [patch_list, coordinates] = extract_patches(image, patch_size)
%extract_patches Extracts a list of patches from a given image
%   IN:
%   image - image to extract patches from
%   patch_size - size of the patch [height width]
%   OUT:
%   patch_list - list of N patches in 4D structure:
%       (patch height, patch width, number of color channels, N)
%   coordinates - (N-by-2) matrix with coordinates of patch centers.
%
%   NOTE: patches in patch_list and in coordinates should be in the same
%         order
    % Get image dimensions
    [img_height, img_width, num_channels] = size(image);
    % Calculate the valid range for patch centers
    % Need half-patch padding on all sides to ensure full patches
    patch_height = patch_size(1);
    patch_width = patch_size(2);
    % Calculate half-patch sizes (rounding down for even sizes)
    half_height = floor(patch_height / 2);
    half_width = floor(patch_width / 2);
    % Define valid ranges for patch centers
    row_start = half_height + 1;
    row_end = img_height - half_height;
    col_start = half_width + 1;
    col_end = img_width - half_width;
    % Determine number of patches
    num_patches = (row_end - row_start + 1) * (col_end - col_start + 1);
    % Initialize output arrays
    patch_list = zeros(patch_height, patch_width, num_channels, num_patches);
    coordinates = zeros(num_patches, 2);
    % Extract patches
    patch_idx = 1;
    for row = row_start:row_end
        for col = col_start:col_end
            % Calculate patch boundaries
            row_start_patch = row - half_height;
            row_end_patch = row_start_patch + patch_height - 1;
            col_start_patch = col - half_width;
            col_end_patch = col_start_patch + patch_width - 1;
            % Extract the patch
            patch_list(:, :, :, patch_idx) = image(row_start_patch:row_end_patch, ...
                                                   col_start_patch:col_end_patch, :);
            % Store the center coordinates
            coordinates(patch_idx, :) = [row, col];
            % Move to next patch
            patch_idx = patch_idx + 1;
        end
    end
end
