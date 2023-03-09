#!/bin/csh

mkdir VG_LL
cd VG_LL
ln -s  ../$1*-audverbgen-nobad.ds ./
mkdir response
cd response
cp /data/bil-mb12/anne/update_langlat/newcode/VG_LL/verbresponse_timeparams.mat ./
cd ../

mkdir stim
cd stim
cp /data/bil-mb12/anne/update_langlat/newcode/VG_LL/wordstim_timeparams.mat ./

cd ../
ln -s /data/clinical_meg/mr/$1/$1_mri

