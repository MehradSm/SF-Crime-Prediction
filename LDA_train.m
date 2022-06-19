function [LDAmodel] = msmshgi_LDA_train(X_train, Y_train, numofClass,class)
%
% Training LDA
%
% EC 503 Learning from Data
% Gaussian Discriminant Analysis
%
% Assuming D = dimension of data
% Inputs :
% X_train : training data matrix, each row is a training data point
% Y_train : training labels for rows of X_train
% numofClass : number of classes
%
% Assuming that the classes are labeled  from 1 to numofClass
% Output :
% LDAmodel : the parameters of LDA classifier which has the following fields
% LDAmodel.Mu : numofClass * D matrix, i-th row = mean vector of class i
% LDAmodel.Sigmapooled : D * D  covariance matrix
% LDAmodel.Pi : numofClass * 1 vector, Pi(i) = prior probability of class i
%

% Write your codes here:



[ny,dy] = size(Y_train);
[n,d] = size(X_train);
LDAmodel.Mu = [];
sigma = zeros(d);
LDAmodel.Sigma = zeros(d);
LDAmodel.Pi = [];


for i=1:numofClass
    
    X_y = X_train( find( Y_train==class(i)),:)';
    [dd,nn] = size(X_y);
    one_y = ones(nn,1);
    LDAmodel.Mu(:,i) = (X_y*one_y)/nn;
    LDAmodel.Pi(i) = nn/n ;     
end


for j=1:n
    
    k = Y_train(j);
    sigma = sigma + ( (X_train(j,:))'-(LDAmodel.Mu(:,k)) )*((X_train(j,:))'-(LDAmodel.Mu(:,k)))';
        
end

LDAmodel.Sigma = sigma/n ;

end





