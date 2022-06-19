% Pre Processing and Visualizing Data
clear  
close all
clc

%% Loading Data

load('data_SFcrime.mat')

%% Pre-Processing Data

%%%%%%%%%%%% Hour
%Exrtracting hours from data
date_time = datetime(Dates,'InputFormat','MM/dd/yyyy HH:mm');
Hour = hour(date_time);

%One hot version of Hour vector
hour_onehot = Hour == 0:max(Hour); 

%%%%%%%%%%%% Day
Day={'Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'};
day_onehot = zeros(length(DayOfWeek),length(Day));
for i=1:length(Day)
    day_onehot(:,i)=strcmp(DayOfWeek,Day(i));%comparing data with dictionary
end  

%%%%%%%%%%% PdD
PdD = sort(unique(PdDistrict));
pdd_onehot = zeros(length(PdDistrict),length(PdD));
for i=1:length(PdD)
    pdd_onehot(:,i)=strcmp(PdDistrict,PdD(i));%comparing data with dictionary
end  

concat = horzcat(hour_onehot,day_onehot,pdd_onehot);
%% Histogram

%%% Histogram of Days of Week
dayofweek = categorical(DayOfWeek,Day,'Ordinal',true);
figure(1);
histogram(dayofweek,'Normalization','pdf') 
xticklabels(Day)
xtickangle(45)
xlabel('Day of Week')
ylabel('Normalized Histogram')
title('Normalized Histogram of Day of Week')

%%% Histogram of Hours of Day
figure(2);
Hour_cat = categorical(Hour);
histogram(Hour_cat) 
xlabel('Hours[h]')
ylabel('Normalized Histogram')
title('Normalized Histogram of Hours')

%%% Histogram of PdDistrict
PD = {'BAYVIEW','CENTRAL','INGLESIDE','MISSION','NORTHERN','PARK','RICHMOND','SOUTHERN','TARAVAL','TENDERLOIN'};
pddistrict = categorical(PdDistrict,PD,'Ordinal',true);
figure(3);
histogram(pddistrict,'Normalization','pdf') 
xticklabels(PD)
xtickangle(45)
xlabel('PdDistrict')
ylabel('Normalized Histogram')
title('Normalized Histogram of Pd District')

%%% Histogram of Category
Categories = sort(unique(Category));
Cat = {'ARSON','ASSAULT','BAD CHECKS','BRIBERY','BURGLARY','DISORDERLY CONDUCT','DRIVING UNDER THE INFLUENCE',...
    'DRUG/NARCOTIC','DRUNKENNESS','EMBEZZLEMENT','EXTORTION','FAMILY OFFENSES','FORGERY/COUNTERFEITING','FRAUD',...
    'GAMBLING','KIDNAPPING','LARCENY/THEFT','LIQUOR LAWS','LOITERING','MISSING PERSON','NON-CRIMINAL','OTHER OFFENSES'...
    ,'PORNOGRAPHY/OBSCENE MAT','PROSTITUTION','RECOVERED VEHICLE','ROBBERY','RUNAWAY','SECONDARY CODES','SEX OFFENSES FORCIBLE'...
    ,'SEX OFFENSES NON FORCIBLE','STOLEN PROPERTY','SUICIDE','SUSPICIOUS OCC','TREA','TRESPASS','VANDALISM','VEHICLE THEFT','WARRANTS','WEAPON LAWS'} ;
CAT = categorical(Category,Cat,'Ordinal',true);
figure(4);
histogram(CAT,'Normalization','pdf') 
xticklabels(Cat)
xtickangle(45)
xlabel('Category')
ylabel('Normalized Histogram')
title('Normalized Histogram of Categories')


%% Most Likely Hour for Each Category of Crime

most_likly_hour = zeros(length(Categories),1);
for i=1:length(Categories)
   
    hour_crime = Hour( strcmp(Categories(i),Category) );
    most_likly_hour(i) = mode(hour_crime);
    
end

[Categories categorical(most_likly_hour)]
%% Most Likely Type of Crime within each PdDistrict

most_likly_crime = {};
for i=1:length(PdD)
    
    crime_pdd = Category( strcmp(PdD(i),PdDistrict) );
    crime_pdd_un = unique(crime_pdd);
    each_crime = zeros(length(crime_pdd_un),1);
    for j=1:length(crime_pdd_un)
        
       each_crime(j) = sum(strcmp(crime_pdd_un(j), crime_pdd)); 
       
    end
    [~, itemp] = max(each_crime);
    most_likly_crime(i) = crime_pdd_un(itemp) ;
    
end

[PdD most_likly_crime']
%% Google Map Visualization 

% Drug/Narcotic
long_drug = X(find(strcmp({'DRUG/NARCOTIC'},Category)));
lat_drug =  Y(find(strcmp({'DRUG/NARCOTIC'},Category)));
figure(5);
plot(long_drug,lat_drug,'.r','MarkerSize',3)
xlabel('Longtitude')
ylabel('Latitude')
title('Locations of Drug/Narcotic Crime' )
plot_google_map

% LARCENY/THEFT
long_larceny = X(find(strcmp({'LARCENY/THEFT'},Category)));
lat_larceny =  Y(find(strcmp({'LARCENY/THEFT'},Category)));
figure(6);
plot(long_larceny,lat_larceny,'.b','MarkerSize',3)
xlabel('Longtitude')
ylabel('Latitude')
title('Locations of LARCENY/THEFT Crime' )
plot_google_map

% ROBBERY
long_rob = X(find(strcmp({'ROBBERY'},Category)));
lat_rob =  Y(find(strcmp({'ROBBERY'},Category)));
figure(7);
plot(long_rob,lat_rob,'.k','MarkerSize',3)
xlabel('Longtitude')
ylabel('Latitude')
title('Locations of ROBBERY Crime' )
plot_google_map
