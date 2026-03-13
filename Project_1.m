clear variables
close all

map_rgb = imread('map_1_d2.jpg');
% map_rgb = imread('map_4_t.png');

I = rgb2gray(map_rgb);
BW = imbinarize(I,0.95);

image = double(BW);



step_size = 1;
numNodes = 1000;

start_pos = [1,20];
goal_pos = [46,20];

q_start.coord = [1,20];
q_start.cost = 0;
q_start.parent = 0;
q_goal.coord = [46,20];
q_goal.cost = 0;

nodes(1) = q_start;

plot_map(BW)
plot(start_pos(1),start_pos(2),'sg','MarkerFaceColor','g')
plot(goal_pos(1),goal_pos(2),'sr','MarkerFaceColor','r')

hold on
tic
keyboard
for i = 1:1:numNodes
   q_rand = [floor((50-1) * rand + 1) floor((50-1) * rand +1)];
    while BW(q_rand(2),q_rand(1)) ~= 1
        q_rand = [floor((50-1) * rand + 1) floor((50-1) * rand +1)];
    end
    plot(q_rand(1), q_rand(2), 'x', 'Color',  [0 0.4470 0.7410])
    
    % Break if goal node is already reached
    for j = 1:1:length(nodes)
        if nodes(j).coord == q_goal.coord
            break
        end
    end
    
    % Pick the closest node from existing list to branch out from
    ndist = [];
    for j = 1:1:length(nodes)
        n = nodes(j);
        tmp = dist(n.coord, q_rand);
        ndist = [ndist tmp];
    end
    [val, idx] = min(ndist);
    q_near = nodes(idx);
    
    q_new.coord = steer(q_rand, q_near.coord, val, step_size);
    if noColl(q_rand, q_near.coord, BW) ~= 0
        line([q_near.coord(1), q_new.coord(1)], [q_near.coord(2), q_new.coord(2)], 'Color', 'k', 'LineWidth', 2);
        drawnow
        hold on
        q_new.cost = dist(q_new.coord, q_near.coord) + q_near.cost;
        
        for j = 1:1:length(nodes)
            if nodes(j).coord == q_near.coord
                q_new.parent = j;
            end
        end
        
        % Append to nodes
        nodes = [nodes q_new];
        % Within a radius of r, find all existing nodes
        q_nearest = [];
        r = 10;
        neighbor_count = 1;
        for j = 1:1:length(nodes)
            if noColl(nodes(j).coord, q_new.coord, BW) && dist(nodes(j).coord, q_new.coord) <= r
                    q_nearest(neighbor_count).coord = nodes(j).coord;
                    q_nearest(neighbor_count).cost = nodes(j).cost;
                    neighbor_count = neighbor_count+1;
           end
        end
        
        % Initialize cost to currently known value
        q_min = q_near;
        C_min = q_new.cost;
        
        % Iterate through all nearest neighbors to find alternate lower
        % cost paths
        
        for k = 1:1:length(q_nearest)
            if noColl(q_new.coord,q_nearest(k).coord, BW) && q_nearest(k).cost + dist(q_nearest(k).coord, q_new.coord) < C_min
                    q_min = q_nearest(k);
                    C_min = q_nearest(k).cost + dist(q_nearest(k).coord, q_new.coord);
                    line([q_min.coord(1), q_new.coord(1)], [q_min.coord(2), q_new.coord(2)], 'Color', 'g');                
                    hold on
            end
        end
        
        % % Update parent to least cost-from node
        % for j = 1:1:length(nodes)
        %     if nodes(j).coord == q_min.coord
        %         q_new.parent = j;
        %     end
        % end
        % 
        % % Append to nodes
        % nodes = [nodes q_new];
    end
end

D = [];
for j = 1:1:length(nodes)
    tmpdist = dist(nodes(j).coord, q_goal.coord);
    D = [D tmpdist];
end

% Search backwards from goal to start to find the optimal least cost path
[val, idx] = min(D);
q_final = nodes(idx);
q_goal.parent = idx;
q_end = q_goal;
nodes = [nodes q_goal];
counter =0;
while q_end.parent ~= 0
    start = q_end.parent;
    line([q_end.coord(1), nodes(start).coord(1)], [q_end.coord(2), nodes(start).coord(2)], 'Color', 'r', 'LineWidth', 2);
    counter = counter+1;
    hold on
    q_end = nodes(start);
end

toc
