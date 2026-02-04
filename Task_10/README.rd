Task_10


table = (data.groupby(['a/b group', 'converted']).size().unstack(fill_value = 0))
table

H0 (Null Hypothesis): Conversion rate of ad group == conversion rate of psa group

H1 (Alternative Hypothesis): Conversion rate of ad group != conversion rate of psa group

Significance level (alpha) = 0.05

