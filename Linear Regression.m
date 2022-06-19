% Using LDA for Classification 

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

features = horzcat(hour_onehot,day_onehot,pdd_onehot);


% Spliting Data to Test and Training set

train_len = round(0.6*size(features,1));
X_train = features(1:train_len,:);
Y_train = Category(1:train_len);

X_test = features(train_len+1:length(features),:);
Y_test = Category(train_len+1:length(features));

class_uniq = sort(unique(Category));
classes = [];
for i=1:length(class_uniq)
    classes(i) =i ;
    
end
classes = classes';

% Class Labels For Y_train 

class_label_train = zeros(length(Y_train),1);
for i=1:length(class_uniq)
    
    class_label_train(strcmp(Y_train,class_uniq(i))) = i;
    
    
end

% Class Labels For Y_test 
 class_label_test = zeros(length(Y_test),1);
 for i=1:length(class_uniq)
    
    class_label_test(strcmp(Y_test,class_uniq(i))) = i;
    
    
end

%% Training 

[N,D] = size(X_train);
[nn,dd] = size(X_test);
m = length(unique(Y_train));
numofClass =m ;


% Initiliazing 

CCR_LDA_train = [];
CCR_LDA_test = [];
CCR_train = [];
CCR_test = [];  

[LDAmodel] = msmshgi_LDA_train(X_train, class_label_train, numofClass,classes);
[Y_predict_LDAtrain] = msmshgi_LDA_test(X_train, LDAmodel, numofClass);
CCR_LDA_train = (sum(Y_predict_LDAtrain==class_label_train'))/length(Y_train);

[Y_predict_LDA] = msmshgi_LDA_test(X_test, LDAmodel, numofClass);
CCR_LDA_test = (sum(Y_predict_LDA==class_label_test'))/length(Y_test);
   
%% Results
fprintf('CCR LDA Train: %f', CCR_LDA_train)
fprintf('CCR LDA Test: %f', CCR_LDA_test)










