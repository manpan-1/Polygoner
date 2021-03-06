function [X, Y, classification] = min_finder(curves, clas)
% Script extracting minimum values and their corresponding half-wavelength

% Initialise array to store minimum values
X = zeros(3, 4, 9);
Y = zeros(3, 4, 9);
classification = cell(size(clas));

% Loops through the different profiles
for i = 1:3;
    for j = 1:4;
        for k = 1:9;
            
            % Total number lengths
            n_lengths = length(curves{i, j, k});
            
            % Total number of eigenvalues
            neigs = length(curves{i, j, k}{1});
            
            % Initialise a cell arrays to host x, y data
            curvex = cell(n_lengths, neigs);
            curvey = cell(n_lengths, neigs);
            
            
            % Loop collecting the y values (load factor) of the first eigenmode
            % for the different lengths
            i_eig = 1;
            for j_hwave = 1:n_lengths;
                curvex{i_eig}(j_hwave) = curves{i, j, k}{j_hwave}(1, 1);
                curvey{i_eig}(j_hwave) = curves{i, j, k}{j_hwave}(i_eig, 2);
            end;
            
            % Find the minima
            [Y(i, j, k), ind] = min(curvey{i_eig});
            X(i, j, k) = curvex{i_eig}(ind);
            
            % Store the corresponding participation values
            classification{i, j, k} = clas{i, j, k}{ind}(1, :);
        end;
    end;
end;