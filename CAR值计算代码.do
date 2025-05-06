cd "C:\Users\Administrator\Desktop\毕业论文\CAR值计算"
// 第一步：打开第一个 Excel 文件并导入数据
import excel "TRD_Dalyr0.xlsx", firstrow clear
save temp.dta, replace

// 第二步：循环导入其他 Excel 文件，并合并到 temp.dta 文件中
forvalues i = 1/6 {
    import excel "TRD_Dalyr`i'.xlsx", firstrow clear
    append using temp.dta
    save temp.dta, replace
}
gen date=date(Trddt,"YMD")
format date %td
// 第三步：保存合并后的数据为 dta 文件
save TRD_Dalyr_merge.dta, replace

//将市场回报率导入为dta文件
import excel "TRD_Cndalym.xlsx", firstrow clear
gen date=date(Trddt,"YMD")
format date %td
save TRD_Cndalym.dta, replace
//将买方公司代码和公告日导入为dta文件
import excel "gonggaori.xlsx", firstrow clear
gen date=date(Trddt,"YMD")
format date %td
save gonggaori.dta, replace


****计算买方CAR值****
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
*------evwlb(-20)evwub(20)是我定的整个窗口上下限(之前是-3 3)；eswlb(-200)eswub(-20)是我定的估计窗口的上下限，为事件发生前的{-200，-20}天，注意估计窗口和后面的事件窗口不能有重复，我是算的事件发生后的CAR，所以后面的窗口都是从时间当天开始的，默认为{-20，20}，最多能设置10对上下限-----------
*----------------------每个公司的CAR值在crossfile中储存，CAAR（累计平均超额收益率）在carfile中储存-----------------
*----------------------CAAR的T检验结果整理------------------------------
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
*----------------------把结果复制到EXCEL就行---------------------------

*----------------------AAR的T检验结果整理------------------------------
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

****计算卖方CAR值****
clear
import excel "gonggaori2_Seller.xlsx", firstrow clear
gen date=date(Trddt,"YMD")
format date %td
save gonggaori2_Seller.dta, replace
use "gonggaori2_Seller.dta"
tostring Markettype, replace 
eventstudy2 Stkcd date using TRD_Dalyr_merge,ret(Dretwd) evwlb(-20) evwub(20) eswlb(-200) eswub(-20) mod(MA) marketfile(TRD_Cndalym) mar(Cdretwdtl) idmar(Markettype) car1LB(-1) car1UB(1) car2LB(-2) car2UB(2) car3LB(-3) car3UB(3) car4LB(-4) car4UB(4)car5LB(0) car5UB(1)car6LB(0) car6UB(2)car7LB(0) car7UB(3)car8LB(0) car8UB(4)car9LB(-10) car9UB(10)car10LB(0) car10UB(10)arfillevent replace
*------evwlb(-20)evwub(20)是我定的整个窗口上下限；eswlb(-200)eswub(-20)是我定的估计窗口的上下限，为事件发生前的{-200，-20}天，注意估计窗口和后面的事件窗口不能有重复，我是算的事件发生后的CAR，所以后面的窗口都是从时间当天开始的，默认为{-20，20}，最多能设置10对上下限-----------
*----------------------每个公司的CAR值在crossfile中储存，CAAR（累计平均超额收益率）在carfile中储存-----------------
*----------------------CAAR的T检验结果整理------------------------------
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
*----------------------把结果复制到EXCEL就行---------------------------

*----------------------AAR的T检验结果整理------------------------------
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


