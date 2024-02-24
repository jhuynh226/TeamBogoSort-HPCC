IMPORT $.File_AllData,$.FIPSDATA,STD;

NCMEC_Rec := File_AllData.mc_byState;
EDU       := File_AllData.EducationDS;
Cities    := File_AllData.City_DS;
CTFIPS    := FIPSDATA.CT_FIPS;

// OUTPUT(EDU(Fips_Code=6037));

// OUTPUT(EDU(Fips_Code=6037,(STD.Str.Find(attribute, 'Percent of adults with less than a high school diploma',1) <> 0)));

//Percent of adults with less than a high school diploma, 1970               


EDU_CT_FIPS := TABLE(EDU((STD.Str.Find(attribute, 'Percent of adults with less than a high school diploma',1) <> 0)),
                {Fips_Code,tot := ROUND(AVE(GROUP,value),2)},fips_code);
OUTPUT(SORT(EDU_CT_FIPS,-tot));
OUTPUT(EDU(Fips_Code=2160)); //County with highest illiteracy

JOIN (CTFIPS, EDU_CT_FIPS, LEFT.primaryfips = Right.fips_code);
TEMP := JOIN (CTFIPS, EDU_CT_FIPS, LEFT.primaryfips = Right.fips_code);

CORRELATION(TEMP, cnt, tot);