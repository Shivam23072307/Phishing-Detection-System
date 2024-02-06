%% Phishing Website Detection 

% Read URL 

offset=1;
for i=1:length(Matdataset)
caUserInput = Matdataset(i,:);
caUserInput = char(caUserInput);
caUserInput = num2str(caUserInput); 
disp(caUserInput);

%% Addresss Bar Based Feature Extraction 

% Based on URL Length 

P=caUserInput;
A=length(P);


if A < 54
    
    R1=1;
    
elseif (A >= 54 && A <= 75) 
    
    R1=-1;
    
else
    
    R1=0;
end


% Based on @ Symbol 

C=strfind(P,'@');
C1=sum(C,1);

if C1 >0 
    
    R2=0;
else
   
    R2=1;
    
end

% Based on // position 

D=strfind(P,'//');

if D == 6
 
    R3=0;
else
    
    R3=1;
    
end

% Based on Adding Prefix or Suffix separated by (-)

out = regexp(P,'\w*://[^/]*','match','once');
E=strfind(out,'-');
E1=length(E);

if E1 > 2
   
    R4=0;
else
  
    R4=1;
    
end

% Based on Number of dots in subdomain 

out = regexp(P,'\w*://[^/]*','match','once');
F=strfind(out,'.');
F1=length(F);

if F1 > 3
    
    R5=0;
else
    
    R5=1;
    
end

% Based on Shorting Service

G=strfind(P,'tinyurl');

if G >0 
   
    R6=0;
else
    
    R6=1;
    
end


F=[R1 R2 R3 R4 R5 R6];

xlswrite('filename.xls', [F], 1, sprintf('A%d',offset));
 offset = offset + 1;
end    