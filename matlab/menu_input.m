%This function used to print the menu to the user
%and enforce the user to enter a value within the range

%INPUT [list] --> Vector of strings that will be
%                 displayed to the user

%OUTPUT [userInput] --> The value user entered,
%                       and also within the range

function[userInput] = menu_input(list)
    %get the size of menu
    si = length(list);
    
    %print the menu
    for i=1:si
       fprintf('---> %s\n',list{i}); 
    end

        %get user value
        temp = input('Enter num: ');

        %enforce the user to enter a value within range
        while (temp > si | temp <= 0)
            disp('Wrong Input 😡');
            temp = input('Enter num again: ');
        end 
        userInput = temp;
    
end