# Bader_Visualize
Prepares an atomistic snapshot (.vtf file) with atoms colored according to their charges (beta values in VMD) from Bader program for VASP (http://theory.cm.utexas.edu/henkelman/code/bader/)

Pre requisites:
Needs to have run bader program first and have ACF.dat in the folder. 

What does it do:
This program takes the charge value in ACF.dat and subtracts it from the isolated atomic charge value in POTCAR and writes it to the beta value in poscar.vtf file format.

Steps:
1. Need POSCAR in cartesian coordinates
2. must have POTCAR file in the same folder
3. run './bader_visualize'
4. open poscar.vtf in VMD and choose beta for coloring scheme
5. use the colorbar extention in VMD to add it to the graphic
