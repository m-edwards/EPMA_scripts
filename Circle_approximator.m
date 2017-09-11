% This script takes a list of spot centers and diameters, and outputs nodes
% that approximate a circle for each spot. This is useful for calculating
% the major-element composition of a mineral grain at the same location of
% a laser spot for LA work. It is recommended that the script is copied
% into a separate folder for each sample because the ouputs are not named
% by sample name, only by spot number. Thus, it will overwrite previous
% spot files. 

clc 
clear all
close all

% Prior to loading data ensure that column 1 corresponds to the x position,
% column 2 corresponds to the y position, and column 3 corresponds to the
% diameter of the circle (i.e., laser spot size).

data = load ('test.txt'); 
nodes = 36; % change if more or less nodes are desired. 36 is arbitrary.

for i = 1:size(data)
    
    x(i) = data(i,1); 
    y(i) = data(i,2);
    d(i) = data(i,3);
    
    for n = 1:nodes
        angle(n) = [(n-1)*360/nodes]; % angle of each node
        x_new(n) = [sind(angle(n))*d(i)/2 + x(i)]; % calculate the x position for each node
        y_new(n) = [cosd(angle(n))*d(i)/2 + y(i)]; % calculate the y position for each node
        filename = ['spot' num2str(i) '.csv']; % filename for each spot 
        dlmwrite(filename,[x_new;y_new]','precision',10) % writes node locations to .csv file 
    end
    
    % Turn the following 3 lines on to visualize output nodes for each spot
    
    % figure(i)
    % scatter (x_new,y_new)
    % daspect([1 1 1])
    
end 

% After generating the appropriate .csv files, the contents of each can be
% copied and pasted into the CalcImage/Surfer polygon extraction 'digitize'
% prompt. Alternatively, a second Matlab script (polygon_extractor.m) can 
% be used to extract multiple polygon compositions simultaneously.