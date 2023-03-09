#!/bin/sh

mkdir NWR_LL
cd NWR_LL
ln -s  ../$1 .
mkdir response
cd response
cp /data/bil-mb12/anne/update_langlat/newcode/VG_LL/verbresponse_timeparams.mat ./
cd ../

mkdir stim
cd stim
cp /data/bil-mb12/anne/update_langlat/newcode/VG_LL/wordstim_timeparams.mat ./

cd ../../

