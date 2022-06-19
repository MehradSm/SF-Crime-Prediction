function [Y_predict] = msmshgi_LDA_test(X_test, LDAmodel, numofClass)
%
% Testing for LDA
%
% EC 503 Learning from Data
% Gaussian Discriminant Analysis
%
% Assuming D = dimension of data
% Inputs :
% X_test : test data matrix, each row is a test data point
% numofClass : number of classes 
% LDAmodel : the parameters of LDA classifier which has the follwoing fields
% LDAmodel.Mu : numofClass * D matrix, i-th row = mean vector of class i
% LDAmodel.Sigmapooled : D * D  covariance matrix
% LDAmodel.Pi : numofClass * 1 vector, Pi(i) = prior probability of class i
%
% Assuming that the classes are labeled  from 1 to numofClass
% Output :
% Y_predict predicted labels for all the testing data points in X_test

% Write your codes here:

[n,d] = size(X_test);
for j=1:n
    prob_LDA = [];
    for i=1:numofClass
        prob_LDA(i) = LDAmodel.Mu(:,i)'*inv(LDAmodel.Sigma)*X_test(j,:)' - 0.5*LDAmodel.Mu(:,i)'*inv(LDAmodel.Sigma)*LDAmodel.Mu(:,i)+log(LDAmodel.Pi(i));
    end
    
    [argvalue, argmax] = max(prob_LDA);
    Y_predict(j)=argmax;

end


end
