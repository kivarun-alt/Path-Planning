function linePoints = Bresenham_line1(x2, y2, x1, y1)
    dx = abs(x2 - x1);
    dy = abs(y2 - y1);
    steep = dy > dx;
    
    if steep
        % Swap x and y coordinates
        temp = x1;
        x1 = y1;
        y1 = temp;
        
        temp = x2;
        x2 = y2;
        y2 = temp;
    end
    
    if x1 > x2
        % Swap start and end points
        temp = x1;
        x1 = x2;
        x2 = temp;
        
        temp = y1;
        y1 = y2;
        y2 = temp;
    end
    
    dx = abs(x2 - x1);
    dy = abs(y2 - y1);
    error = 0;
    deltaError = dy;
    yStep = 0;
    y = y1;
    
    if y1 < y2
        yStep = 1;
    else
        yStep = -1;
    end
    
    linePoints = zeros(2, dx + 1);
    y = y1;
    
    for x = x1:x2
        if steep
            linePoints(:, x - x1 + 1) = [y; x];
        else
            linePoints(:, x - x1 + 1) = [x; y];
        end
        
        error = error + deltaError;
        
        if 2 * error >= dx
            y = y + yStep;
            error = error - dx;
        end
    end
end
