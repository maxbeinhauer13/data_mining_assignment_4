% build_graph.m
% This script loads the edge list and builds the adjacency matrix.

E = readmatrix('example1.csv');   % load CSV
edges = E(:, 1:2);                % take first two columns

col1 = edges(:,1);
col2 = edges(:,2);

max_ids = max(max(col1, col2));   % number of nodes

As = sparse(col1, col2, 1, max_ids, max_ids); 
As = As + As.';                    % make symmetric

A = full(As);                      % adjacency matrix

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"onright"}
%---
