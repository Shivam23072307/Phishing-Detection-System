%% Phishing Website Detection 
% Read URL 

userPrompt = 'Enter the URL';
titleBar = 'URL';
defaultString = '';
caUserInput = inputdlg(userPrompt, titleBar, 1, {defaultString});
if isempty(caUserInput)
	return;
end; % Bail out if they clicked Cancel.
caUserInput = char(caUserInput);
caUserInput = num2str(caUserInput); % Convert from cell to string.
disp(caUserInput);

%% Addresss Bar Based Feature Extraction 

% Based on URL Length 

P=caUserInput;
A=length(P);
disp(A);

if A < 54
    
    msgbox('Correct URL');
    R1=1;
    
elseif (A >= 54 && A <= 75) 
    
    msgbox('Suspicious URL');
    R1=-1;
    
else
    msgbox('Phishing URL');
    R1=0;
end

% Based on @ Symbol 

C=strfind(P,'@');
C1=sum(C,1)

if C1 >0 
    msgbox('Phishing URL');
    R2=0;
else
    msgbox('Correct URL');
    R2=1;
    
end

% Based on // position 

D=strfind(P,'//')

if D == 6
    msgbox('Phishing URL');
    R3=0;
else
    msgbox('Correct URL');
    R3=1;
    
end

% Based on Adding Prefix or Suffix separated by (-)

out = regexp(P,'\w*://[^/]*','match','once');
E=strfind(out,'-')
E1=length(E);

if E1 > 2
    msgbox('Phishing URL');
    R4=0;
else
    msgbox('Correct URL');
    R4=1;
    
end

% Based on Number of dots in subdomain 

out = regexp(P,'\w*://[^/]*','match','once');
F=strfind(out,'.');
F1=length(F)

if F1 > 3
    msgbox('Phishing URL');
    R5=0;
else
    msgbox('Correct URL');
    R5=1;
    
end

% Based on Shorting Service

G=strfind(P,'tinyurl')

if G >0 
    msgbox('Phishing URL');
    R6=0;
else
    msgbox('Correct URL');
    R6=1;
    
end

F=[R1 R2 R3 R4 R5 R6];

% SVM Classifier 

load Train1.mat
 
mdl = fitcsvm(unnamed,unnamed1);
% Classify the test URL
Website = predict(mdl,F);

if Website ==1
     msgbox('Correct');
else 
    msgbox('Phish');
end


% Random Forest Classifier 

load Train2.mat;
nTrees=20;
features =unnamed(:,(1:6));
classLables = unnamed(:,7);
B = TreeBagger(nTrees,features,classLables, 'Method', 'classification');
 
predChar1 = B.predict(F);
predictedClass = str2double(predChar1)

if predictedClass == 1
    msgbox('Correct');
else 
    msgbox('Phish');
end


    

