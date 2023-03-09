#!/bin/sh

newSingleTrialDs $1.ds $1-st.ds
newDs -marker wordstim -includeEvent verbresponse 0.3 4 -time -1 4 -overlap 2 $1-st.ds $1-audverbgen.ds
rm -r $1-st.ds
