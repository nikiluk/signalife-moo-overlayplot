close all
clear all
clc

% file containing features
file_features = '2014_06_24_data_template_neuron_features.xls'; % file containing neuron features data in cells a2:y232
sheet = 1;
xlRange = 'A2:Y58';
sample_number = '1';
file_img = strcat(sample_number, '-1-C1-MIP.tif');
img = imread(file_img);

all_neuron_features = xlsread(file_features, sheet, xlRange);
% selecting sample idx number==1
idx = (all_neuron_features(:, 2)==str2num(sample_number));
neuron_features = all_neuron_features(idx,:);
neuron_features(:, 4) = 1024 - neuron_features(:, 4); %flip Y=1024-Y
% selecting molecular markers
blue = neuron_features((neuron_features(:, 22)==1),:);
magenta = neuron_features((neuron_features(:, 23)==1),:);
% selecting k-means class
c1 = neuron_features((neuron_features(:, 24)==1),:); % 'o'
c2 = neuron_features((neuron_features(:, 24)==2),:); % '*'
c3 = neuron_features((neuron_features(:, 24)==3),:); % 's'
c4 = neuron_features((neuron_features(:, 24)==4),:); % '^'

X = neuron_features(:, 3);
Y = neuron_features(:, 4);
Z = neuron_features(:, 24);

figure
imagesc(flipud(img));
%imagesc(img);
hold on;
colormap(bone);
neurons = length(X);
myColorMap = rand(neurons, 3);
scatter3(X,Y,Z,20,'white');
hold on;
 scatter3(magenta(:,3),magenta(:,4),magenta(:,24),70,'red','LineWidth',1.5);
 hold on;
 scatter3(blue(:,3),blue(:,4),blue(:,24),150,'blue','LineWidth',1.5);
 hold on;
 scatter3(c1(:,3),c1(:,4),c1(:,24),16,'green','o');
 hold on;
 scatter3(c2(:,3),c2(:,4),c2(:,24),16,'green','*');
 hold on;
 scatter3(c3(:,3),c3(:,4),c3(:,24),16,'green','s');
 hold on;
 scatter3(c4(:,3),c4(:,4),c4(:,24),16,'green','^');
zoom(2);
set(gca,'ydir','normal');
title(file_img)
xlabel('X, px') % x-axis label
ylabel('Y, px') % y-axis label
zlabel('Class 1:4') % y-axis label
axis([0,1024, 0,1024, 0,5]);

