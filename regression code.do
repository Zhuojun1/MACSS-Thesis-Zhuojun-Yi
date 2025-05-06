destring 年份,replace
ssc install winsor2
winsor2 Buyer_CAR1 ,replace cuts(1 99)trim
winsor2 Seller_CAR1 ,replace cuts(1 99)trim
winsor2 Total_CAR1 ,replace cuts(1 99)trim

outreg2 using miaoshu.doc, replace sum(log) keep() title(Decriptive statistics)
reg Seller_CAR1 Same_Surname
outreg2 using huigui.doc, replace tstat bdec(3) tdec(2) ctitle(Seller_CAR1)
reg Seller_CAR1 Same_Surname Same_Province Same_indus Seller_Q is_cash
outreg2 using huigui.doc, replace tstat bdec(3) tdec(2) ctitle(Seller_CAR1)
reg Seller_CAR1 Same_Surname Same_Province Same_indus Seller_Q is_cash i.年份
outreg2 using huigui.doc, replace tstat bdec(3) tdec(2) ctitle(Seller_CAR1)
reg Seller_CAR1 Same_Surname Same_Province Same_indus Seller_Q is_cash i.年份 i.Seller_Ind
outreg2 using huigui.doc, replace tstat bdec(3) tdec(2) ctitle(Seller_CAR1)

reg Buyer_CAR1 Same_Surname
outreg2 using huigui.doc, replace tstat bdec(3) tdec(2) ctitle(Buyer_CAR1)
reg Buyer_CAR1 Same_Surname Same_Province Same_indus Buyer_Q is_cash
outreg2 using huigui.doc, replace tstat bdec(3) tdec(2) ctitle(Buyer_CAR1)
reg Buyer_CAR1 Same_Surname Same_Province Same_indus Buyer_Q is_cash i.年份
outreg2 using huigui.doc, replace tstat bdec(3) tdec(2) ctitle(Buyer_CAR1)
reg Buyer_CAR1 Same_Surname Same_Province Same_indus Buyer_Q is_cash i.年份 i.Buyer_Ind
outreg2 using huigui.doc, replace tstat bdec(3) tdec(2) ctitle(Buyer_CAR1)


reg Total_CAR1 Same_Surname
outreg2 using huigui.doc, replace tstat bdec(3) tdec(2) ctitle(Total_CAR1)
reg Total_CAR1 Same_Surname Same_Province Same_indus is_cash Total_Q Total_Cash RS
outreg2 using huigui.doc, replace tstat bdec(3) tdec(2) ctitle(Total_CAR1)
reg Total_CAR1 Same_Surname Same_Province Same_indus is_cash Total_Q Total_Cash RS i.年份
outreg2 using huigui.doc, replace tstat bdec(3) tdec(2) ctitle(Total_CAR1)

reg IsSucceed Same_Surname
outreg2 using huigui.doc, replace tstat bdec(3) tdec(2) ctitle(IsSucceed)
reg IsSucceed Same_Surname Same_Province Same_indus is_cash ExpenseValue Total_Q Total_Cash RS Total_Lev
outreg2 using huigui.doc, replace tstat bdec(3) tdec(2) ctitle(IsSucceed)
reg IsSucceed Same_Surname Same_Province Same_indus is_cash ExpenseValue Total_Q Total_Cash RS Total_Lev i.年份
outreg2 using huigui.doc, replace tstat bdec(3) tdec(2) ctitle(IsSucceed)

gen Same_B_Surname=1 if Same_Surname==1& Same_S_Surname==0
replace Same_B_Surname=0 if  Same_B_Surname==.
reg Seller_CAR1 Same_S_Surname Same_B_Surname Same_Province Same_indus Seller_Q is_cash
outreg2 using huigui.doc, replace tstat bdec(3) tdec(2) ctitle(Seller_CAR1)
reg Seller_CAR1 Same_S_Surname Same_B_Surname Same_Province Same_indus Seller_Q is_cash i.年份
outreg2 using huigui.doc, replace tstat bdec(3) tdec(2) ctitle(Seller_CAR1)
reg Seller_CAR1 Same_S_Surname Same_B_Surname Same_Province Same_indus Seller_Q is_cash i.年份 i.Seller_Ind
outreg2 using huigui.doc, replace tstat bdec(3) tdec(2) ctitle(Seller_CAR1)
reg Buyer_CAR1 Same_S_Surname Same_B_Surname Same_Province Same_indus Buyer_Q is_cash 
outreg2 using huigui.doc, replace tstat bdec(3) tdec(2) ctitle(Buyer_CAR1)
reg Buyer_CAR1 Same_S_Surname Same_B_Surname Same_Province Same_indus Buyer_Q is_cash i.年份
outreg2 using huigui.doc, replace tstat bdec(3) tdec(2) ctitle(Buyer_CAR1)
reg Buyer_CAR1 Same_S_Surname Same_B_Surname Same_Province Same_indus Buyer_Q is_cash i.年份 i.Buyer_Ind
outreg2 using huigui.doc, replace tstat bdec(3) tdec(2) ctitle(Buyer_CAR1)
reg Total_CAR1 Same_S_Surname Same_B_Surname Same_Province Same_indus is_cash Total_Q Total_Cash RS
outreg2 using huigui.doc, replace tstat bdec(3) tdec(2) ctitle(Total_CAR1)
reg Total_CAR1 Same_S_Surname Same_B_Surname Same_Province Same_indus is_cash Total_Q Total_Cash RS i.年份
outreg2 using huigui.doc, replace tstat bdec(3) tdec(2) ctitle(Total_CAR1)





