function [] = animateConductivity2()
close all;
global gui;
gui.fig = figure();
gui.p = plot(0,0);
gui.p.Parent.Position = [0.2 0.25 0.7 0.7];

gui.buttonGroup = uibuttongroup('visible','on','units','normalized','position',[0 0.4 .15 .25],'selectionchangedfcn',{@tempSelect});          %Button to Change Tempuratures
gui.r1 = uicontrol(gui.buttonGroup,'style','radiobutton','units','normalized','position',[.1 .8 1 .2],'HandleVisibility','off','string','30C');
gui.r2 = uicontrol(gui.buttonGroup,'style','radiobutton','units','normalized','position',[.1 .5 1 .2],'HandleVisibility','off','string','50C');
gui.r3 = uicontrol(gui.buttonGroup,'style','radiobutton','units','normalized','position',[.1 .2 1 .2],'HandleVisibility','off','string','70C');

gui.scrollBar = uicontrol('style','slider','units','normalized','position',[0.2 0.1 0.6 0.05],'value',1,'min',1,'max',6,'sliderstep',[1/5 1/4],'callback',{@scrollbar});  %Scroll bar to Change ion plot
scrollbar();
gui.animateButton = uicontrol('style','pushbutton','units','normalized','position',[0.05 0.05 0.1 0.1],'string','Animate','callback',{@animate});                         %animate button to automatically move scroll bar

end

function [] = animate(~,~) %Makes scrollbar move between ion plots
global gui;
for i = 1:6
    gui.scrollBar.Value = i;
    scrollbar();
    pause(1);
end
end

function [] = scrollbar(~,~)    %Changes the ion plot in view
global gui;
gui.scrollBar.Value = round(gui.scrollBar.Value);
type = gui.buttonGroup.SelectedObject.String;
plotSelectedIon(type);
end

function [] = tempSelect(~,~)  %changes the tempurature plot in view
global gui;
type = gui.buttonGroup.SelectedObject.String;
plotSelectedIon(type);
end

function [] = plotSelectedIon(type)     %accesses the correct plot 
global gui;

currentIon = gui.scrollBar.Value;


if strcmp(type,'30C')                   %Switching to correct tempurature data sheet
    data=readmatrix('30C.csv');
elseif strcmp(type,'50C')
    data=readmatrix('50C.csv');
elseif strcmp(type,'70C')
    data=readmatrix('70C.csv');
end

if gui.scrollBar.Value == 1             %Switching between ions within tempurature data sheet
    Zprime = data(:,1);
    Z2 = data(:,2);
elseif gui.scrollBar.Value == 2
    Zprime = data(:,4);
    Z2 = data(:,5);
elseif gui.scrollBar.Value == 3
    Zprime = data(:,7);
    Z2 = data(:,8);
elseif gui.scrollBar.Value == 4
    Zprime = data(:,10);
    Z2 = data(:,11);
elseif gui.scrollBar.Value == 5
    Zprime = data(:,13);
    Z2 = data(:,14);
elseif gui.scrollBar.Value == 6
    Zprime = data(:,16);
    Z2 = data(:,17);
end



gui.p = plot(Zprime,Z2,'bx');
switch currentIon                %Title of plot
    case 1
        ionString = 'NA+';
    case 2
        ionString = 'Li+';
    case 3
        ionString = 'K+';
    case 4
        ionString = 'Ca2+';
    case 5
        ionString = 'Ba2+';
    case 6
        ionString = 'Mg2+';
 
end
    
    title(['Identity of Ion: ' ionString]);



end
