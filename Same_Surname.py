import pandas as pd
import numpy as np

df_main = pd.read_excel("C:/Users/Administrator/Desktop/并购公司主表.xlsx")

df_execs = pd.read_excel('C:/Users/Administrator/Desktop/TMT_POSITION(Merge Query).xlsx')

df_main['FirstDeclareDate'] = pd.to_datetime(df_main['FirstDeclareDate'])
df_execs['TMT_POSITION.StartDate'] = pd.to_datetime(df_execs['TMT_POSITION.StartDate'])
df_execs['TMT_POSITION.Stkcd'] = df_execs['TMT_POSITION.Stkcd'].astype(str)


result = {}

for event_code in df_main['EventID'].unique():
    buyer = str(df_main.loc[df_main['EventID'] == event_code, 'Buyer_code'].iloc[0])
    seller = str(df_main.loc[df_main['EventID'] == event_code, 'seller_code'].iloc[0])

    announcement_time = df_main.loc[df_main['EventID'] == event_code, 'FirstDeclareDate'].iloc[0]

    buyer_execs = df_execs.loc[(df_execs['TMT_POSITION.Stkcd'] == buyer) & (df_execs['TMT_POSITION.StartDate'] < announcement_time)]
    seller_execs = df_execs.loc[(df_execs['TMT_POSITION.Stkcd'] == seller) & (df_execs['TMT_POSITION.StartDate'] < announcement_time)]

    has_same_surname = False
    for buyer_name in buyer_execs['TMT_POSITION.Name'].unique():
        buyer_surname = buyer_name[:1] 
        for seller_name in seller_execs['TMT_POSITION.Name'].unique():
            seller_surname = seller_name[:1]
            if buyer_surname == seller_surname:
                has_same_surname = True
                break
        if has_same_surname:
            break

    result[event_code] = 1 if has_same_surname else 0

df_main['Same_Surname'] = df_main['EventID'].map(result)



df_main.to_excel("C:/Users/Administrator/Desktop/毕业论文/并购公司主表（有同姓高管1）.xlsx")



import pandas as pd
import numpy as np

df_main = pd.read_excel("C:/Users/Administrator/Desktop/并购公司主表.xlsx")

df_execs = pd.read_excel('C:/Users/Administrator/Desktop/TMT_POSITION(Merge Query).xlsx')

df_main['FirstDeclareDate'] = pd.to_datetime(df_main['FirstDeclareDate'])
df_execs['TMT_POSITION.StartDate'] = pd.to_datetime(df_execs['TMT_POSITION.StartDate'])
df_execs['TMT_POSITION.Stkcd'] = df_execs['TMT_POSITION.Stkcd'].astype(str)


result = {}
excluded_surnames = ['张', '王', '李', '刘', '陈', '杨', '黄', '赵', '吴', '周', '徐', '孙', '马', '朱', '胡', '郭', '何', '林', '罗', '高','郑', '梁', '谢', '宋', '唐', '许', '韩', '邓', '冯','曹','彭', '曾', '肖', '田', '董', '潘', '袁','蔡', '蒋', '余','于', '杜', '叶', '程', '魏', '苏', '吕','丁', '任', '卢']
for event_code in df_main['EventID'].unique():
    buyer = str(df_main.loc[df_main['EventID'] == event_code, 'Buyer_code'].iloc[0])
    seller = str(df_main.loc[df_main['EventID'] == event_code, 'seller_code'].iloc[0])

    announcement_time = df_main.loc[df_main['EventID'] == event_code, 'FirstDeclareDate'].iloc[0]

    buyer_execs = df_execs.loc[(df_execs['TMT_POSITION.Stkcd'] == buyer) & (df_execs['TMT_POSITION.StartDate'] < announcement_time)]
    seller_execs = df_execs.loc[(df_execs['TMT_POSITION.Stkcd'] == seller) & (df_execs['TMT_POSITION.StartDate'] < announcement_time)]

    has_same_surname = False
    for buyer_name in buyer_execs['TMT_POSITION.Name'].unique():
        buyer_surname = buyer_name[:1]  
        if buyer_surname in excluded_surnames:
            continue
        for seller_name in seller_execs['TMT_POSITION.Name'].unique():
            seller_surname = seller_name[:1]  
            if seller_surname in excluded_surnames:
                continue
            if buyer_surname == seller_surname:
                has_same_surname = True
                break
        if has_same_surname:
            break

    result[event_code] = 1 if has_same_surname else 0



df_main['Same_S_Surname'] = df_main['EventID'].map(result)


df_main.to_excel("C:/Users/Administrator/Desktop/并购公司主表（有同小姓高管50）.xlsx")