gen Same_Surname_BothSOE=Same_Surname * Both_SOE
gen Same_Surname_BuyerSOE=Same_Surname * Buyer_SOE
gen Same_Surname_SellerSOE=Same_Surname * Seller_SOE
//reg Seller_CAR1 Same_Surname Seller_SOE Same_Surname_SellerSOE Seller_Cash Seller_LEV ExpenseValue Seller_Q is_cash Same_Province Seller_MarketValue i.年份 i.Seller_Ind
//outreg2 using huigui.doc, replace tstat bdec(3) tdec(2) ctitle(Seller_CAR1)
reg Seller_CAR1 Same_Surname Same_Province Same_indus Seller_Q is_cash i.年份 i.Seller_Ind if Seller_SOE==1 ,r//显著
reg Seller_CAR1 Same_Surname Same_Province Same_indus Seller_Q is_cash i.年份 i.Seller_Ind if Seller_SOE==0 ,r//不显著
reg Seller_CAR1 Same_Surname Same_Province Same_indus Seller_Q is_cash i.年份 i.Seller_Ind if Both_SOE==1 ,r//显著
reg Seller_CAR1 Same_Surname Same_Province Same_indus Seller_Q is_cash i.年份 i.Seller_Ind if Both_SOE==0 ,r//不显著
reg Buyer_CAR1 Same_Surname Same_Province Same_indus Buyer_Q is_cash i.年份 i.Buyer_Ind if Buyer_SOE==1,r//显著
reg Buyer_CAR1 Same_Surname Same_Province Same_indus Buyer_Q is_cash i.年份 i.Buyer_Ind if Buyer_SOE==0,r//不显著
reg Buyer_CAR1 Same_Surname Same_Province Same_indus Buyer_Q is_cash i.年份 i.Buyer_Ind if Seller_SOE ==1,r//显著
reg Buyer_CAR1 Same_Surname Same_Province Same_indus Buyer_Q is_cash i.年份 i.Buyer_Ind if Seller_SOE ==0,r//不显著
reg Total_CAR1 Same_Surname Same_Province Same_indus is_cash Total_Q Total_Cash RS if Seller_SOE ==1,r//显著 Buyer_SOE==1/0都不显著
outreg2 using huigui.doc, replace tstat bdec(3) tdec(2) ctitle(Total_CAR1)
reg Total_CAR1 Same_Surname Same_Province Same_indus is_cash Total_Q Total_Cash RS if Seller_SOE ==0,r//不显著
outreg2 using huigui.doc, replace tstat bdec(3) tdec(2) ctitle(Total_CAR1)
reg Total_CAR1 Same_Surname Same_Province Same_indus is_cash Total_Q Total_Cash RS if Both_SOE ==1,r//显著
outreg2 using huigui.doc, replace tstat bdec(3) tdec(2) ctitle(Total_CAR1)
reg Total_CAR1 Same_Surname Same_Province Same_indus is_cash Total_Q Total_Cash RS if Both_SOE ==0,r//不显著
outreg2 using huigui.doc, replace tstat bdec(3) tdec(2) ctitle(Total_CAR1)

gen Same_EquityNature=1 if Buyer_SOE==Seller_SOE
replace Same_EquityNature =0 if  Same_EquityNature ==.
reg Total_CAR1 Same_Surname Same_Province Same_indus is_cash Total_Q Total_Cash RS if Same_EquityNature ==1,r//显著
outreg2 using huigui.doc, replace tstat bdec(3) tdec(2) ctitle(Total_CAR1)
reg Total_CAR1 Same_Surname Same_Province Same_indus is_cash Total_Q Total_Cash RS if Same_EquityNature ==0,r
outreg2 using huigui.doc, replace tstat bdec(3) tdec(2) ctitle(Total_CAR1)
reg Seller_CAR1 Same_Surname Same_Province Same_indus Seller_Q is_cash i.年份 i.Seller_Ind if Same_EquityNature ==1 ,r
reg Seller_CAR1 Same_Surname Same_Province Same_indus Seller_Q is_cash i.年份 i.Seller_Ind if Same_EquityNature ==0 ,r


winsor2 Buyer_CAR2 ,replace cuts(1 99)trim
winsor2 Seller_CAR2 ,replace cuts(1 99)trim
winsor2 Total_CAR3,replace cuts(1 99)trim
reg Seller_CAR5 Same_Surname Same_Province Same_indus Seller_Q is_cash i.年份 i.Seller_Ind
outreg2 using huigui.doc, replace tstat bdec(3) tdec(2) ctitle(Seller_CAR)
reg Buyer_CAR2 Same_Surname Same_Province Same_indus Buyer_Q is_cash i.年份 i.Buyer_Ind
outreg2 using huigui.doc, replace tstat bdec(3) tdec(2) ctitle(Buyer_CAR)
reg Total_CAR3 Same_Surname Same_Province Same_indus Total_Q Total_Cash RS is_cash i.年份
outreg2 using huigui.doc, replace tstat bdec(3) tdec(2) ctitle(Total_CAR)
