cd "C:\Users\Administrator\Desktop\毕业论文\CAR值计算"

import excel "TRD_Dalyr0.xlsx", firstrow clear
save temp.dta, replace


forvalues i = 1/6 {
    import excel "TRD_Dalyr`i'.xlsx", firstrow clear
    append using temp.dta
    save temp.dta, replace
}
gen date=date(Trddt,"YMD")
format date %td

save TRD_Dalyr_merge.dta, replace


import excel "TRD_Cndalym.xlsx", firstrow clear
gen date=date(Trddt,"YMD")
format date %td
save TRD_Cndalym.dta, replace

import excel "gonggaori.xlsx", firstrow clear
gen date=date(Trddt,"YMD")
format date %td
save gonggaori.dta, replace


****CAR****
clear
use "gonggaori.dta"
tostring Markettype, replace 
ssc install eventstudy2
ssc install moremata
ssc install distinct
ssc install nearmrg
ssc install _gprod
ssc install rmse
ssc install parallel
eventstudy2 Stkcd date using TRD_Dalyr_merge,ret(Dretwd) evwlb(-20) evwub(20) eswlb(-200) eswub(-20) mod(MA) marketfile(TRD_Cndalym) mar(Cdretwdtl) idmar(Markettype) car1LB(-1) car1UB(1) car2LB(-2) car2UB(2) car3LB(-3) car3UB(3) car4LB(-4) car4UB(4)car5LB(0) car5UB(1)car6LB(0) car6UB(2)car7LB(0) car7UB(3)car8LB(0) car8UB(4)car9LB(-10) car9UB(10)car10LB(0) car10UB(10)arfillevent replace

use carfile, clear
rename CAARE CAAR
rename PCAAREt_test P
rename NCAAREt_test T
drop NCAARECDA
drop PCAARECDA
drop NCAAREPatell
drop PCAAREPatell
drop NCAAREPatellADJ
drop PCAAREPatellADJ
drop NCAAREBoehmer
drop PCAAREBoehmer
drop NCAAREKolari
drop PCAAREKolari
drop NCAARECorrado_Cowan
drop PCAARECorrado_Cowan
drop NCAAREZivney_Cowan
drop PCAAREZivney_Cowan
drop NCAAREGenSign
drop PCAAREGenSign
drop NCAAREGRANKT
drop PCAAREGRANKT
drop NCAAREWilcox
drop PCAAREWilcox
gen star = "***" if P<0.01
replace star = "**" if P<0.05 & star ==""
replace star = "*" if P<0.1 & star ==""

use aarfile, clear
rename AARE AAR
rename PAAREt_test P
rename NAAREt_test T
drop NAARECDA
drop PAARECDA
drop NAAREPatell
drop PAAREPatell
drop NAAREPatellADJ
drop PAAREPatellADJ
drop NAAREBoehmer
drop PAAREBoehmer
drop NAAREKolari
drop PAAREKolari
drop NAARECorrado
drop PAARECorrado
drop NAAREZivney
drop PAAREZivney
drop NAAREGenSign
drop PAAREGenSign
drop NAAREWilcox
drop PAAREWilcox
gen star = "***" if P<0.01
replace star = "**" if P<0.05 & star ==""
replace star = "*" if P<0.1 & star ==""

****CAR****
clear
import excel "gonggaori2_Seller.xlsx", firstrow clear
gen date=date(Trddt,"YMD")
format date %td
save gonggaori2_Seller.dta, replace
use "gonggaori2_Seller.dta"
tostring Markettype, replace 
eventstudy2 Stkcd date using TRD_Dalyr_merge,ret(Dretwd) evwlb(-20) evwub(20) eswlb(-200) eswub(-20) mod(MA) marketfile(TRD_Cndalym) mar(Cdretwdtl) idmar(Markettype) car1LB(-1) car1UB(1) car2LB(-2) car2UB(2) car3LB(-3) car3UB(3) car4LB(-4) car4UB(4)car5LB(0) car5UB(1)car6LB(0) car6UB(2)car7LB(0) car7UB(3)car8LB(0) car8UB(4)car9LB(-10) car9UB(10)car10LB(0) car10UB(10)arfillevent replace

use carfile, clear
rename CAARE CAAR
rename PCAAREt_test P
rename NCAAREt_test T
drop NCAARECDA
drop PCAARECDA
drop NCAAREPatell
drop PCAAREPatell
drop NCAAREPatellADJ
drop PCAAREPatellADJ
drop NCAAREBoehmer
drop PCAAREBoehmer
drop NCAAREKolari
drop PCAAREKolari
drop NCAARECorrado_Cowan
drop PCAARECorrado_Cowan
drop NCAAREZivney_Cowan
drop PCAAREZivney_Cowan
drop NCAAREGenSign
drop PCAAREGenSign
drop NCAAREGRANKT
drop PCAAREGRANKT
drop NCAAREWilcox
drop PCAAREWilcox
gen star = "***" if P<0.01
replace star = "**" if P<0.05 & star ==""
replace star = "*" if P<0.1 & star ==""

use aarfile, clear
rename AARE AAR
rename PAAREt_test P
rename NAAREt_test T
drop NAARECDA
drop PAARECDA
drop NAAREPatell
drop PAAREPatell
drop NAAREPatellADJ
drop PAAREPatellADJ
drop NAAREBoehmer
drop PAAREBoehmer
drop NAAREKolari
drop PAAREKolari
drop NAARECorrado
drop PAARECorrado
drop NAAREZivney
drop PAAREZivney
drop NAAREGenSign
drop PAAREGenSign
drop NAAREWilcox
drop PAAREWilcox
gen star = "***" if P<0.01
replace star = "**" if P<0.05 & star ==""
replace star = "*" if P<0.1 & star ==""


