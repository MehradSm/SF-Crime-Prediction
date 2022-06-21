# San Francisco Crime Prediction
In this project we want to predict crime categories in San Francisco based on the dataset provided on [Kaggle](https://www.kaggle.com/c/sf-crime). This dataset includes incidents over 12 years from 1/1/2003 to 5/13/2015, and derived from SF Police Department Crime Incident Reporting system. Here, we used Linear Regression and Logistic Regression to analyze the data in MATLAB. 


## Data
The original deta is available on Kaggle [San Francisco Crime Classification](https://www.kaggle.com/c/sf-crime). 
This data containes crime incidents information, and it has been pre-processed into a MATLAB file. In this dataset, each incident includes the following features:

- __Dates__ The times at which the crime occured
- __Category__ The type of crime (class label)
- __DayOfWeek__ Weekay of crime 
- __PdDistrict__ Police department district
- __Address__ Street address of crime
- __X__ and __Y__ GPS coordinates (__X__ as Longitude, and __Y__ as Latitude) of the crime location

In this project, we used Dates, DayOfWeek and PdDistrict to build a classifier. We treat all of thes these selected features as categorical variables, then used on-hot encoding technique to process them. 

## Code 
Our codes are available in three different files as follow:

* The [Visualization](https://github.com/MehradSm/SF-Crime-Prediction-/tree/main/Visualization) folder contains a MATLAB file for data visualization. 
* The [Logistic-Regression](https://github.com/MehradSm/SF-Crime-Prediction/tree/main/Logistic-Regression) folder includes a MATLAB file to predict crime using logistic regression. 
* The [Linear-Regression](https://github.com/MehradSm/SF-Crime-Prediction/tree/main/Linear-Regression) folder contains the required functions to apply linear regression method. 

## Results

Results are divided to three different sections and they are available in [Results](https://github.com/MehradSm/SF-Crime-Prediction/tree/main/Results) folder:

* Data visulaization which illustrates the 
* Logistic regression results 
* Linear Regression result 


