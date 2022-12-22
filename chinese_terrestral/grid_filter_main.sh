#conda activate rsf
mkdir species_distribution_grid_filtered
Rscript generate_filterGrid_commands.R
ParaFly -c commands_grid_filter.txt -CPU 30 
# nohup sh grid_filter_main.sh > grid_filter_main.sh.log 2>&1 &
