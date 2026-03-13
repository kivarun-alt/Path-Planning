function nc = noColl(n1, n2, image)
    A = [n1(1) n1(2)];
    B = [n2(1) n2(2)];
    storeval =[];


    linePoints = Bresenham_line1(B(2),B(1),A(2),A(1));
    
    for i = 1:length(linePoints)-1
        storeval(i) = image(linePoints(1,i),linePoints(2,i));
    end
    % Check if path from n1 to n2 intersects any of the four edges of the
    % obstacls
    if all(storeval == 1)
            nc = 1;
    else
            nc = 0;
    end
    