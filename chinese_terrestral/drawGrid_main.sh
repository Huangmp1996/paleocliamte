# conda activate rsf
# mkdir species_distribution_grid
Rscript generate_drawGrid_commands.R
ParaFly -c commands_drawGrid.txt -CPU 15
# nohup sh drawGrid_main.sh > drawGrid_main.sh.log 2>&1 &
