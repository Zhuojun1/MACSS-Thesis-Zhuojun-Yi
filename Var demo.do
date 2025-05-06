login "2019312472@email.cufe.edu.cn" "4201072001new"
setLanguage "CH"

clear
set obs 100
gen year_up = mdy(1,1,2000) 
gen year_low = mdy(1,1,2023) 
local muplti = 1
gen year_up1 = .
gen year_low1 = .

while mdy(month(year_up),day(year_up),year(year_up) + 4*`muplti') < year_low{
	capture replace year_up1 = mdy(month(year_up),day(year_up),year(year_up) + 4*(`muplti'-1)) in `muplti'
	capture replace year_low1 = mdy(month(year_up),day(year_up),year(year_up) + 4*`muplti') in `muplti'
	local muplti = `muplti' + 1
}
replace year_up1 = mdy(month(year_up),day(year_up),year(year_up) + 4*(`muplti'-1)) in `muplti'
replace year_low1 = mdy(month(year_low),day(year_low),year(year_low))  in `muplti'
qui sum year_up1
local row_num = `r(N)'
format %tdCCYY-NN-DD year_up1 year_low1
tostring year_up1,replace force usedisplayformat
tostring year_low1,replace force usedisplayformat
gen year_upt = "."
gen year_lowt = "."
local row = 1 
local num = 1
while `row' <= `row_num'{
	replace year_upt = year_up1[`row']
	replace year_lowt = year_low1[`row']
	levelsof year_upt,local(year_up) 
	levelsof year_lowt,local(year_low)
    preserve 
	clear
	getData "EventID,Symbol,FirstDeclareDate,Buyer,Seller,Underlying,BusinessID,InstitutionID,TradingPositionID,LatestDeclareDate,FinishDeclareDate,LatestProgramScheduleID,IsSucceed,UnderlyingTypeID,EvaluationValue,BookValue,EvaluationChange,EvaluationRatio,EvaluationBaseDay,ApprsReptNo,EvaluationMethod,ExpenseValue,PayTypeID,SourceTypeID,MergerTypeID,IsIntelProMA,RestructuringTypeID,MARegionTypeID,CrossProvinceSign,CrossCitySign,RelevanceSign,MajorRestructuringSign,Outline" "" "STK_MA_TRADINGMAIN" `year_up' `year_low'
	tempfile STK_MA_TRADINGMAIN`num'
	save "`STK_MA_TRADINGMAIN`num''",replace  
	restore  
	local row = 1 + `row'
	local num = 1 + `num'
}
local num = `num' - 1
use `STK_MA_TRADINGMAIN1',clear
forvalues i = 2/`num'{
	append using "`STK_MA_TRADINGMAIN`i''"
}
//save STK_MA_TRADINGMAIN.dta,replace

clear
capture getData "EventID,InstitutionFullName,RelationshipID,TradingPositionID,Rank,InstitutionID,ListingSign,Symbol,ShortName,CompanyPropertyID,IndustryCode,CountryCode,RegisteredAddress,RegisteredProvince,RegisteredCity,RegisteredZipCode,OfficeAddress,OfficeProvince,OfficeCity" "" "STK_MA_INVOLVEDPARTY" "" ""
local start 0
local num   1
while (_rc != 0) | (_N != 0){
	clear
	capture getData "EventID,InstitutionFullName,RelationshipID,TradingPositionID,Rank,InstitutionID,ListingSign,Symbol,ShortName,CompanyPropertyID,IndustryCode,CountryCode,RegisteredAddress,RegisteredProvince,RegisteredCity,RegisteredZipCode,OfficeAddress,OfficeProvince,OfficeCity" "limit `start',200000" "STK_MA_INVOLVEDPARTY" "" ""
	local start = `start' + 200000
	tempfile STK_MA_INVOLVEDPARTY`num'
	save "`STK_MA_INVOLVEDPARTY`num''",replace
	local num = `num' + 1
}	
local num = `num' - 1
use `STK_MA_INVOLVEDPARTY1',clear
forvalues i = 2/`num'{
	append using "`STK_MA_INVOLVEDPARTY`i''"
	}
save STK_MA_TRADINGMAIN.dta,replace	
//路径：C:\Users\Administrator\Desktop
//search vlookup *语法格式 vlookup 新key,gen(新value) key(旧key) value(旧value)
help merge
use "C:\Users\Administrator\Desktop\STK_MA_INVOLVEDPARTY草稿.dta"
duplicates drop Buyer Seller Underlying, force
save "C:\Users\Administrator\Desktop\STK_MA_INVOLVEDPARTY草稿3.dta"
//gen Buyer=InstitutionFullName
//gen BuyerListingSign=ListingSign
//gen Seller=InstitutionFullName
//gen SellerListingSign=ListingSign
//gen Underlying=InstitutionFullName
//gen UnderlyingListingSign=ListingSign
//save "C:\Users\Administrator\Desktop\STK_MA_INVOLVEDPARTY草稿.dta"

clear
capture getData "Stkcd,Reptdt,PersonID,Name,Nationality,NativePlace,NatAreaCode,BirthPlace,BirAreaCode,Gender,Age,University,Degree,Major,Profession,Resume,PaidSign,TotalSalary,Allowance,SharEnd,IsMTMT,MTP,IsMTB,CTB,IsIdirecotr,IsDuality,IsSupervisor,Position,PositionID,ServicePosition,ServicePositionID,Funback,OveseaBack,Academic,FinBack,IsCocurP,OtherCo,OtherCoType,Director_TotCO,Director_ListCO,Stkcd_director" "" "TMT_FIGUREINF0" "2000-01-01" "2023-01-01"
local start 0
local num   1
while (_rc != 0) | (_N != 0){
	clear
	capture getData "Stkcd,Reptdt,PersonID,Name,Nationality,NativePlace,NatAreaCode,BirthPlace,BirAreaCode,Gender,Age,University,Degree,Major,Profession,Resume,PaidSign,TotalSalary,Allowance,SharEnd,IsMTMT,MTP,IsMTB,CTB,IsIdirecotr,IsDuality,IsSupervisor,Position,PositionID,ServicePosition,ServicePositionID,Funback,OveseaBack,Academic,FinBack,IsCocurP,OtherCo,OtherCoType,Director_TotCO,Director_ListCO,Stkcd_director" "limit `start',200000" "TMT_FIGUREINF0" "2000-01-01" "2023-01-01"
	local start = `start' + 200000
	tempfile TMT_FIGUREINFO`num'
	save "`TMT_FIGUREINFO`num''",replace
	local num = `num' + 1
}	
local num = `num' - 1
use `TMT_FIGUREINFO1',clear
forvalues i = 2/`num'{
	append using "`TMT_FIGUREINFO`i''"
	}
save TMT_FIGUREINFO.dta,replace	


use "C:\Users\Administrator\Desktop\STK_MA_TRADINGMAIN.dta"
rename Seller seller
rename Underlying underlying
gen Seller = substr(seller, 1, 2000)
gen Underlying = substr(underlying, 1, 2000)






//g amount_length=strlen(Seller)
//drop if amount_length>3000
merge m:1 Buyer using "C:\Users\Administrator\Desktop\STK_MA_INVOLVEDPARTY草稿3.dta", keep(match)
drop SellerListingSign UnderlyingListingSign _merge

merge m:1 Seller using "C:\Users\Administrator\Desktop\STK_MA_INVOLVEDPARTY草稿3.dta", keep(match)
drop UnderlyingListingSign _merge

merge m:1  Underlying using "C:\Users\Administrator\Desktop\STK_MA_INVOLVEDPARTY草稿3.dta", keep(match)
drop  _merge
drop if SellerListingSign=="N"
drop if BuyerListingSign=="N"

save  "C:\Users\85318\Desktop\合并好的并购数据.dta",replace
