#!/bin/sh

newSingleTrialDs $1.ds $1-st.ds

newDs -marker stim -time -1 3.5 -overlap 1 -includeEvent response 0.5 3 $1-st.ds $1-pname-stim.ds

rm -r $1-st.ds
