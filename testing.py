import matplotlib as plt
import pandas as pd
import numpy as np

#Question 6
#The ravel is used to transform the multidimensional array into a 1D array
dataset = pd.read_csv('ECG-sample.csv', header=None).values.ravel()
plt.plot(dataset)
plt.show()

mean = pd.Series(dataset).rolling(31).mean()
std = pd.Series(dataset).rolling(31).std()
max_val = pd.Series(dataset).rolling(31).max()
min_val = pd.Series(dataset).rolling(31).min()

features = pd.DataFrame({'mean': mean, 'std': std, 'max': max_val, 'min': min_val})
features = features.dropna()

print(features)

fig, ax = plt.subplots() # Plot the std feature

ax.plot(np.arange(len(std)), std)

ax.set_title('Standard Deviation')
ax.set_xlabel('Number of Windows')
ax.set_ylabel('Standard Deviation')

plt.show()