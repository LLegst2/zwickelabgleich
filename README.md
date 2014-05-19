# Zwickelabgelich

This matlabScript can do a zwickelabgleich for you. it also shows a nice diagramm of your data.

You can call it in octave or matlab via zwickelabgleich('data.csv').

It has some optiones:

## Options

zwickelabgleich (csvFile,reg1Start=1, reg1End=50, reg2Start=50, reg2End=0, counter=70) 

reg1Start --> reg1End : Datapoints for first regression

reg2Start --> reg2End : Datapoints for second regression

counter: Datapoint to start calculating. can be helpful to change the value if it seems like the zwickelabgleich is not working.
