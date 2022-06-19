## San Francisco Crime Prediction
In this project we want to predict crime categories in San Francisco based on the dataset provided on [Kaggle](https://www.kaggle.com/c/sf-crime). This dataset includes incidents over 12 years from 1/1/2003 to 5/13/2015, and derived from SF Police Department Crime Incident Reporting system. Here, we used Linear Regression and Logistic Regression to analyze the data in MATLAB. 


### Data
The original deta is available on Kaggle [San Francisco Crime Classification](https://www.kaggle.com/c/sf-crime). 
This data containes crime incidents information, and it has been pre-processed into a MATLAB file named as data_SFcrime.mat. In this dataset, each incident includes the following features:

- __Dates__ The times at which the crime occured
- __Category__ The type of crime (class label)
- __DayOfWeek__ Weekay of crime 
- __PdDistrict__ Police department district
- __Address__ Street address of crime
- __X__ and __Y__ GPS coordinates (__X__ as Longitude, and __Y__ as Latitude) of the crime location

In this project, we used Dates, DayOfWeek and PdDistrict to build a classifier. We treat all of thes these selected features as categorical variables, then use on-hot encoding technique to processed them. 

### Code 
Our codes are available 

