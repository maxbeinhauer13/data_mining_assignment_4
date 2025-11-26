% spectral_2way.m
% 1) Load graph from CSV
% 2) Build adjacency matrix A
% 3) Build Laplacian L
% 4) Compute Fiedler vector
% 5) Split nodes into 2 communities

%% 1. Load edge list
E = readmatrix('example1.csv');  % assumes file is in current folder
edges = E(:, 1:2);               % use only first two columns

%% 2. Build adjacency matrix A
col1 = edges(:,1);
col2 = edges(:,2);

max_ids = max(max(col1, col2));  % number of nodes
As = sparse(col1, col2, 1, max_ids, max_ids);
As = As + As.';                  % make symmetric (undirected)
A = full(As);                    % dense adjacency (optional)

%% 3. Degree matrix and Laplacian
degrees = sum(A, 2);             % degree of each node
D = diag(degrees);               % degree matrix
L = D - A;                       % unnormalized Laplacian

%% 4. Eigen-decomposition (2 smallest eigenvalues)
[V, lambda] = eigs(L, 2, 'smallestabs');  % V: eigenvectors, lambda: eigenvalues

% Fiedler vector is the 2nd eigenvector
f = V(:, 2);

%% 5. Partition into 2 groups by sign of Fiedler vector
group1 = find(f >= 0);
group2 = find(f < 0);

fprintf('Group 1 size: %d\n', length(group1));
fprintf('Group 2 size: %d\n', length(group2));
