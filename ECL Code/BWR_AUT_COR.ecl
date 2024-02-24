IMPORT $.File_AllData, $.STATEDATA, Visualizer;

CTSTATE := STATEDATA.CT_ST;
AUT := File_AllData.ChildAutismDS;

JOIN (CTSTATE, AUT, LEFT.MissingState = RIGHT.State);
TEMP := JOIN (CTSTATE, AUT, LEFT.missingstate = RIGHT.State);

OUTPUT(CTSTATE);

CORRELATION (TEMP, cnt , autismrate);

//VISUALIZATION CODE... WILL RUN SMOOTHLY
AutRec := RECORD
    STRING2   state;
    REAL   autismValue;
END;

CleanAut := PROJECT(TEMP,TRANSFORM(AutRec,
                                          SELF.state := LEFT.state,
                                          SELF.autismValue := LEFT.autismrate));
                                          
OUTPUT(CleanAut, NAMED('choro_Aut'));
viz_aut := Visualizer.Choropleth.USStates('autGraph',, 'choro_Aut');
viz_aut;