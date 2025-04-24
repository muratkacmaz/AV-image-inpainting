%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%              LABORATORY #3 
%%%              ARTIFICIAL VISION 2024-2025
%%%              Exemplar-based methods and applications
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function distances = compute_patch_distances(patch_list, patch, mask, weights)
%compute_patch_distances Computes distances between the given patch and
%                        all patches in the list of patches
%   IN:
%   patch_list - list of N patches in 4D structure:
%       (patch height, patch width, number of color channels, N)
%   patch - given patch
%   mask - binary mask to be applied in distance computation
%   weights - intra-patch weights
%   OUT:
%   distances - array of size N, containing all patch distances
    % Get dimensions
    [patch_height, patch_width, num_channels, num_patches] = size(patch_list);
    % Initialize distances array
    distances = zeros(1, num_patches);
    % Convert inputs to double to ensure compatibility
    patch = double(patch);
    mask = double(mask);
    weights = double(weights);
    % Expand the mask to handle color channels if needed
    if size(mask, 3) == 1 && num_channels > 1
        mask = repmat(mask, [1, 1, num_channels]);
    end
    % Expand the weights to handle color channels if needed
    if size(weights, 3) == 1 && num_channels > 1
        weights = repmat(weights, [1, 1, num_channels]);
    end
    % Apply mask to the reference patch
    masked_patch = patch .* mask;
    % Compute distances for all patches in the list
    for i = 1:num_patches
        % Get current patch and convert to double
        current_patch = double(patch_list(:, :, :, i));
        % Apply mask to the current patch
        masked_current_patch = current_patch .* mask;
        % Calculate squared difference
        diff_squared = (masked_patch - masked_current_patch).^2;
        % Apply weights
        weighted_diff = diff_squared .* weights;
        % Sum the weighted differences
        distances(i) = sum(weighted_diff(:));
    end
end