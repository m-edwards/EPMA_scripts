% This script can be used to extract element concentrations from a
% quantified X-ray map output by CalcImage. You will need to modify the
% script to suit your data by 1) inputting the name of the quantified X-ray
% map data file 2) updating the location of the folder containing your spot
% polygons (generated using a separate script), and 3) modifying the
% element name and column locations to match your data file. 

clc
close all

% load data 
data = load('YOURDATA.txt'); %change this for different samples!  

% create directory, look for .csv files that correspond to spot outputs 
polygon_folder = '/Users/YourUsername/Documents/MATLAB/Spot_polygon_folder'; %change this to match your folder containing spot polygons 
filePattern = fullfile(polygon_folder, '*csv'); 
spots = dir(filePattern);

results = {length(spots),50}; % preallocate cell array to store results

for i = 1 : length(spots)
    
% load data in loop -- be sure to check that the columns line up with the proper elements!    
x = data(:,2);
y = data(:,3);
Si = data(:,7);
Al = data(:,8);
Na = data(:,9);
Mg = data(:,10);
Fe = data(:,11);
Ti = data(:,12);
Sr = data(:,13);
P = data(:,14);
K = data(:,15);
Ca = data(:,16);
Total = data(:,18);
Calc_O = data(:,19);

baseFileName = spots(i).name;
fullFileName = fullfile(polygon_folder, baseFileName);
%fprintf(1, 'Now reading %s\n', fullFileName); 

polygon = load(fullFileName);
x_polygon = polygon(:,1);
y_polygon = polygon(:,2);
isin = inpolygon(x, y, x_polygon, y_polygon); %determines whether pixels are in circle approximator polygon defined by each spot file

% Si
Si(~isin) = NaN; %ignores all data outside of polygon 
avg_Si = nanmean(Si); %caculates mean for all pixels inside of polygon
stdev_Si = nanstd(Si); %calculates standard deviation for all pixels inside of polygon
Si(Si > (avg_Si + 2*stdev_Si))=NaN; %+2 S.D. outlier rejection 
Si(Si < (avg_Si - 2*stdev_Si))=NaN; %-2 S.D. outlier rejection
avg_Si_filtered = nanmean(Si); %mean value excluding outliers ("hot" pixels, inclusions, cracks, etc. Up to you to determine whether this filtering is useful)
stdev_Si_filtered = nanstd(Si); %standard deviation excluding outliers

% Al
Al(~isin) = NaN;
avg_Al = nanmean(Al);
stdev_Al = nanstd(Al);
Al(Al > (avg_Al + 2*stdev_Al))=NaN;
Al(Al < (avg_Al - 2*stdev_Al))=NaN;
avg_Al_filtered = nanmean(Al);
stdev_Al_filtered = nanstd(Al);

% Na
Na(~isin) = NaN;
avg_Na = nanmean(Na);
stdev_Na = nanstd(Na);
Na(Na > (avg_Na + 2*stdev_Na))=NaN;
Na(Na < (avg_Na - 2*stdev_Na))=NaN;
avg_Na_filtered = nanmean(Na);
stdev_Na_filtered = nanstd(Na);

% Mg
Mg(~isin) = NaN;
avg_Mg = nanmean(Mg);
stdev_Mg = nanstd(Mg);
Mg(Mg > (avg_Mg + 2*stdev_Mg))=NaN;
Mg(Mg < (avg_Mg - 2*stdev_Mg))=NaN;
avg_Mg_filtered = nanmean(Mg);
stdev_Mg_filtered = nanstd(Mg);

% Fe
Fe(~isin) = NaN;
avg_Fe = nanmean(Fe);
stdev_Fe = nanstd(Fe);
Fe(Fe > (avg_Fe + 2*stdev_Fe))=NaN;
Fe(Fe < (avg_Fe - 2*stdev_Fe))=NaN;
avg_Fe_filtered = nanmean(Fe);
stdev_Fe_filtered = nanstd(Fe);

