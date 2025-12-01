# Assignment 4 – Spectral Clustering on Graphs

This folder contains the code and report for Assignment 4 in the course Data Mining.

## Files

- **assignment4_results.mlx** – Main Live Script containing the full report, including:
  - adjacency matrix construction  
  - Laplacian computation  
  - 2-way spectral clustering (Fiedler vector)  
  - k-way spectral clustering for k = 2, 3, 4  
  - reordered adjacency matrix plots  
  - discussion and conclusion  

- **spectral_2way.m** – Stand-alone MATLAB script implementing the 2-way spectral partition using the Fiedler vector. (development script)

- **spectral_kway.m** – Stand-alone MATLAB script implementing k-way spectral clustering using the first k eigenvectors and k-means.(development script)

- **run_all_results.m** – Script that runs spectral clustering for k = 2, 3, 4 on both datasets and prints cluster sizes and figures.(development script)

- **example1.csv**, **example2.csv** – Edge-list datasets used in the analysis.

## How to run
Open `assignment4_results.mlx` in MATLAB Online and click **Run All**.  
This executes all steps, produces the cluster sizes, and generates all figures used in the report.

## Notes
All dataset files must be in the same directory as the scripts when running in MATLAB Online.

