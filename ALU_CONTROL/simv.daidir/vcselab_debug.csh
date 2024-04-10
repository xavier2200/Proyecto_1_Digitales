#!/bin/csh -f

cd /home/TORRES_GONZALEZ_I_2024_dig/Desktop/digitales/Proyecto_1_Digitales/ALU_CONTROL

#This ENV is used to avoid overriding current script in next vcselab run 
setenv SNPS_VCSELAB_SCRIPT_NO_OVERRIDE  1

/mnt/vol_NFS_rh003/tools/vcs/R-2020.12-SP2/linux/bin/vcselab $* \
    -o \
    simv \
    -nobanner \

cd -

