IMPORT $;
HMK := $.File_AllData;

OUTPUT(HMK.unemp_ratesDS,NAMED('US_UnempByMonth'));
OUTPUT(HMK.unemp_byCountyDS,NAMED('Unemployment'));
OUTPUT(HMK.EducationDS,NAMED('Education'));
OUTPUT(HMK.pov_estimatesDS,NAMED('Poverty'));
OUTPUT(HMK.pop_estimatesDS,NAMED('Population'));
OUTPUT(HMK.PoliceDS,NAMED('Police'));
OUTPUT(HMK.FireDS,NAMED('Fire'));
OUTPUT(HMK.HospitalDS,NAMED('Hospitals'));
OUTPUT(HMK.ChurchDS,NAMED('Churches'));
OUTPUT(HMK.FoodBankDS,NAMED('FoodBanks'));
OUTPUT(HMK.mc_byStateDS,NAMED('NCMEC'));
OUTPUT(COUNT(HMK.mc_byStateDS),NAMED('NCMEC_Cnt'));
OUTPUT(HMK.City_DS,NAMED('Cities'));
OUTPUT(COUNT(HMK.City_DS),NAMED('Cities_Cnt'));
OUTPUT(HMK.ChildAutismDS,NAMED('Child_Autism_Pct'));
OUTPUT(HMK.CrimeRateDS,NAMED('Crime_Rate_Pct'));
OUTPUT(HMK.AirportDS,NAMED('Airports'));
OUTPUT(HMK.TruckStopDS,NAMED('Truck_Stops'));

