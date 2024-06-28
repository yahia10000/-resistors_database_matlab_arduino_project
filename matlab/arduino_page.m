function[]= arduino_page(filePath)
    clc
    database = xlsread(filePath,'Sheet1');
if isempty(database)
    quantity=[];
    resistors=[];
else
    quantity = database(:,1);
    resistors = database(:,2);
end
    
    user_input=menu_input({
                          'Enter 1 to measure resistanse 📌'
                          'Enter 2 to go back 🔙'
    });

    switch user_input
        case 1
            try
                disp('Connect to Arduino ...');
                arduino = serialport('COM6',9600);
                pause(2);
                writeline(arduino,'-');
                res = str2num(readline(arduino));
                delete(arduino);
                fprintf('The measured resistance is %i ohm\n',res);
                User_input=menu_input({
                    'Enter 1 to save resistance 📥'
                    'Enter 2 to cancel and reload page 🔃'
                    'Enter 3 to go back 🔙'
                    });

                switch User_input
                    case 1
                        index = -1;
                        for i=1:length(resistors)
                           if(( res >= resistors(i)-20 ) & ( res <= resistors(i)+20 ))
                               index = i;
                               break;
                           end
                        end

                        if index ==-1
                            input_quantity = -1;
                            while input_quantity<=0
                                 input_quantity = input('Enter quantity: ');
                            end
                            
                            database = [database ; [input_quantity res]];
                            xlswrite(filePath,{'Quantity' 'Resistors'},'Sheet1','A1');
                            xlswrite(filePath,database,'Sheet1','A2');
                            disp('The resistor is added successfully 😀');
                        else
                            disp('The resistor is exsit already 😭');
                        end
                        pause(3);
                        arduino_page(filePath)

                    case 2
                        arduino_page(filePath);
                    case 3

                        home_page();
                end
            catch
               disp('Failed to connect to Arduino');
               input('Enter key to continue...');
               arduino_page(filePath);
            end
        case 2
            home_page()
    end
    

end