#!/bin/csh

mkdir PN_LL
cd PN_LL
cp /data/bil-mb12/anne/update_langlat/newcode/PN_LL/pnameresponse_timeparams.mat ./
ln -s  ../$1*-pname-stim-nobad.ds ./
ln -s /data/clinical_meg/mr/$1/$1_mri
