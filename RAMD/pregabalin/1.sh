#!/bin/bash

#module add gromacs/ramd/cuda-workstation
#
num=1

for name in {1..20}
   do
        mkdir TR501$num-$name
        cd  TR501$num-$name
        cp  ../../../GROMACS/Replica$num/npt_500ps.tpr .
        cp ../../../GROMACS/Replica$num/npt_500ps.cpt .
        cp ../../../GROMACS/Replica$num/Pre_GMX.itp   .



        cp ../../../GROMACS/topol.top topol.top
        cp  ../../../GROMACS/index.ndx .
 ##       ln -s ../../Performance-GPU/index.ndx .
        sed "s/XX/$name/"  ../gromacs_ramd.mdp > gromacs_ramd.mdp
        gmx grompp -f gromacs_ramd.mdp  -c  npt_500ps.tpr -o gromacs_ramd.tpr -t npt_500ps.cpt   -n index.ndx
        gmx mdrun -s gromacs_ramd.tpr  -maxh 24 
        cd ..
   done

