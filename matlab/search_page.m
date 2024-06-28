function [] = search_page(filePath)
    clc
    
    database = xlsread(filePath,'Sheet1');
    if isempty(database)
        quantity=[];
        resistors=[];
    else
        quantity = database(:,1);
        resistors = database(:,2);
    end
    
    userInput = menu_input({
        'Enter 1 to search with error 🔎'
        'Enter 2 to search in range 🔎'
        'Enter 3 to go back 🔙'
        });
    
    switch userInput
        case 1
            res = -1;
            while res<=0
              res = input('Enter resistance: ');
            end
     
            error = menu_input({
            'Enter 1 to 5% error'   
             'Enter 2 to 10% error'    
            'Enter 3 to 15% error'    
            'Enter 4 to 20% error'    
            });
        
            error = error * 5;
            
            flag = 0;
            for i=1:length(resistors)
               if ((abs(resistors(i) - res)/res)*100 <= error  )
                  flag =1;
                  fprintf('📌 Res %5i   Quantity %2i\n',resistors(i),quantity(i));
               end
            end
            
            if flag==0
                disp('The resistance is not found');
            end
            
            input('Enter key to research');
            search_page(filePath)            
            
            
        case 2
             min = -1;
            while min<=0
              min = input('Enter min resistance: ');
            end
     
            max = -1;
            while (min > max)
                  max = input('Enter max resistance: ');
            end
            
            flag = 0;
            for i=1:length(resistors)
               if  (resistors(i) >= min & resistors(i)<= max)
                   flag =1;
                 fprintf('📌 Res %5i   Quantity %2i\n',resistors(i),quantity(i));
               end
            end
            
            if flag==0
                disp('The resistance is not found');
            end
            
            input('Enter key to research');
            search_page(filePath)
     
        case 3
            database_page(filePath);
    end
end