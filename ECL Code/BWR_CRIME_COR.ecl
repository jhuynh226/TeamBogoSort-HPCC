IMPORT $.File_AllData, $.STATEDATA, Visualizer;

CTSTATE := STATEDATA.CT_ST;
CRIME := File_AllData.CrimeRateDS;

JOIN (CTSTATE, CRIME, LEFT.MissingState = RIGHT.State);
TEMP := JOIN (CTSTATE, CRIME, LEFT.missingstate = RIGHT.State);

CORRELATION (TEMP, cnt , crimerate);

//VISUALIZATION CODE
CleanPopRec := RECORD
    STRING2   state;
    DECIMAL   crimeValue;
END;

CleanPop := PROJECT(TEMP,TRANSFORM(CleanPopRec,
                                          SELF.state := LEFT.state,
                                          SELF.crimeValue := LEFT.crimerate));
                                          
OUTPUT(CleanPop, NAMED('choro_Crime'));
viz_crime := Visualizer.Choropleth.USStates('crimeGraph',, 'choro_crime');
viz_crime;