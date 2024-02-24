IMPORT $.File_AllData,$.FIPSDATA,Visualizer;

CTFIPS :=  FIPSDATA.CT_FIPS;
POV := File_AllData.pov_estimatesDS;

JOIN (CTFIPS,POV, LEFT.primaryfips = RIGHT.FIPS_code);
TEMP := JOIN (CTFIPS,POV, LEFT.primaryfips = RIGHT.FIPS_code);

CORRELATION (TEMP, cnt, value);


//Visualization Code... WARNING WILL RUN SLOW
CleanPovRec := RECORD
    STRING2   state;
    DECIMAL   povValue;
END;

CleanPov := PROJECT(TEMP,TRANSFORM(CleanPovRec,
                                          SELF.state := LEFT.state,
                                          SELF.povValue := LEFT.value));
  
OUTPUT(CleanPov, NAMED('choro_POV'));
viz_pov := Visualizer.Choropleth.USStates('povGraph',, 'choro_POV');
viz_pov;
