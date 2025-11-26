% spectral_kway.m
% Spectral clustering into k clusters using k smallest eigenvectors of L

%% 1. Load edge list
E = readmatrix('example2.csv');   % later you can change to example2.csv
edges = E(:, 1:2);                % use only first two columns

%% 2. Build adjacency matrix A
col1 = edges(:,1);
col2 = edges(:,2);

max_ids = max(max(col1, col2));   % number of nodes
As = sparse(col1, col2, 1, max_ids, max_ids);
As = As + As.';                   % make symmetric (undirected)
A = full(As);                     % dense adjacency (optional)

%% 3. Degree matrix and Laplacian
degrees = sum(A, 2);              % degree of each node
D = diag(degrees);                % degree matrix
L = D - A;                        % unnormalized Laplacian
%% 4. Choose number of clusters k
k = 4;   % for example; you can change to 2, 3, 4, ...

%% 5. Compute k smallest eigenvectors of L
[U, lambda_k] = eigs(L, k, 'smallestabs');   % U is N x k

% Each row of U is the k-dimensional embedding of one node
%% 6. Optional: normalize rows of U to unit length
U_norm = U ./ vecnorm(U, 2, 2);   % divide each row by its L2 norm
%% 7. Run k-means on rows of U_norm
% idx(i) = cluster label (1..k) for node i
num_replicates = 10;  % run kmeans multiple times to avoid bad local minima

idx = kmeans(U_norm, k, 'Replicates', num_replicates);

%% 8. Show cluster sizes
for c = 1:k

end

%% 9. Optional: visualize adjacency reordered by cluster
[~, order] = sort(idx);      % sort node indices by cluster label
A_reordered = A(order, order);

figure;
spy(A_reordered);
title('Adjacency matrix reordered by spectral clusters');