% Ti
Ti(~isin) = NaN;
avg_Ti = nanmean(Ti);
stdev_Ti = nanstd(Ti);
Ti(Ti > (avg_Ti + 2*stdev_Ti))=NaN;
Ti(Ti < (avg_Ti - 2*stdev_Ti))=NaN;
avg_Ti_filtered = nanmean(Ti);
stdev_Ti_filtered = nanstd(Ti);

% Sr
Sr(~isin) = NaN;
avg_Sr = nanmean(Sr);
stdev_Sr = nanstd(Sr);
Sr(Sr > (avg_Sr + 2*stdev_Sr))=NaN;
Sr(Sr < (avg_Sr - 2*stdev_Sr))=NaN;
avg_Sr_filtered = nanmean(Sr);
stdev_Sr_filtered = nanstd(Sr);

% P 
P(~isin) = NaN;
avg_P = nanmean(P);
stdev_P = nanstd(P);
P(P > (avg_P + 2*stdev_P))=NaN;
P(P < (avg_P - 2*stdev_P))=NaN;
avg_P_filtered = nanmean(P);
stdev_P_filtered = nanstd(P);

% K
K(~isin) = NaN;
avg_K = nanmean(K);
stdev_K = nanstd(K);
K(K > (avg_K + 2*stdev_K))=NaN;
K(K < (avg_K - 2*stdev_K))=NaN;
avg_K_filtered = nanmean(K);
stdev_K_filtered = nanstd(K);

% Ca
Ca(~isin) = NaN;
avg_Ca = nanmean(Ca);
stdev_Ca = nanstd(Ca);
Ca(Ca > (avg_Ca + 2*stdev_Ca))=NaN;
Ca(Ca < (avg_Ca - 2*stdev_Ca))=NaN;
avg_Ca_filtered = nanmean(Ca);
stdev_Ca_filtered = nanstd(Ca);

% Total
Total(~isin) = NaN;
avg_Total = nanmean(Total);
stdev_Total = nanstd(Total);
Total(Total > (avg_Total + 2*stdev_Total))=NaN;
Total(Total < (avg_Total - 2*stdev_Total))=NaN;
avg_Total_filtered = nanmean(Total);
stdev_Total_filtered = nanstd(Total);

% Calc_O
Calc_O(~isin) = NaN;
avg_Calc_O = nanmean(Calc_O);
stdev_Calc_O = nanstd(Calc_O);
Calc_O(Calc_O > (avg_Calc_O + 2*stdev_Calc_O))=NaN;
Calc_O(Calc_O < (avg_Calc_O - 2*stdev_Calc_O))=NaN;
avg_Calc_O_filtered = nanmean(Calc_O);
stdev_Calc_O_filtered = nanstd(Calc_O);

% Anorthite content
% An_content = avg_Ca_filtered/40.078 / ((avg_Ca_filtered/40.078 +
% avg_Na_filtered/22.98976928)); %only useful for plagioclase maps! 

% You can add other calculations here (e.g. Fo content of olivine,
% major-element ratios, etc.). Be sure to increase the size of your results
% cell array, and add labels as necessary. 

