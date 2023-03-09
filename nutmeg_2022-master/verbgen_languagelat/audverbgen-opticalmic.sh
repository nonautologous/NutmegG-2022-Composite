#!/bin/sh

cp $CLINICALSCRIPTS_BASE/clinicalspeech-processing.cfg $1.ds/processing.cfg
thresholdDetect -f processing.cfg -oa 30m -c ADC11 -dt 3 -m wordstim -mc blue $1.ds
thresholdDetect -f processing.cfg -oa 12m -c ADC13 -dt 3 -m verbresponse $1.ds
