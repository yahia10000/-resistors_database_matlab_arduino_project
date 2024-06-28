%DataBase Page 
%   display the stored data to the user 
%   and enable the user to delete, plot and search in 
%   the stored data

function [] = database_page(filePath)
    %clc to clear the command window
    clc;

    %open excel file
    database = xlsread(filePath,'Sheet1');

    %check if file is empty or not
    if isempty(database)
        quantity=[];
        resistors=[];
    else
        %load the stored data into the program
        quantity = database(:,1);
        resistors = database(:,2);
    end

    %display the stored data in beautiful table
    disp('------------------');
    disp('The Database is :-');
    disp('------------------');
    disp('      Quantity    Value');
    for i=1:length(quantity)
        fprintf('%2i)  %5i         %i\n',i,quantity(i),resistors(i));
    end
    disp('------------------');

    %print the menu and get the user input
    user_input = menu_input({
        'Enter 1 to delete row ❎'
        'Enter 2 to plot 📈'    
        'Enter 3 to search 🔎'    
        'Enter 4 to go back 🔙' 
    });

    %check user input
    switch user_input
        case 1
            %check if the database is empty
            if isempty(database)
                disp('No data found 😡');
                %Stop the program 2 second then reload the current page
                pause(3);
            else
                %get the number of row to be deleted
                userInput = input('Enter no of row to be deleted:');
        
                %check if the entered value is within the range
                if (userInput >0 & userInput<=length(quantity))
                    %delete the row
                    database(userInput,:)=[];
            
                    %delete the old excel file
                    delete(filePath);
                    %then recreate the excel with new data
                    if (isempty(database))
                        xlswrite(filePath,{'Quantity' 'Resistors'},'Sheet1','A1');
                    else 
                        xlswrite(filePath,{'Quantity' 'Resistors'},'Sheet1','A1');
                        xlswrite(filePath,database,'Sheet1','A2');
                    end
                else
                    %print 'Wrong' if user typed a value not in range
                    disp('Wrong Input 😡');
                    %Stop the program 2 second then reload the current page
                    pause(3);
                end
            end
            %reload the page again
            database_page(filePath);
        case 2
            %plot the database in Bars with dashed line
            stem(resistors,quantity,'LineStyle','--','MarkerFaceColor','red','MarkerEdgeColor','green')
            xlabel('Resistors (ohm)');
            ylabel('Quantities');
            database_page(filePath);
        case 3
            %go to search page
            search_page(filePath);
        case 4
            %go to home page
            home_page();
    end
end