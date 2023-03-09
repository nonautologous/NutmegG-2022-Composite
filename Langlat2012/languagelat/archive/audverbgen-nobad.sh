#!/bin/sh

cp $BIL_BIN_BASE/languagelat/pname-processing.cfg $1.ds/processing.cfg

newDs -process $1.ds $1-nobad.ds

#rm -r $1.ds

