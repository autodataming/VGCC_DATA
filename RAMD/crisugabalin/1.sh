#!/bin/bash

#module add gromacs/ramd/cuda-workstation
#
num=1

for name in {16..20}
   do
        mkdir TR501$num-$name
        cd  TR501$num-$name
        cp  ../../../GROMACS/Replica$num/npt_50ns.tpr .
        cp ../../../GROMACS/Replica$num/npt_50ns.cpt .
        cp ../../../GROMACS/Replica$num/H49_GMX.itp   .



        cp ../../../GROMACS/topol.top topol.top
        cp  ../../../GROMACS/index.ndx .
 ##       ln -s ../../Performance-GPU/index.ndx .
        sed "s/XX/$name/"  ../gromacs_ramd.mdp > gromacs_ramd.mdp
        gmx grompp -f gromacs_ramd.mdp  -c  npt_50ns.tpr -o gromacs_ramd.tpr -t npt_50ns.cpt   -n index.ndx
        gmx mdrun -s gromacs_ramd.tpr  -maxh 24 
        cd ..
   done