% save results for each spot extraction to cell array
results{i,1} = baseFileName;
results{i,2} = avg_Si;
results{i,3} = stdev_Si;
results{i,4} = avg_Si_filtered;
results{i,5} = stdev_Si_filtered;
results{i,6} = avg_Al;
results{i,7} = stdev_Al;
results{i,8} = avg_Al_filtered;
results{i,9} = stdev_Al_filtered;
results{i,10} = avg_Na;
results{i,11} = stdev_Na;
results{i,12} = avg_Na_filtered;
results{i,13} = stdev_Na_filtered;
results{i,14} = avg_Mg;
results{i,15} = stdev_Mg;
results{i,16} = avg_Mg_filtered;
results{i,17} = stdev_Mg_filtered;
results{i,18} = avg_Fe;
results{i,19} = stdev_Fe;
results{i,20} = avg_Fe_filtered;
results{i,21} = stdev_Fe_filtered;
results{i,22} = avg_Ti;
results{i,23} = stdev_Ti;
results{i,24} = avg_Ti_filtered;
results{i,25} = stdev_Ti_filtered;
results{i,26} = avg_Sr;
results{i,27} = stdev_Sr;
results{i,28} = avg_Sr_filtered;
results{i,29} = stdev_Sr_filtered;
results{i,30} = avg_P;
results{i,31} = stdev_P;
results{i,32} = avg_P_filtered;
results{i,33} = stdev_P_filtered;
results{i,34} = avg_K;
results{i,35} = stdev_K;
results{i,36} = avg_K_filtered;
results{i,37} = stdev_K_filtered;
results{i,38} = avg_Ca;
results{i,39} = stdev_Ca;
results{i,40} = avg_Ca_filtered;
results{i,41} = stdev_Ca_filtered;
results{i,42} = avg_Total;
results{i,43} = stdev_Total;
results{i,44} = avg_Total_filtered;
results{i,45} = stdev_Total_filtered;
results{i,46} = avg_Calc_O;
results{i,47} = stdev_Calc_O;
results{i,48} = avg_Calc_O_filtered;
results{i,49} = stdev_Calc_O_filtered;
%results{i,50} = An_content; %only useful for plagioclase maps! 
end 

% generate labels for table
labels{1,1} = 'fullFileName';
labels{1,2} = 'avg_Si';
labels{1,3} = 'stdev_Si';
labels{1,4} = 'avg_Si_filtered';
labels{1,5} = 'stdev_Si_filtered';
labels{1,6} = 'avg_Al';
labels{1,7} = 'stdev_Al';
labels{1,8} = 'avg_Al_filtered';
labels{1,9} = 'stdev_Al_filtered';
labels{1,10} = 'avg_Na';
labels{1,11} = 'stdev_Na';
labels{1,12} = 'avg_Na_filtered';
labels{1,13} = 'stdev_Na_filtered';
labels{1,14} = 'avg_Mg';
labels{1,15} = 'stdev_Mg';
labels{1,16} = 'avg_Mg_filtered';
labels{1,17} = 'stdev_Mg_filtered';
labels{1,18} = 'avg_Fe';
labels{1,19} = 'stdev_Fe';
labels{1,20} = 'avg_Fe_filtered';
labels{1,21} = 'stdev_Fe_filtered';
labels{1,22} = 'avg_Ti';
labels{1,23} = 'stdev_Ti';
labels{1,24} = 'avg_Ti_filtered';
labels{1,25} = 'stdev_Ti_filtered';
labels{1,26} = 'avg_Sr';
labels{1,27} = 'stdev_Sr';
labels{1,28} = 'avg_Sr_filtered';
labels{1,29} = 'stdev_Sr_filtered';
labels{1,30} = 'avg_P';
labels{1,31} = 'stdev_P';
labels{1,32} = 'avg_P_filtered';
labels{1,33} = 'stdev_P_filtered';
labels{1,34} = 'avg_K';
labels{1,35} = 'stdev_K';
labels{1,36} = 'avg_K_filtered';
labels{1,37} = 'stdev_K_filtered';
labels{1,38} = 'avg_Ca';
labels{1,39} = 'stdev_Ca';
labels{1,40} = 'avg_Ca_filtered';
labels{1,41} = 'stdev_Ca_filtered';
labels{1,42} = 'avg_Total';
labels{1,43} = 'stdev_Total';
labels{1,44} = 'avg_Total_filtered';
labels{1,45} = 'stdev_Total_filtered';
labels{1,46} = 'avg_Calc_O';
labels{1,47} = 'stdev_Calc_O';
labels{1,48} = 'avg_Calc_O_filtered';
labels{1,49} = 'stdev_Calc_O_filtered';
%labels{1,50} = 'An_content'; %only useful for plagioclase maps! 

results_table = cell2table(results,'VariableNames',labels);
writetable(results_table,'YOUR_SAMPLE.txt') %change this name for each sample