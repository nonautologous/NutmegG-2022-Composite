#!/bin/csh

# opticalmic
cp $CLINICALSCRIPTS_BASE/clinicalspeech-processing.cfg $1.ds/processing.cfg
thresholdDetect -f processing.cfg -oa 20m -c ADC11 -dt 3 -m wordstim -mc blue $1.ds
thresholdDetect -f processing.cfg -oa 50m -c ADC13 -dt 3 -m verbresponse $1.ds
sleep .5s

# add type and name
@ K = 1
while ($K <161)
		
	set NAME = `head -$K /data/research_meg13/vgen_test/word.txt | tail -1`
	echo $NAME
	set CODE = `head -$K /data/research_meg13/vgen_test/code.txt | tail -1`
	addMarker -n $NAME -C $CODE $1.ds
	@ K++

end

# add class
scanMarkers -f -add high1 -marker skirt -marker film -marker robe -marker blade -marker jeep -marker brain -marker oil -marker card -marker shrimp -marker purse -marker gold -marker chips -marker sponge -marker cane -marker beef -marker pork -marker silk -marker bank -marker jail -marker beer -marker steak -marker tray -marker wine -marker band -marker bar -marker cream -marker script -marker jam -marker fence -marker deck -marker bridge -marker dice -marker shelf -marker wrist -marker suit -marker throat -marker crown -marker gym -marker drawers -marker pill -time 0 0.1 $1.ds temp.evt

scanMarkers -f -add high2 -marker cabin -marker mountain -marker city -marker weapon -marker alley -marker dessert -marker army -marker hotel -marker rocket -marker motor -marker medal -marker airport -marker island -marker soldier -marker prison -marker highway -marker traffic -marker bracelet -marker railroad -marker leather -marker pilot -marker basket -marker oven -marker tower -marker shotgun -marker diamond -marker taxi -marker office -marker lobster -marker album -marker statue -marker bullet -marker perfume -marker suitcase -marker student -marker castle -marker wallet -marker trailer -marker carpet -marker rifle -time 0 0.1 $1 temp.evt

scanMarkers -f -add low1 -marker goal -marker trick -marker dream -marker ghost -marker tour -marker thirst -marker tune -marker breeze -marker sin -marker threat -marker shape -marker clue -marker score -marker faith -marker speech -marker debt -marker style -marker time -marker life -marker sport -marker proof -marker joke -marker joy -marker role -marker aid -marker deal -marker brand -marker guilt -marker trade -marker charm -marker shame -marker mood -marker race -marker risk -marker friend -marker speed -marker skill -marker crime -marker code -marker tone -time 0 0.1 $1.ds temp.evt

scanMarkers -f -add low2 -marker freedom -marker vision -marker meeting -marker riddle -marker manner -marker future -marker failure -marker marriage -marker mistake -marker sadness -marker safety -marker passion -marker handful -marker system -marker nature -marker error -marker grammar -marker darling -marker talent -marker culture -marker angle -marker rhythm -marker fever -marker blessing -marker lesson -marker genius -marker habit -marker winner -marker fiction -marker danger -marker drama -marker effort -marker symbol -marker volume -marker evening -marker magic -marker anger -marker birthday -marker bonus -marker nation -time 0 0.1 $1.ds temp.evt
