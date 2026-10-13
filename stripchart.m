try
    fclose(instrfind);
catch
end

s1 = serial('COM5', ...
    'BaudRate', 115200, ...
    'Parity', 'none', ...
    'DataBits', 8, ...
    'StopBits', 1, ...
    'FlowControl', 'none');
fopen(s1);

% Initialize with first unit from microcontroller
unit = 'C';  % Default starting unit

x = 1:100;
y = zeros(1,100);
figure;
hLine = plot(x,y);
StripChart('Initialize', gca, '°C')

try
    fprintf('Press CTRL+C to finish\n');
    while (1)
        val = fscanf(s1);
        result = sscanf(val, '%f');
        
        val_trimmed = strtrim(val);  % Removes \r\n from end
        current_unit = val_trimmed(end);
        
        % Check if unit CHANGED
        if current_unit ~= unit
            fprintf('Unit changed: %c -> %c\n', unit, current_unit);
            
            % Get current plot data
            yData = get(hLine, 'YData');
            
            % Convert historical data based on transition
            if unit == 'C' && current_unit == 'K'
                yData = yData + 273.15;
            elseif unit == 'K' && current_unit == 'C'
                yData = yData - 273.15;
            elseif unit == 'C' && current_unit == 'F'
                yData = yData * (9/5) + 32;
            elseif unit == 'F' && current_unit == 'C'
                yData = (yData - 32) * (5/9);
            elseif unit == 'K' && current_unit == 'F'
                yData = (yData - 273.15) * (9/5) + 32;
            elseif unit == 'F' && current_unit == 'K'
                yData = (yData - 32) * (5/9) + 273.15;
            end
            
            y_max = max(yData); 
            y_min = min(yData); 
            ylim([y_min - 5, y_max + 5]);

            % Update the plot with converted data
            set(hLine, 'YData', yData);
            
            % Update xlabel based on NEW unit
            if current_unit == 'C'
                xlabel('10 °C/div')
            elseif current_unit == 'K'
                xlabel('10 K/div')
            elseif current_unit == 'F'
                xlabel('10 °F/div')
            end
            
            % Update unit tracker
            unit = current_unit;
        end
        
        % Add new data point
        StripChart('Update', hLine, result);
        
        % Display current reading
        fprintf('T=%5.2f%c\n', result, current_unit);
        
        pause(0.05);
    end
end

fclose(s1);