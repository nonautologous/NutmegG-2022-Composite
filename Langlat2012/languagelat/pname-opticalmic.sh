#!/bin/sh

cp $CLINICALSCRIPTS_BASE/clinicalspeech-processing.cfg $1.ds
thresholdDetect -f $CLINICALSCRIPTS_BASE/clinicalspeech-processing.cfg -oa 50m -c ADC11 -dt 3 -m response -mc blue $1.ds

addMarker -f -q24 1 -n stim $1.ds
