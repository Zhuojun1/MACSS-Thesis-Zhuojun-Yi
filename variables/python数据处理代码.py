# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""
import pandas as pd
import numpy as np
#datas=np.load("C:/Users/Administrator/Desktop/毕业论文/Python数据处理.spydata", allow_pickle=True)


# 读取表1和表2
sales_buyers = pd.read_stata("C:/Users/Administrator/Desktop/毕业论文/数据/合并好的并购数据.dta")
#

# 获取表1中的所有公司名称
companies = pd.concat([sales_buyers['Buyer'], sales_buyers['seller']]).unique()

# 筛选出表2中属于表1中公司的董监高
#
executives = pd.read_excel("C:/Users/Administrator/Desktop/毕业论文/数据/TMT_POSITION(Merge Query)0.xlsx")
executives_filtered = executives[executives['csmar_listedcoinfo.Conme'].isin(companies)]
#executives.query('"csmar_listedcoinfo.Conme" in @companies')
executives_1 = pd.read_excel("C:/Users/Administrator/Desktop/毕业论文/数据/TMT_POSITION(Merge Query)1.xlsx")
executives_filtered_1 = executives_1[executives_1['csmar_listedcoinfo.Conme'].isin(companies)]
#将两个表合并
merged_executives_filtered = pd.concat([executives_filtered, executives_filtered_1], axis=0)
merged_executives_filtered.to_excel('C:/Users/Administrator/Desktop/毕业论文/数据/merged_executives_filtered.xlsx', index=False)

##获取涉及公司的股票代码
# 创建示例数组companies



# 创建字典将表2中的公司全称和TMT_POSITION对应起来
tmt_dict = dict(zip(merged_executives_filtered['csmar_listedcoinfo.Conme'], 
                     merged_executives_filtered['TMT_POSITION.Stkcd']))

# 将companies数组中的每个公司名和对应的TMT_POSITION.Stkcd输出到新数组result中
result = np.array([tmt_dict.get(company, np.nan) for company in companies])


##读取公司全称和股票代码对应的excel,与全部买方和卖方公司匹配
listed_code= pd.read_excel("C:/Users/Administrator/Desktop/毕业论文/数据/STK_LISTEDCOINFOANL(Merge Query).xlsx")
# 选取表中的公司名和代码列,并去除重复数据
listed_code = listed_code[['csmar_listedcoinfo.Conme', 'STK_LISTEDCOINFOANL.Symbol']]
listed_code = listed_code.drop_duplicates(subset=['csmar_listedcoinfo.Conme'])
# 将公司名设置为索引
listed_code = listed_code.set_index('csmar_listedcoinfo.Conme')

# 将表companies公司名和表2中的代码对应起来
result = np.array([listed_code.loc[company, 'STK_LISTEDCOINFOANL.Symbol'] 
                   if company in listed_code.index else np.nan for company in companies])

# 在原数组companies的基础上增加一列代码变量
companies_with_code = np.column_stack((companies, result))

# 将结果转换为DataFrame
df = pd.DataFrame(companies_with_code, columns=['公司名称', '股票代码'])

# 将DataFrame保存为Excel文件
df.to_excel('公司名称与代码对应表.xlsx', index=False)