#!/bin/sh

newSingleTrialDs $1.ds $1-st.ds
newDs -marker stim -includeEvent response 0.3 4 -time -1 4 -overlap 2 $1-st.ds $1-nonwordrep.ds
rm -r $1-st.ds
cp $BIL_LANGLAT_BASE/pname-processing.cfg $1-nonwordrep.ds/processing.cfg
