IMPORT $; //Nothing to import here


EXPORT File_EnhanceNCMEC := MODULE

EXPORT NCMECPlusLayout := RECORD
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
//Dataset Generated in BWR_STD_NCMEC:
EXPORT NCMECPlusDS      := DATASET('~HMK::OUT::NECMCPlus',NCMECPlusLayout,FLAT);
EXPORT NCMECPlusIDXPay  := INDEX(NCMECPlusDS,{PrimaryFIPS,missingstate,missingcity},{NCMECPlusDS},'~HMK::IDX::NECMC::FIPSStCity'); 
EXPORT BuildNewNCMECIDX := BUILD(NCMECPlusIDXPay,OVERWRITE);
END;