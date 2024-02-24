IMPORT $.File_AllData, $.FIPSDATA, Visualizer;

CTFIPS := FIPSDATA.CT_FIPS;
POP := File_AllData.pop_estimatesDS;

JOIN (CTFIPS, POP, LEFT.primaryfips = RIGHT.FIPS_code);
TEMP := JOIN (CTFIPS,POP, LEFT.primaryfips = RIGHT.FIPS_code);

CORRELATION (TEMP, cnt, value);


//Visualization Code... WARNING WILL RUN SLOW
CleanPopRec := RECORD
    STRING2   state;
    DECIMAL   popValue;
END;

CleanPop := PROJECT(TEMP,TRANSFORM(CleanPopRec,
                                          SELF.state := LEFT.state,
                                          SELF.popValue := LEFT.value));
                                          
OUTPUT(CleanPop, NAMED('choro_POP'));
viz_pop := Visualizer.Choropleth.USStates('popGraph',, 'choro_POP');
viz_pop;