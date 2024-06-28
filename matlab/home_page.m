%Home Page
%   display the menu to the user(Data Base,
%                                Arduino,
%                                About us,
%                                Exit)

function [] = home_page()
% clc & clear to clear the command window and workspace
clc
clear

disp(' _  _  _  _______  _          ');   
disp('| || || |(_______)| |               ');
disp('| || || | _____   | |               ');
disp('| ||_|| ||  ___)  | |               ');
disp('| |___| || |_____ | |_____          ');
disp(' \______||_______)|_______)         ');
disp('                                    ');
disp('  ______   _____   ______   _______ ');
disp(' / _____) / ___ \ |  ___ \ (_______)');
disp('| /      | |   | || | _ | | _____   ');
disp('| |      | |   | || || || ||  ___)  ');
disp('| \_____ | |___| || || || || |_____ ');
disp(' \______) \_____/ |_||_||_||_______)');
disp('                                    ');

disp('Welcome To Resistors App');

%The path of the excel file
filePath = 'D:\Projects\matlab\Matlab Proj Resistors database\matlab\data_base.xlsx';

%check if excel file exist or not
if exist(filePath, 'file') == 0
    %create an empty excel file
    xlswrite(filePath,{'Quantitiy' 'Resistance'},'Sheet1','A1');
end

%Display menu to the user
userInput = menu_input({
    'Enter 1 to show Database 📊'
    'Enter 2 to Arduino 🤖'
    'Enter 3 to About Us 👥'
    'Enter 4 to Exit 🚪'
    });

%check user input
switch userInput
    case 1
        database_page(filePath);
    case 2
        arduino_page(filePath);
    case 3
        about_us_page();
    case 4
        %Exit program
        %Nothing to do in this case, The program will stop
end
end