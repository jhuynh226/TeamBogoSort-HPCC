﻿IMPORT File_AllData,STD,Visualizer,$;

NCMEC_Rec := File_AllData.mc_byState;
NCMEC_DS  := File_AllData.mc_byStateDS;
Cities    := File_AllData.City_DS;
UNEMP     := File_AllData.unemp_byCountyDS;
EDU       := File_AllData.EducationDS;
POVTY     := File_AllData.pov_estimatesDS;
POP       := File_AllData.pop_estimatesDS;
HMK       := $.File_AllData;

NCMECPlusLayout := RECORD
    UNSIGNED3  recid;
    UNSIGNED4  dateposted;
    STRING18   FirstName;
    STRING24   LastName;
    UNSIGNED1  currentage;
    UNSIGNED4  datemissing;
    STRING23   missingcity;
    UNSIGNED3  PrimaryFIPS;
    STRING2    missingstate;
    DECIMAL5_2 ump_rate;  //New field 
    DECIMAL5_2 pov_pct;   //New Poverty percent for children 0-17
    UNSIGNED4  PopEst;    //Population Estimate from 2020-2022
    DECIMAL5_2 edu_High;  //less than a high school diploma (percent)
    STRING131  contact;
    STRING96   photolink;
END;

NewNCMECLayout := $.File_EnhanceNCMEC.NCMECPlusLayout;


NewNCMECLayout CleanNCMEC(NCMEC_DS Le,UNSIGNED2 CNT) := TRANSFORM
 // SELF.RecID    := CNT; //Now uses Case Number
 SELF.DatePosted  := STD.Date.FromStringToDate(Le.DatePosted,'%m/%d/%Y');
 SELF.FirstName   := STD.Str.ToUpperCase(Le.FirstName);
 SELF.LastName    := STD.Str.ToUpperCase(Le.LastName);
 // SELF.DateMissing := STD.Date.FromStringToDate(Le.DateMissing,'%m/%d/%Y'); //Processed earlier
 SELF.MissingCity := STD.Str.ToUpperCase(Le.MissingCity);
 SELF.Contact     := STD.Str.ToUpperCase(Le.Contact);
 SELF.PrimaryFIPS := 0; 
 SELF.ump_rate    := 0;
 SELF.pov_pct     := 0;
 SELF.PopEst      := 0;
 SELF.edu_High    := 0;
 SELF             := Le;
 END;
 
 Clean_NCMEC_DS := PROJECT(NCMEC_DS,CleanNCMEC(LEFT,COUNTER));
OUTClean_NCMEC_DS := OUTPUT(Clean_NCMEC_DS,NAMED('DataCleaned'));

NewNCMECLayout GetFIPS(Clean_NCMEC_DS Le,Cities Ri) := TRANSFORM
SELF.PrimaryFIPS := (UNSIGNED3)Ri.county_fips;
SELF             := Le; 
END;

AddFIPS := JOIN(Clean_NCMEC_DS,Cities,
                LEFT.missingcity = STD.STR.ToUpperCase(RIGHT.city) AND
                LEFT.missingstate = RIGHT.state_id,
                GetFIPS(LEFT,RIGHT),LEFT OUTER);

EXPORT FIPSDATA := MODULE

EXPORT CT_FIPS := TABLE(AddFIPS,{PrimaryFIPS,cnt := COUNT(GROUP)},PrimaryFIPS);
END;