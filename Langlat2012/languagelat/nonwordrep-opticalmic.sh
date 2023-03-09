#!/bin/sh

cp $CLINICALSCRIPTS_BASE/clinicalspeech-processing.cfg $1.ds/processing.cfg
thresholdDetect -f processing.cfg -oa 30m -c ADC11 -dt 3 -m stim -mc blue $1.ds
thresholdDetect -f processing.cfg -oa 12m -c ADC13 -dt 3 -m response $1.ds
