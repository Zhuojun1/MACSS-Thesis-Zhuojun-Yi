# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""
import pandas as pd
import numpy as np
#datas=np.load("C:/Users/Administrator/Desktop/毕业论文/Python数据处理.spydata", allow_pickle=True)



sales_buyers = pd.read_stata("C:/Users/Administrator/Desktop/毕业论文/数据/合并好的并购数据.dta")


companies = pd.concat([sales_buyers['Buyer'], sales_buyers['seller']]).unique()


executives = pd.read_excel("C:/Users/Administrator/Desktop/毕业论文/数据/TMT_POSITION(Merge Query)0.xlsx")
executives_filtered = executives[executives['csmar_listedcoinfo.Conme'].isin(companies)]
#executives.query('"csmar_listedcoinfo.Conme" in @companies')
executives_1 = pd.read_excel("C:/Users/Administrator/Desktop/毕业论文/数据/TMT_POSITION(Merge Query)1.xlsx")
executives_filtered_1 = executives_1[executives_1['csmar_listedcoinfo.Conme'].isin(companies)]
merged_executives_filtered = pd.concat([executives_filtered, executives_filtered_1], axis=0)
merged_executives_filtered.to_excel('C:/Users/Administrator/Desktop/毕业论文/数据/merged_executives_filtered.xlsx', index=False)



tmt_dict = dict(zip(merged_executives_filtered['csmar_listedcoinfo.Conme'], 
                     merged_executives_filtered['TMT_POSITION.Stkcd']))

result = np.array([tmt_dict.get(company, np.nan) for company in companies])


listed_code= pd.read_excel("C:/Users/Administrator/Desktop/毕业论文/数据/STK_LISTEDCOINFOANL(Merge Query).xlsx")

listed_code = listed_code[['csmar_listedcoinfo.Conme', 'STK_LISTEDCOINFOANL.Symbol']]
listed_code = listed_code.drop_duplicates(subset=['csmar_listedcoinfo.Conme'])

listed_code = listed_code.set_index('csmar_listedcoinfo.Conme')

result = np.array([listed_code.loc[company, 'STK_LISTEDCOINFOANL.Symbol'] 
                   if company in listed_code.index else np.nan for company in companies])


companies_with_code = np.column_stack((companies, result))


df = pd.DataFrame(companies_with_code, columns=['公司名称', '股票代码'])

df.to_excel('公司名称与代码对应表.xlsx', index=False)
