% Logistic Regression Classification

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
one = ones(length(pdd_onehot),1);
features = horzcat(concat,one); 


% Spliting Data to Test and Training set

train_len = round(0.6*size(features,1));
X_train = features(1:train_len,:);
Y_train = Category(1:train_len);

X_test = features(train_len+1:length(features),:);
Y_test = Category(train_len+1:length(features));

% Class Labels For Y_test (computing logloss)
class_uniq = sort(unique(Category));
class_label = zeros(length(Y_test),1);
for i=1:length(class_uniq)
    
    class_label(strcmp(Y_test,class_uniq(i))) = i;
    
    
end

%% Training 

[n,d] = size(X_train);
[nn,dd] = size(X_test);
m = length(unique(Y_train));
lambda = 100;
eta = 1e-05; %size steps
tmax = 500;

% Initiliazing 
W = zeros(m,d);
obj_func = [];
CCR_train = [];
CCR_test = [];
logloss = [];

% Indicator Function
indic_train = zeros(m,n);
for i=1:m
   indic_train(i,:) = strcmp(Y_train,class_uniq(i));
    
end


% Gradient Descent
for t=1:tmax
   
    NLL_grad_num = exp(W*X_train');
    NLL_grad_den = sum(NLL_grad_num);
    NLL_grad = ((NLL_grad_num./NLL_grad_den)-indic_train)*X_train;
    NLL = sum(log(NLL_grad_den)) - sum(sum(W.*(indic_train*X_train)));
    
    obj_func(t) = NLL + (lambda/2)* sum( sum(W.^2,2) );
    obj_func_grad = NLL_grad + lambda*W;
    
    % Updating Parameters
    W = W - eta*NLL_grad;
    
    % Trining CCR
    %prob_train = exp(W*X_train')./(sum(exp(W*X_train')));
    [~,class_est_train] = max(W*X_train');
    CCR_train(t) = sum(strcmp(class_uniq(class_est_train),Y_train))/n;
    
    %%%%%%%%%%%%%%%%%%%%%%% Test %%%%%%%%%%%%%%%%%%%%%%%
    % test ccr
    %prob_test = exp(W*X_test')./(sum(exp(W*X_test')));
    [~,class_est_test] = max(W*X_test');
    CCR_test(t) = sum(strcmp(class_uniq(class_est_test),Y_test))/nn;
    
    % test logloss
    W_logloss = W(class_label,:);
    logloss_num = exp(sum(W_logloss.*X_test,2));
    logloss_den = sum(exp(W*X_test'));
    prob_log = logloss_num'./logloss_den;
    prob_log(prob_log<=10^-10)=10^-10;
    logloss(t) = -(1/nn)*(sum(log(prob_log)));
    
    
end


%% Results

% Values Of Objective Function
t = 1:tmax;
figure(1);
plot(t,obj_func);
xlabel('iterations')
ylabel('Objective Function')
title('Values of Objective Function Vs. Iterations')


% Train CCR 
figure(2);
plot(t,CCR_train);
xlabel('iterations')
ylabel('Train CCR')
title('Training CCR Vs. Iterations') 



% Test CCR 
figure(3);
plot(t,CCR_test);
xlabel('iterations')
ylabel('Test CCR')
title('Test CCR Vs. Iterations') 


% Test Logloss
figure(4);
plot(t,logloss);
xlabel('iterations')
ylabel('Test Logloss')
title('Test Logloss Vs. Iterations')


% Histigram of Predicted Label
Cat = {'ARSON','ASSAULT','BAD CHECKS','BRIBERY','BURGLARY','DISORDERLY CONDUCT','DRIVING UNDER THE INFLUENCE',...
    'DRUG/NARCOTIC','DRUNKENNESS','EMBEZZLEMENT','EXTORTION','FAMILY OFFENSES','FORGERY/COUNTERFEITING','FRAUD',...
    'GAMBLING','KIDNAPPING','LARCENY/THEFT','LIQUOR LAWS','LOITERING','MISSING PERSON','NON-CRIMINAL','OTHER OFFENSES'...
    ,'PORNOGRAPHY/OBSCENE MAT','PROSTITUTION','RECOVERED VEHICLE','ROBBERY','RUNAWAY','SECONDARY CODES','SEX OFFENSES FORCIBLE'...
    ,'SEX OFFENSES NON FORCIBLE','STOLEN PROPERTY','SUICIDE','SUSPICIOUS OCC','TREA','TRESPASS','VANDALISM','VEHICLE THEFT','WARRANTS','WEAPON LAWS'} ;

predict_label = Cat(class_est_test);
predict = categorical(predict_label,Cat,'Ordinal',true);
figure(5);
%histogram(predict,'Normalization','pdf')
histogram(predict)
xticklabels(Cat)
xtickangle(45)
xlabel('predicted labels')
ylabel('Histogram of predicted labels')
title('Histogram of predicted labels')

correct = class_est_test(strcmp(class_uniq(class_est_test),Y_test));
predict_correct_label = Cat(correct);
predict_correct = categorical(predict_correct_label,Cat,'Ordinal',true);
figure(6);
histogram(predict_correct)
xticklabels(Cat)
xtickangle(45)
xlabel('predicted labels')
ylabel('Histogram of correclty predicted labels')
title('Histogram of correctly predicted labels')


