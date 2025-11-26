% run_all_results.m
% Runs spectral clustering for multiple files and k values
% Prints results and shows figures (reordered adjacency spy plots)

clear; clc;

files = {'example1.csv', 'example2.csv'};
ks = [2 3 4];

for fi = 1:numel(files)
    filename = files{fi};
    fprintf('\n================================\n');
    fprintf('Results for file: %s\n', filename);
    fprintf('================================\n');

    %% 1. Load edge list for this file
    E = readmatrix(filename);
    edges = E(:, 1:2);

    %% 2. Build adjacency matrix A
    col1 = edges(:,1);
    col2 = edges(:,2);

    max_ids = max(max(col1, col2));
    As = sparse(col1, col2, 1, max_ids, max_ids);
    As = As + As.';        
    A = full(As);          

    %% 3. Build Laplacian L
    degrees = sum(A, 2);
    D = diag(degrees);
    L = D - A;

    %% 4. Loop over k = 2,3,4
    for ki = 1:numel(ks)
        k = ks(ki);
        fprintf('\n  k = %d\n', k);

        % 4a. Compute k smallest eigenvectors
        [U, lambda_k] = eigs(L, k, 'smallestabs');

        % 4b. Row normalization
        U_norm = U ./ vecnorm(U, 2, 2);

        % 4c. K-means
        idx = kmeans(U_norm, k, 'Replicates', 10);

        % 4d. Print cluster sizes
        for c = 1:k
            fprintf('    Cluster %d size: %d\n', c, sum(idx == c));
        end

        %% 5. Create a figure for reordered adjacency
        [~, order] = sort(idx);
        A_reordered = A(order, order);

        figure;
        spy(A_reordered);
        title(sprintf('Reordered adjacency for %s (k = %d)', filename, k));
    end
end
