function NMec = tp2_95167()

%% TP2 - SVPI -------------------------------------------------------
% Name:       Nuno Cunha
% Num. Mec:   95167
% Date:       20/04/2024
% -------------------------------------------------------------------

addpath '..\tp2_lib\' % functions folder path
addpath '..\'
close all; clear all;
clc

% displaying the nr mec
numMec = 95167;
% disp(numMec) % nr mec display

% % initialize the variables to evaluate the work
% numSeq = 0;
% numImg = 0;
% stampN = 0;
% numNam = 0;
% numAdd = 0;
% numDoor = '';
% D1 = 0;
% D2 = 0;
% D3 = 0;
% D4 = 0;
% D5 = 0;
% D6 = 0;
% D7 = 0;
% D8 = 0;

% load the neural network
load('mnist_svpi2024_tp2_95167.mat')

%% --------------- GETTING THE IMAGES FROM THE FOLDER ---------------------
% reading the images names from inside the folder
% img_list = dir('..\*_TP2_img_100_01.png');
img_list = dir('..\svpi2024_TP2_img_100_01.png');

if isempty(img_list)
    % Display placeholder image
    % disp('There are no images')
else

    % save the variables value in a txt file
    txt_file = 'tp2_95167.txt';  
    % open the file
    file = fopen(txt_file, 'w');

    % printing the images names
    for i = 1:size(img_list,1)

        % initialize the variables to evaluate the work
        numSeq = 0;
        numImg = 0;
        stampN = 0;
        numNam = 0;
        numAdd = 0;
        numDoor = '000';
        D1 = '0';
        D2 = '0';
        D3 = '0';
        D4 = '0';
        D5 = '0';
        D6 = '0';
        D7 = '0';
        D8 = '0';

        % get the image file name
        img_name = img_list(i).name;
        disp(img_name);

        img_name_parts = split(img_name, '_');
        if size(img_name_parts, 1) >= 4
            numSeq = str2double(img_name_parts{4});
            Num_Img = img_name_parts{5};

            Num_Img_parts = split(Num_Img, '.');
            numImg = str2double(Num_Img_parts{1});
        end

        %% ----------------- TRAINING FOR ONE IMAGE AT TIME ----------------------- 
        % do the process to one and only one image
        %% ############################ ORIGINAL IMAGE ############################
        % A = im2double(imread('..\svpi2024_TP2_img_120_38.png'));
        A = im2double(imread(img_name));
        % corrigir erro da imagem 100_14
        B = rgb2gray(A);
        C = B < 0.85;
        D = imfill(~C, 'holes'); 
        E = bwareaopen(D, 100);

        % AUXILIAR CALCULUS
        numBlackPix = sum(C(:) == 0);
        totPix = numel(C);
        percentage = (numBlackPix/totPix)*100;

        % if percentage > 80
        %     return
        % end
        
        [L4, N4] = bwlabel(E);
        
        stats4 = regionprops(L4, 'All');
        
        % figure;
        % subplot(3,2,1)
        % imshow(C)
        % title('C')
        % 
        % subplot(3,2,2)
        % imshow(A)
        % title('A')
        
        for p = 1:size(stats4, 1)
        
            xp = stats4(p).Centroid(1) - 6;
            yp = stats4(p).Centroid(2);
        
            bbox4 = stats4(p).BoundingBox;
            % rectangle('Position', bbox4, 'EdgeColor', 'r', 'LineWidth',1);
            % 
            % text_to_write = {[num2str(p)]};
            % text(xp, yp, text_to_write, 'Color', [0,1,0], 'FontSize', 12);
        
            if stats4(p).Area > 10000
        
                bboxp = stats4(p).BoundingBox;
                if round(stats4(p).Orientation, 0) == 0 || round(stats4(p).Orientation, 0) == 1
                    % disp('Do nothing')
                    F = E;
                    J = A;
        
                else
                    % disp('Orientate')
                    orientation = round(stats4(p).Orientation, 0);
                    F = imrotate(E, -orientation);
                    G = imrotate(A, -orientation);
        
                    [L5, N5] = bwlabel(F);
                    stats5 = regionprops(L5, 'All');
        
                    % subplot(3,2,3)
                    % imshow(F)
                    % title('F')
                    
                    for q = 1:size(stats5, 1)
                    
                        xq = stats5(q).Centroid(1) - 6;
                        yq = stats5(q).Centroid(2);
        
                        % text_to_write = {[num2str(q)]};
                        % text(xq, yq, text_to_write, 'Color', [0,1,0], 'FontSize', 12);
                    
                        if stats5(q).Area > 10000
        
                            bbox5 = stats5(q).BoundingBox;
                            % rectangle('Position', bbox5, 'EdgeColor', 'r', 'LineWidth',1);
                        
                            % text_to_write = {[num2str(q)]};
                            % text(xq, yq, text_to_write, 'Color', [0,1,0], 'FontSize', 12);
                        
                            M = F(bbox5(2):bbox5(2)+bbox5(4), bbox5(1):bbox5(1)+bbox5(3));
                            J = G(bbox5(2):bbox5(2)+bbox5(4), bbox5(1):bbox5(1)+bbox5(3), :);
                        
                        end
                    end
        
                    % subplot(3,2,4)f
                    % imshow(G)
                    % title('G')
                    % 
                    % subplot(3,2,5)
                    % imshow(M)
                    % title('M')
                    % 
                    % subplot(3,2,6)
                    % imshow(J)
                    % title('FINAL IMG')
        
                end
            end
        end
        % A = im2double(imread('..\svpi2024_TP2_img_100_50.png'));
        Bi = rgb2gray(J);
        Ci = Bi < 0.73; % 0.65 and 0.77 works just fine, final 0.73, 0.75 is the minimum
        % 0.73 the best one, LOCKED UP

        % handle1 = figure;
        % set(handle1, 'Position', [7 478 551 489], 'OuterPosition', [-1 470 567 582])
        % imshow(A)
        % title('Original Img')
        % 
        % handle2 = figure;
        % set(handle2, 'Position', [558 478 551 489], 'OuterPosition', [550 470 567 582])
        % imshow(J)
        % title('Oriented Image')
        
        % some image notes
        % -> image 100_36, max of 0.72
        % -> image 100_28, min of 0.74
        
        %% ########################### ERASE THE FRAME ############################
        % create a padding to eliminate the "frame" in the global img
        padding = padarray(Ci, [5 5], 1, 'both'); % 1 because we want to erase white pixels
                
        % eliminate the pixels of padding
        frameless = imclearborder(padding);
                
        [rows, cols] = size(frameless);            
        
        % Find the first row with a pixel value of 0
        first_row = find(any(frameless == 1, 2), 1, 'first');
                
        % Find the last row with a pixel value of 0
        last_row = find(any(frameless == 1, 2), 1, 'last');
                
        % Find the first column with a pixel value of 0
        first_col = find(any(frameless == 1, 1), 1, 'first');
                
        % Find the last column with a pixel value of 0
        last_col = find(any(frameless == 1, 1), 1, 'last');
                
        % If no 0 pixel found, keep the original image
        if isempty(first_row) || isempty(last_row) || isempty(first_col) || isempty(last_col)
            cleaned_obj_img = C;
        else
            % Crop the image to the desired region
            cleaned_obj_img = frameless(first_row:last_row, first_col:last_col);
        end
        
        clean_img = cleaned_obj_img;
        
        %% ######################## ERASE SOME NOISE PIXELS #######################
        [r, c] = size(clean_img);
                
        vector_1_top = clean_img(1,1:end);
        vector_2_bottom = clean_img(end, 1:end);
        vector_3_left = clean_img(1:end, 1);
        vector_4_right = clean_img(1:end, end);
                
        total_top_pix = sum(vector_1_top);
        total_bottom_pix = sum(vector_2_bottom);
        total_left_pix = sum(vector_3_left);
        total_right_pix = sum(vector_4_right);
                
        threshold = 0.90; % para eliminar aqueles 1/2 pixels a mais na imagem, caso existam
                
        % Remove top rows
        for l = 1:r
            if total_top_pix >= size(clean_img, 2) * threshold
                clean_img(1,:) = []; % remove the row
                % Update total_top_pix after removal
                total_top_pix = sum(clean_img(1,:));
                r = r - 1; % Update number of rows
            else
                break
            end
        end
                
        % Remove bottom rows
        for l = r:-1:1
            if total_bottom_pix >= size(clean_img, 2) * threshold
                clean_img(end,:) = []; % remove the row
                % Update total_bottom_pix after removal
                total_bottom_pix = sum(clean_img(end,:));
                r = r - 1; % Update number of rows
            else
                break
            end
        end
        
        % Remove leftmost columns
        for j = 1:c
            if total_left_pix >= size(clean_img, 1) * threshold
                clean_img(:,1) = []; % remove the column
                % Update total_left_pix after removal
                total_left_pix = sum(clean_img(:,1));
                c = c - 1; % Update number of columns
            else
                break
            end
        end
        
        % Remove rightmost columns
        for j = c:-1:1
            if total_right_pix >= size(clean_img, 1) * threshold
                clean_img(:,end) = []; % remove the column
                % Update total_right_pix after removal
                total_right_pix = sum(clean_img(:,end));
                c = c - 1; % Update number of columns
            else
                break
            end
        end
        
        %% ########################### IMAGE TREATMENT ############################
        % Edge detection to isolate the square with the seal number
        
        % E = bwareaopen(clean_img, 300); % 300 or 350
        % 
        % G = imfill(E, 'holes');
        % 
        % [L, N] = bwlabel(G);
        % 
        % stats = regionprops(L, 'Centroid', 'Area', 'Circularity', 'Solidity');
        % 
        existing_seal = false; % debug flag
        
        % TESTING SOMETHING -------------------------------------------------------
        example = clean_img;
        % the example img has to have the same size as "clean_img" para comparar
        % mais tarde
        example(1:end, 1:c/2) = 0; % black or white is the same
        % example = clean_img(1:end, c/2:end); % cut half of the image
        
        Ex = bwareaopen(example, 320); % 300 or 350
        
        Gx = imfill(Ex, 'holes');
        
        [L, N] = bwlabel(Gx);
        
        stats = regionprops(L, 'Centroid', 'Area', 'Circularity', 'Solidity', 'Orientation');
        % TESTING SOMETHING -------------------------------------------------------
        
        %% ################### CLASSIFY EACH OBJECT IN THE IMG ####################
        % iterate through each object in the image to classify them
        for i = 1:size(stats, 1)
        
            x = stats(i).Centroid(1) - 6;
            y = stats(i).Centroid(2);
        
            % classification of objects in the image
            if stats(i).Circularity > 0.65 || stats(i).Solidity > 0.90 % to make sure that it is a rectangle
                existing_seal = true; % exists a seal in the image
                stats(i).estimated_class = 'Seal';
                rotate_seal = stats(i).Orientation;
                
                % create a new image with the seal
                cropped_seal = L == i;
        
                % crop the picture to make it the size of the seal
                first_row = find(any(cropped_seal == 1, 2), 1, 'first');
                last_row = find(any(cropped_seal == 1, 2), 1, 'last');
                first_col = find(any(cropped_seal == 1, 1), 1, 'first');
                last_col = find(any(cropped_seal == 1, 1), 1, 'last');
                        
                % If no 1 pixel found, keep the original image
                if isempty(first_row) || isempty(last_row) || isempty(first_col) || isempty(last_col)
                    clean_seal = cropped_seal;
                else
                    % Crop the image to the desired region
                    clean_seal = cropped_seal(first_row:last_row, first_col:last_col);
                end
        
                % figure;
                % imshow(clean_seal)
                % title('Cropped Seal')
            else
                stats(i).estimated_class = 'Noise';
            end
            
            % write in the picture that stats that matter for the classification
            % text_to_write = {[num2str(i)], stats(i).estimated_class};
            % text(x,y,text_to_write, 'Color', [0,1,0], 'FontSize', 12);
        end
        
        %% ##################### SEAL EXISTING VERIFICATION #######################
        if existing_seal == 0
            stampN = 0;
            % disp('There is no seal in the image');
        
        else
            % take the clean seal picture and erase it from the original
            Hi = cropped_seal - clean_img; 
        
            % orientate the seal
            if abs(rotate_seal) > 45 && abs(rotate_seal) < 135
                H = imrotate(Hi, (90-rotate_seal));
            elseif abs(rotate_seal) > 225 && abs(rotate_seal) < 315
                H = imrotate(Hi, (90-rotate_seal));
            else
                H = imrotate(Hi, -rotate_seal); % orientate the seal
            end
            % had to get the entire pic because of the size be incompatible with iso
            % one
            
            % crop the picture to make it the size of the seal
            first_row = find(any(H == 1, 2), 1, 'first');
            last_row = find(any(H == 1, 2), 1, 'last');
            first_col = find(any(H == 1, 1), 1, 'first');
            last_col = find(any(H == 1, 1), 1, 'last');
                    
            % If no 1 pixel found, keep the original image
            if isempty(first_row) || isempty(last_row) || isempty(first_col) || isempty(last_col)
                iso_seal = H;
                
            else
                % Crop the image to the desired region
                iso_seal = H(first_row:last_row, first_col:last_col);
            end
        
            %% ####################### SEPARATE EACH SEAL #########################
            % orientate the seal
            if abs(rotate_seal) > 45 && abs(rotate_seal) < 135
                clean_seal = imrotate(clean_seal, (90-rotate_seal));
            elseif abs(rotate_seal) > 225 && abs(rotate_seal) < 315
                clean_seal = imrotate(clean_seal, (90-rotate_seal));
            else
                clean_seal = imrotate(clean_seal, -rotate_seal); % orientate the seal
            end
        
            % clean_seal = imrotate(clean_seal, -rotate_seal); % orientate the seal
            [Li, Ni] = bwlabel(clean_seal);
            seal_stats = regionprops(clean_seal, 'All');
        
            [ri, ci] = size(iso_seal);
            half_seal = iso_seal(1:end, ci/2:end);
            half_seal = bwmorph(half_seal, 'skel', Inf);
            [image_height, image_width] = size(half_seal);
        
            seal2_pattern = [0 0 0 0 0 0 0 0 0 0 0 0
                             1 1 1 1 1 1 1 1 1 1 1 1
                             0 0 0 0 0 0 0 0 0 0 0 0
                             0 0 0 0 0 0 0 0 0 0 0 0
                             0 0 0 0 0 0 0 0 0 0 0 0
                             0 0 0 0 0 0 0 0 0 0 0 0
                             0 0 0 0 0 0 0 0 0 0 0 0
                             0 0 0 0 0 0 0 0 0 0 0 0
                             0 0 0 0 0 0 0 0 0 0 0 0
                             0 0 0 0 0 0 0 0 0 0 0 0
                             0 0 0 0 0 0 0 0 0 0 0 0
                             0 0 0 0 0 0 0 0 0 0 0 0
                             1 1 1 1 1 1 1 1 1 1 1 1 
                             0 0 0 0 0 0 0 0 0 0 0 0
                             ];
        
            sealtype2 = logical(seal2_pattern);
        
            [template_height, template_width] = size(sealtype2);
        
            % divide the seals in two groups by orientation
            % horizontal seals (0, -0, 180, -180)
            if abs(round(seal_stats.Orientation)) == 0 || abs(round(seal_stats.Orientation)) == 180
                % disp('Horizontal Seal')
                
                % divide this group in two groups by area (1, 2, 6 AND 7)
                if seal_stats.Area < 15000
                    % disp('Seal Type 1')
                    stampN = 1;
                elseif seal_stats.Area > 17500
                        % disp('Seal Type 7')
                        stampN = 7;   
                 else
                     % now it's between type 2 and type 6
                     for i = 1:(image_height - template_height + 1)
                         if stampN == 2
                             break;
                         end
                         
                         for j = 1:(image_width - template_width + 1)
                             roi = half_seal(i:(i+template_height-1), j:(j+template_width-1));
                             % corrigir o erro que dá ao analisar na imagem 100_15
                             % Index in position 2 exceeds array bounds. Index must not exceed 72.
                             % figure(2);
                             % imshow(roi)
                             % pause(0.000
                             if isequal(roi, sealtype2)
                                 % disp('Seal Type 2')
                                 stampN = 2;
                                 break; % break the loop when finds that it is type 2
                             else
                                 % disp('Seal Type 6')
                                 stampN = 6;
                             end
                         end
                     end
                end
                
            else
                % vertical seals (90, -90, 270, -270)
                % disp('Vertical Seal')
                try
                    % divide them by bounding box y size probably
                    if seal_stats.BoundingBox(4) < 125
                        % disp('Seal Type 5')
                        stampN = 5;
                    elseif seal_stats.BoundingBox(4) < 145
                        % disp('Seal Type 4')
                        stampN = 4;
                    else
                        % disp('Seal Type 3')
                        stampN = 3;
                    end
                catch
                    % disp('Error, ending...')
                    % write in the txt file
                    fprintf(file,'%d,%d,%d,%d,%d,%d,%s,%s,%s,%s,%s,%s,%s,%s,%s \n', ... 
                        numMec, numSeq, numImg, stampN, numNam, numAdd, numDoor, D1, D2, D3, D4, D5, D6, D7, D8);
                    % return
                    continue
                end
            end
        end

        % handle3 = figure;
        % set(handle3, 'Position', [1110 769 343 196], 'OuterPosition', [1102 761 359 289])
        % imshow(iso_seal)
        % title('Isolated Stamp')
        
        
        %% ######################### FIND ADRESS WORDS ############################
        adress_img = rgb2gray(J); % double
        adress_bin = rgb2gray(J) < 0.80; % 0.95, logical
        gray_aux = adress_img; % create an auxiliar image to finalize the program
        
        % figure;
        % imshow(adress_bin)
        % title('adress bin')
        
        padding2 = padarray(adress_bin, [5 5], 1, 'both'); % 1 because we want to erase white pixels   
        frameless2 = imclearborder(padding2);
        
        % auxiliar image to finalize the program
        padding2_aux = padarray(gray_aux, [5 5], 'both'); 
        frameless_aux = imclearborder(padding2_aux); % 539x1063 logical
        
        [rows2, cols2] = size(frameless2);
        
        % % Find the first row with a pixel value of 0
        % first_row2 = find(any(frameless2 == 1, 2), 1, 'first');
        % 
        % % Find the last row with a pixel value of 0
        % last_row2 = find(any(frameless2 == 1, 2), 1, 'last');
        % 
        % % Find the first column with a pixel value of 0
        % first_col2 = find(any(frameless2 == 1, 1), 1, 'first');
        % 
        % % Find the last column with a pixel value of 0
        % last_col2 = find(any(frameless2 == 1, 1), 1, 'last');
        % 
        % % If no 0 pixel found, keep the original image
        % if isempty(first_row2) || isempty(last_row2) || isempty(first_col2) || isempty(last_col2)
        %     adress = adress_bin;
        % else
        %     % Crop the image to the desired region
        %     adress = frameless2(first_row2:last_row2, first_col2:last_col2);
        % end
        
        % in case that there is the bigger box 'PAR AVION'
        adress_fill = imfill(frameless2, 'holes');
        
        adress = bwareaopen(adress_fill, 50);
        
        [Lnew, Nnew] = bwlabel(adress);
        
        % figure; imshow(Lnew);
        % title('Lnew')
        
        stats2 = regionprops(Lnew, 'All');
        
        % to eliminate the 'PAR AVION', stamp and airplane areas
        for n = 1:size(stats2, 1)
        
            xn = stats2(n).Centroid(1) - 6;
            yn = stats2(n).Centroid(2);
        
            % exclude the seal image by area stats
            if stats2(n).Area > 3000
                % disp('Exclude the seal')
                % objdel_idx = n;
                bbox = stats2(n).BoundingBox;
                % rectangle('Position', bbox, 'EdgeColor', 'r', 'LineWidth',1);
        
                % erase the seal and then proceed to the characters
                % wipe out the fucking seal with black pixels
                adress(bbox(2):bbox(2)+bbox(4), bbox(1):bbox(1)+bbox(3)) = 0; 
        
            end
        
            % text_to_write = {[num2str(n)]};
            % text(xn, yn, text_to_write, 'Color', [0,1,0], 'FontSize', 8);
        
        end
        
        % resize the image just to read the characters
        % frameless3 = adress; % not wrong but, not recommended
        frameless3 = frameless2 & adress; % better bcz the closed numbers were filled, and it would be hard for the NN to detect the nr
        [rows3, cols3] = size(frameless3);
        
        % Find the first row with a pixel value of 1
        first_row3 = find(any(frameless3 == 1, 2), 1, 'first');
        
        % Find the last row with a pixel value of 1
        last_row3 = find(any(frameless3 == 1, 2), 1, 'last');
        
        % Find the first column with a pixel value of 1
        first_col3 = find(any(frameless3 == 1, 1), 1, 'first');
        
        % Find the last column with a pixel value of 1
        last_col3 = find(any(frameless3 == 1, 1), 1, 'last');
        
        % If no white pixel found, keep the original image
        if isempty(first_row3) || isempty(last_row3) || isempty(first_col3) || isempty(last_col3)
            characters = adress;
            characters_aux = frameless_aux; % auxiliar image to finalize the program
        else
            % Crop the image to the desired region
            characters = frameless3(first_row3:last_row3, first_col3:last_col3);
            characters_aux = frameless_aux(first_row3:last_row3, first_col3:last_col3); % auxiliar image to finalize the program 339x695 double
        end
        
        % figure; imshow(characters)
        % title('characters')
        
        % just to clear some residual areas bigger then 800
        [Laux, Naux] = bwlabel(characters);
        
        % figure; imshow(Laux)
        % title('Laux')
        
        stats3 = regionprops(Laux, 'All');
        
        % to explore:
        % filledarea > 900
        
        for m = 1:size(stats3, 1)
        
            xm = stats3(m).Centroid(1) - 6;
            ym = stats3(m).Centroid(2);
        
            % excluir o stats3(m).Area < 70 caso comece a dar asneira
        
            if stats3(m).Area > 1160 || stats3(m).Area < 55 || stats3(m).BoundingBox(4) > 50 % as letras AIR têm 90/91 de altura o resto tem 25/27
                % area < 100
                % area < 80
                % area > 900
        
                bbox3 = stats3(m).BoundingBox;
                % rectangle('Position', bbox3, 'EdgeColor', 'g', 'LineWidth', 1);
        
                % erase the seal and then proceed to the characters
                % wipe out the fucking seal with black pixels
                characters(bbox3(2):bbox3(2)+bbox3(4), bbox3(1):bbox3(1)+bbox3(3)) = 0;
        
            end
        
            % text_to_write = {[num2str(m)]};
            % text(xm, ym, text_to_write, 'Color', [0,0,1], 'FontSize', 8);
        end
        
        % figure;
        % imshow(characters)
        % title('edge')
        
        %% ########################## TREAT THE CHARS #############################
        % try to connect the letters to each other
        se = strel('disk', 3, 8); % 5;
        % se = strel('diamond', 5); % 5; % prevenir o que acontece na imagem 100_20, fzr com q o prog continue "fifth_char = cropped_imgs{5};"
        open_chars = imdilate(characters, se);
        
        increase_var = 250; % increase width 170, a img 100_50 só funca com 250
        % increase_var2 = 50;
        [ropen, copen] = size(open_chars);
        half_open = open_chars;
        half_open(1:end, copen/2+increase_var:end) = 0; % CUT THE WIDTH
        
        half_open_aux = characters_aux;
        half_open_aux(1:end, copen/2+increase_var:end) = 0; % auxiliar image to finalize the program 380x346 double
        % (y, x) = (344x600)
        
        % [Lchars, Nchars] = bwlabel(open_chars);
        [Lchars, ~] = bwlabel(half_open);
        
        schars = regionprops(Lchars ,'All');
        
        final_chars = characters & open_chars;
        
        % figure;
        % imshow(final_chars)
        % title('final chars')
        
        almost_final = final_chars;
        almost_final(1:end, copen/2+increase_var:end) = 0; % CUT THE WIDTH
        
        almost_final_aux = characters_aux;
        almost_final_aux(1:end, copen/2+increase_var:end) = 0; % auxiliar image to finalize the program 380x346 double
        
        for k = 1:size(schars, 1)
        
            xk = schars(k).Centroid(1) - 6;
            yk = schars(k).Centroid(2);
        
            bboxk = schars(k).BoundingBox;
        
            % rectangle('Position', bboxk, 'EdgeColor', 'r', 'LineWidth',1);
            % text_to_write = {[num2str(k)]};
            % text(xk, yk, text_to_write, 'Color', [0,1,0], 'FontSize', 8);
        
            % hold on
        
            if schars(k).Area > 4600 || schars(k).Circularity < 0.12 || schars(k).Extent < 0.35 || schars(k).BoundingBox(4) < 20 % circularity < 0.25
                % rectangle('Position', bboxk, 'EdgeColor', 'g', 'LineWidth',2);
                almost_final(bboxk(2):bboxk(2)+bboxk(4), bboxk(1):bboxk(1)+bboxk(3)) = 0;
                
            end
        
        end
        
        % figure;
        % imshow(almost_final)
        % title('almost final')
        
        % resize the image just to read the characters
        frameless4 = almost_final;
        [rows4, cols4] = size(frameless4);
        
        % Find the first row with a pixel value of 1
        first_row4 = find(any(frameless4 == 1, 2), 1, 'first');
        
        % Find the last row with a pixel value of 1
        last_row4 = find(any(frameless4 == 1, 2), 1, 'last');
        
        % Find the first column with a pixel value of 1
        first_col4 = find(any(frameless4 == 1, 1), 1, 'first');
        
        % Find the last column with a pixel value of 1
        last_col4 = find(any(frameless4 == 1, 1), 1, 'last');
        
        % If no white pixel found, keep the original image
        if isempty(first_row4) || isempty(last_row4) || isempty(first_col4) || isempty(last_col4)
            final_img = almost_final;
            final_img_aux = almost_final_aux; % auxiliar image to finalize the program 339x568 double
        else
            % Crop the image to the desired region
            final_img = frameless4(first_row4:last_row4, first_col4:last_col4);
            final_img_aux = almost_final_aux(first_row4:last_row4, first_col4:last_col4); % auxiliar image to finalize the program 160x331 double
        end
        
        % figure;
        % imshow(final_img)
        % title('Final Image')
        
        % AREA > 4000
        % CIRCULARITY < 0.15
        % EXTENT < 0.35
        
        % se1 = strel('disk', 5); % 4 é o ideal, mas 120_50 só funca com 3
        se1 = strel('disk', 4); % 5;
        open_final = imdilate(final_img, se1);
        
        % [Lfinal, Nchars] = bwlabel(open_final);
        % 
        % sfinal = regionprops(Lfinal ,'All');
        
        % figure;
        % imshow(open_final)
        % title('Open Final')
        
        % figure(2);
        % imshow(A)
        % title('Original Image')
        
        final_final = final_img & open_final; % or characters & open_final
        copy_finalfinal = final_final; % to get each number on line2 isolated before the dilate 
        
        [Lfinal, Nchars] = bwlabel(open_final);
        
        sfinal = regionprops(Lfinal ,'All');
        
        % handle4 = figure;
        % set(handle4, 'Position', [1109 421 344 262], 'OuterPosition', [1101 413 360 355])
        % imshow(final_final)
        % title('Isolated Chars')
        
        line1 = zeros(size(final_final));
        line2 = zeros(size(final_final));
        line3 = zeros(size(final_final));
        line4 = zeros(size(final_final));
        
        for o = 1:size(sfinal, 1)
        
            xk = sfinal(o).Centroid(1) - 6;
            yk = sfinal(o).Centroid(2);
        
            bboxo = sfinal(o).BoundingBox;
        
            % rectangle('Position', bboxo, 'EdgeColor', 'g', 'LineWidth',1);
            % text_to_write = {[num2str(o)]};
            % text(xk, yk, text_to_write, 'Color', [0,1,1], 'FontSize', 12);
        
            % get the centroids to separate objects by line
            if sfinal(o).Centroid(2) < 30
                % disp('Line 1')
                line1 = line1 | Lfinal == o;
                numNam = numNam + 1;
        
            elseif sfinal(o).Centroid(2) < 100
                % disp('Line 2')
                line2 = line2 | Lfinal == o;
                numAdd = numAdd + 1;
        
            elseif sfinal(o).Centroid(2) < 130
                % disp('Line 3')
                line3 = line3 | Lfinal == o;
        
            else
                % disp('Line 4')
                line4 = line4 | Lfinal == o;
        
            end
        end
        
        numAdd = numAdd - 1;
        
        % figure;
        % subplot(2,2,1)
        % imshow(line1)
        % title('line1')
        % 
        % subplot(2,2,2)
        % imshow(line2)
        % title('line2')
        % 
        % subplot(2,2,3)
        % imshow(line3)
        % title('line3')
        % 
        % subplot(2,2,4)
        % imshow(line4)
        % title('line4')
        
        %% ##################### PREPARE CHARS TO NN LINE 3 #######################
        % get the chars from image of line3
        
        % resize the image just to read the characters
        frameless5 = line3;
        [rows5, cols5] = size(frameless5);
        
        % Find the first row with a pixel value of 1
        first_row5 = find(any(frameless5 == 1, 2), 1, 'first');
        
        % Find the last row with a pixel value of 1
        last_row5 = find(any(frameless5 == 1, 2), 1, 'last');
        
        % Find the first column with a pixel value of 1
        first_col5 = find(any(frameless5 == 1, 1), 1, 'first');
        
        % Find the last column with a pixel value of 1
        last_col5 = find(any(frameless5 == 1, 1), 1, 'last');
        
        % If no white pixel found, keep the original image
        if isempty(first_row5) || isempty(last_row5) || isempty(first_col5) || isempty(last_col5)
            final_line3 = line3;
            final_line3_aux = final_img_aux; % auxiliar image to finalize the program 160x331 double
        else
            % Crop the image to the desired region
            final_line3 = frameless5(first_row5:last_row5, first_col5:last_col5);
            final_line3_aux = final_img_aux(first_row5:last_row5, first_col5:last_col5); % auxiliar image to finalize the program 25x249 double
        end
        
        
        % get a region to each number
        [L6, N6] = bwlabel(final_line3);
        stats6 = regionprops(L6, 'All');
        
        % figure;
        % imshow(final_line3_aux)
        % title('Each char')
        
        % create 8 images 28x28 of black pixels
        char1_bg = zeros(28,28);
        char2_bg = zeros(28,28);
        char3_bg = zeros(28,28);
        char4_bg = zeros(28,28);
        char5_bg = zeros(28,28);
        char6_bg = zeros(28,28);
        char7_bg = zeros(28,28);
        char8_bg = zeros(28,28);
        
        region_size = 28;
        
        for t = 1:size(stats6, 1)
        
            xt = stats6(t).Centroid(1) - 6;
            yt = stats6(t).Centroid(2);
        
            bboxt = stats6(t).BoundingBox;
        
            % Extract region from the original image
            % object_region = imcrop(final_line3_aux, bboxt);
        
            center_x = round(bboxt(1)+bboxt(3)/2);
            center_y = round(bboxt(2)+bboxt(4)/2);
        
            % Calculate the region boundaries
            x_start = max(round(center_x - region_size/2), 1);
            y_start = max(round(center_y - region_size/2), 1);
            x_end = min(round(center_x + region_size/2 - 1), size(final_line3_aux, 2));
            y_end = min(round(center_y + region_size/2 - 1), size(final_line3_aux, 1));
        
            % Extract the region centered around the bounding box center
            cropped_imgs{t} = final_line3_aux(y_start:y_end, x_start:x_end);
        
            % If the extracted region is smaller than 28x28, pad it with ones
            [h, w] = size(cropped_imgs{t});
            if h < region_size || w < region_size
                pad_h = max(0, region_size - h);
                pad_w = max(0, region_size - w);
                cropped_imgs{t} = padarray(cropped_imgs{t}, [pad_h, pad_w], 1, 'post');
            end
        
            % rectangle('Position', bboxt, 'EdgeColor', 'g', 'LineWidth',1);
            % text_to_write = {[num2str(t)]};
            % text(xt, yt, text_to_write, 'Color', [0.5,1,1], 'FontSize', 12);
        
            % Save the cropped image in the cell array
            % cropped_imgs{t} = object_region;
        
        end
        
        % to prevent the error of bad location of numbers and stopping the program
        % figure;
        
        % char1 
        if numel(cropped_imgs) >= 1
            first_char = cropped_imgs{1};
            char1 = ~char1_bg - first_char;
            % subplot(2,4,1)
            % imshow(char1)
            % title('char1')
        end
        
        % char2
        if numel(cropped_imgs) >= 2
            second_char = cropped_imgs{2};
            char2 = ~char1_bg - second_char;
            % subplot(2,4,2)
            % imshow(char2)
            % title('char2')
        end
        
        % char3
        if numel(cropped_imgs) >= 3
            third_char = cropped_imgs{3};
            char3 = ~char1_bg - third_char;
            % subplot(2,4,3)
            % imshow(char3)
            % title('char3')
        end
        
        % char4
        if numel(cropped_imgs) >= 4
            fourth_char = cropped_imgs{4};
            char4 = ~char1_bg - fourth_char;
            % subplot(2,4,4)
            % imshow(char4)
            % title('char4')
        end
        
        % char5
        if numel(cropped_imgs) >= 5
            fifth_char = cropped_imgs{5};
            char5 = ~char1_bg - fifth_char;
            % subplot(2,4,5)
            % imshow(char5)
            % title('char5')
        end
        
        % char6
        if numel(cropped_imgs) >= 6
            sixth_char = cropped_imgs{6};
            char6 = ~char1_bg - sixth_char;
            % subplot(2,4,6)
            % imshow(char6)
            % title('char6')
        end
        
        % char7
        if numel(cropped_imgs) >= 7
            seventh_char = cropped_imgs{7};
            char7 = ~char1_bg - seventh_char;
            % subplot(2,4,7)
            % imshow(char7)
            % title('char7')
        end
        
        % char8
        if numel(cropped_imgs) >= 8
            eigth_char = cropped_imgs{8};
            char8 = ~char1_bg - eigth_char;
            % subplot(2,4,8)
            % imshow(char8)
            % title('char8')
        end
        
        % if size(cropped_imgs, 2) < 8
        %     continue
        % end
        % first_char = cropped_imgs{1};
        % second_char = cropped_imgs{2};
        % third_char = cropped_imgs{3};
        % fourth_char = cropped_imgs{4};
        % fifth_char = cropped_imgs{5};
        % sixth_char = cropped_imgs{6};
        % seventh_char = cropped_imgs{7};
        % eigth_char = cropped_imgs{8};
        
        % OPTION 2 -> WHITE NUMBER BLACK BG
        % char1 = ~char1_bg - first_char;
        % char2 = ~char1_bg - second_char;
        % char3 = ~char1_bg - third_char;
        % char4 = ~char1_bg - fourth_char;
        % char5 = ~char1_bg - fifth_char;
        % char6 = ~char1_bg - sixth_char;
        % char7 = ~char1_bg - seventh_char;
        % char8 = ~char1_bg - eigth_char;
        
        %% ######################## CHAR VISUALIZATION #########################
        % handle5 = figure;
        % set(handle5, 'Position', [1455 881 431 85], 'OuterPosition', [1447 873 447 178])
        % imshow(final_line3_aux)
        % title('Line 3')
        % 
        % handle6 = figure; 
        % set(handle6, 'Position', [1452 641 433 155], 'OuterPosition', [1444 633 449 248])
        % subplot(2,4,1)
        % imshow(char1)
        % title('char1')
        % 
        % subplot(2,4,2)
        % imshow(char2)
        % title('char2')
        % 
        % subplot(2,4,3)
        % imshow(char3)
        % title('char3')
        % 
        % subplot(2,4,4)
        % imshow(char4)
        % title('char4')
        % 
        % subplot(2,4,5)
        % imshow(char5)
        % title('char5')
        % 
        % subplot(2,4,6)
        % imshow(char6)
        % title('char6')
        % 
        % subplot(2,4,7)
        % imshow(char7)
        % title('char7')
        % 
        % subplot(2,4,8)
        % imshow(char8)
        % title('char8')
        
        
        %% ##################### PREPARE CHARS TO NN LINE 2 #######################
        % get the chars from image of line3
        
        % resize the image just to read the characters
        frameless6 = line2;
        [rows6, cols6] = size(frameless6);
        
        % Find the first row with a pixel value of 1
        first_row6 = find(any(frameless6 == 1, 2), 1, 'first');
        
        % Find the last row with a pixel value of 1
        last_row6 = find(any(frameless6 == 1, 2), 1, 'last');
        
        % Find the first column with a pixel value of 1
        first_col6 = find(any(frameless6 == 1, 1), 1, 'first');
        
        % Find the last column with a pixel value of 1
        last_col6 = find(any(frameless6 == 1, 1), 1, 'last');
        
        % If no white pixel found, keep the original image
        if isempty(first_row6) || isempty(last_row6) || isempty(first_col6) || isempty(last_col6)
            final_line2 = line2;
            final_line2_copy = final_img_aux; % auxiliar image to finalize the program 160x331 double
        else
            % Crop the image to the desired region
            final_line2 = frameless6(first_row6:last_row6, first_col6:last_col6);
            final_line2_copy = final_img_aux(first_row6:last_row6, first_col6:last_col6); % auxiliar image to finalize the program 25x249 double
        end
        
        
        % % get a region to each number
        % [L7, N7] = bwlabel(final_line2);
        % stats7 = regionprops(L7, 'All');
        % 
        % figure;
        % imshow(final_line2_copy)
        % title('Each char')
        % 
        % for u = 1:size(stats7, 1)
        % 
        %     xu = stats7(u).Centroid(1) - 6;
        %     yu = stats7(u).Centroid(2);
        % 
        %     bboxu = stats7(u).BoundingBox;
        % 
        %     rectangle('Position', bboxu, 'EdgeColor', 'b', 'LineWidth',1);
        % 
        %     % new img with only the number that is the last bbox
        %     last_bboxu = stats7(end).BoundingBox;
        %     last_nr = imcrop(final_line2, last_bboxu);
        %     last_nr_aux = imcrop(final_line2_copy, last_bboxu);
        % end
        
        
        copy_finalfinal = final_final; % to get each number on line2 isolated before the dilate
        % final_img_aux % original img but this size 174x351
        
        [L8, N8] = bwlabel(copy_finalfinal);
        
        stats8 = regionprops(L8 ,'All');
        
        % figure;
        % imshow(copy_finalfinal)
        % title('copy finalfinal')
        
        line2_img = zeros(size(final_final));
        
        for v = 1:size(stats8, 1)
        
            xv = stats8(v).Centroid(1) - 6;
            yv = stats8(v).Centroid(2);
        
            bboxv = stats8(v).BoundingBox;
        
            % rectangle('Position', bboxv, 'EdgeColor', 'g', 'LineWidth',1);
        
            if stats8(v).Centroid(2) < 30
                % disp('Line 1')
        
            elseif stats8(v).Centroid(2) < 100
                % disp('Line 2')
                line2_img = line2_img | L8 == v;
        
            end
        end
        
        % final_line2_img_aux = final_img_aux;
        
        % resize the image just to read the characters
        frameless7 = line2_img;
        [rows7, cols7] = size(frameless7);
        
        % Find the first row with a pixel value of 1
        first_row7 = find(any(frameless7 == 1, 2), 1, 'first');
        
        % Find the last row with a pixel value of 1
        last_row7 = find(any(frameless7 == 1, 2), 1, 'last');
        
        % Find the first column with a pixel value of 1
        first_col7 = find(any(frameless7 == 1, 1), 1, 'first');
        
        % Find the last column with a pixel value of 1
        last_col7 = find(any(frameless7 == 1, 1), 1, 'last');
        
        % If no white pixel found, keep the original image
        if isempty(first_row7) || isempty(last_row7) || isempty(first_col7) || isempty(last_col7)
            final_line2_img = line2_img;
            final_line2_img_aux = final_img_aux;
        else
            % Crop the image to the desired region
            final_line2_img = frameless7(first_row7:last_row7, first_col7:last_col7);
            final_line2_img_aux = final_img_aux(first_row7:last_row7, first_col7:last_col7);
        end
        
        [L9, N9] = bwlabel(final_line2_img);
        
        stats9 = regionprops(L9 ,'All');
        
        % handle7 = figure;
        % set(handle7, 'Position', [1452 422 434 133], 'OuterPosition', [1444 414 450 226])
        % imshow(final_line2_img)
        % title('Line 2')
        
        % auxiliar variables to count
        last1 = 0;
        last2 = 0;
        last3 = 0;
        
        for w = 1:size(stats9, 1)
        
            xw = stats9(w).Centroid(1) - 6;
            yw = stats9(w).Centroid(2);
        
            bboxw = stats9(w).BoundingBox;
        
            rectangle('Position', bboxw, 'EdgeColor', 'y', 'LineWidth',1);
        
            try 
                % these bboxs is where the numbers are
                third_bboxw = stats9(end).BoundingBox; % last number
            
                second_bboxw = stats9(end-1).BoundingBox; % last-1 number
            
                first_bboxw = stats9(end-2).BoundingBox; % last-2 number
            catch 
                disp('ERROR, ending...')
                % write in the txt file
                fprintf(file,'%d,%d,%d,%d,%d,%d,%s,%s,%s,%s,%s,%s,%s,%s,%s \n', ... 
                    numMec, numSeq, numImg, stampN, numNam, numAdd, numDoor, D1, D2, D3, D4, D5, D6, D7, D8);
                continue
            end
        
            % ############## for the last character ##############
            if stats9(end).Area > 100 && stats9(end).Area < 109 && stats9(end).Circularity > 0.23 && stats9(end).Circularity < 0.30 && stats9(end).Solidity > 0.54 && stats9(end).Solidity < 0.61
                % disp('Number 7')
                last1 = 7;
        
            elseif stats9(end).Area > 131 && stats9(end).Area < 139 && stats9(end).Circularity > 0.1960 && stats9(end).Circularity < 0.24 && stats9(end).Solidity > 0.5430 && stats9(end).Solidity < 0.60
                % disp('Number 3')
                last1 = 3;
        
            elseif stats9(end).Area > 144 && stats9(end).Area < 151 && stats9(end).Circularity > 0.29 && stats9(end).Circularity < 0.33 && stats9(end).Solidity > 0.63 && stats9(end).Solidity < 0.71
                % disp('Number 8')
                last1 = 8;
        
            elseif stats9(end).Area > 137 && stats9(end).Area < 152 && stats9(end).Circularity > 0.39 && stats9(end).Circularity < 0.44 && stats9(end).Solidity > 0.70 && stats9(end).Solidity < 0.76
                % disp('Number 4')
                last1 = 4;
        
            elseif stats9(end).Area > 86 && stats9(end).Area < 99 && stats9(end).Circularity > 0.27 && stats9(end).Circularity < 0.36 && stats9(end).Solidity > 0.61 && stats9(end).Solidity < 0.77
                % disp('Number 1')
                last1 = 1;
        
            elseif stats9(end).Area > 160 && stats9(end).Area < 169 && stats9(end).Circularity > 0.52 && stats9(end).Circularity < 0.54 && stats9(end).Solidity > 0.69 && stats9(end).Solidity < 0.71
                % disp('Number 0')
                last1 = 0;
        
            elseif stats9(end).Area > 142 && stats9(end).Area < 153 && stats9(end).Circularity > 0.36 && stats9(end).Circularity < 0.4520 && stats9(end).Solidity > 0.63 && stats9(end).Solidity < 0.71
                % disp('Number 6')
                last1 = 6;
        
            elseif stats9(end).Area > 135 && stats9(end).Area < 147 && stats9(end).Circularity > 0.18 && stats9(end).Circularity < 0.25 && stats9(end).Solidity > 0.56 && stats9(end).Solidity < 0.62
                % disp('Number 2')
                last1 = 2;
        
            elseif stats9(end).Area > 143 && stats9(end).Area < 148 && stats9(end).Circularity > 0.22 && stats9(end).Circularity < 0.25 && stats9(end).Solidity > 0.55 && stats9(end).Solidity < 0.58
                % disp('Number 5')
                last1 = 5;
        
            elseif stats9(end).Area > 135 && stats9(end).Area < 145 && stats9(end).Circularity > 0.41 && stats9(end).Circularity < 0.47 && stats9(end).Solidity > 0.66 && stats9(end).Solidity < 0.70
                % disp('Number 9')
                last1 = 9;
        
            end
        
        
            % ############## for the last-1 character ##############
            if stats9(end-1).Area > 100 && stats9(end-1).Area < 109 && stats9(end-1).Circularity > 0.23 && stats9(end-1).Circularity < 0.30 && stats9(end-1).Solidity > 0.54 && stats9(end-1).Solidity < 0.61
                % disp('Number 7')
                last2 = 7;
        
            elseif stats9(end-1).Area > 131 && stats9(end-1).Area < 139 && stats9(end-1).Circularity > 0.1960 && stats9(end-1).Circularity < 0.24 && stats9(end-1).Solidity > 0.5430 && stats9(end-1).Solidity < 0.60
                % disp('Number 3')
                last2 = 3;
        
            elseif stats9(end-1).Area > 144 && stats9(end-1).Area < 151 && stats9(end-1).Circularity > 0.29 && stats9(end-1).Circularity < 0.33 && stats9(end-1).Solidity > 0.63 && stats9(end-1).Solidity < 0.71
                % disp('Number 8')
                last2 = 8;
        
            elseif stats9(end-1).Area > 137 && stats9(end-1).Area < 152 && stats9(end-1).Circularity > 0.39 && stats9(end-1).Circularity < 0.44 && stats9(end-1).Solidity > 0.70 && stats9(end-1).Solidity < 0.76
                % disp('Number 4')
                last2 = 4;
        
            elseif stats9(end-1).Area > 86 && stats9(end-1).Area < 99 && stats9(end-1).Circularity > 0.27 && stats9(end-1).Circularity < 0.36 && stats9(end-1).Solidity > 0.61 && stats9(end-1).Solidity < 0.77
                % disp('Number 1')
                last2 = 1;
        
            elseif stats9(end-1).Area > 160 && stats9(end-1).Area < 169 && stats9(end-1).Circularity > 0.52 && stats9(end-1).Circularity < 0.54 && stats9(end-1).Solidity > 0.69 && stats9(end-1).Solidity < 0.71
                % disp('Number 0')
                last2 = 0;
        
            elseif stats9(end-1).Area > 142 && stats9(end-1).Area < 153 && stats9(end-1).Circularity > 0.36 && stats9(end-1).Circularity < 0.4520 && stats9(end-1).Solidity > 0.63 && stats9(end-1).Solidity < 0.71
                % disp('Number 6')
                last2 = 6;
        
            elseif stats9(end-1).Area > 135 && stats9(end-1).Area < 147 && stats9(end-1).Circularity > 0.18 && stats9(end-1).Circularity < 0.25 && stats9(end-1).Solidity > 0.56 && stats9(end-1).Solidity < 0.62
                % disp('Number 2')
                last2 = 2;
        
            elseif stats9(end-1).Area > 143 && stats9(end-1).Area < 148 && stats9(end-1).Circularity > 0.22 && stats9(end-1).Circularity < 0.25 && stats9(end-1).Solidity > 0.55 && stats9(end-1).Solidity < 0.58
                % disp('Number 5')
                last2 = 5;
        
            elseif stats9(end-1).Area > 135 && stats9(end-1).Area < 145 && stats9(end-1).Circularity > 0.41 && stats9(end-1).Circularity < 0.47 && stats9(end-1).Solidity > 0.66 && stats9(end-1).Solidity < 0.70
                % disp('Number 9')
                last2 = 9;
        
            end
        
        
            % ############## for the last-2 character ##############
            if stats9(end-2).Area > 100 && stats9(end-2).Area < 109 && stats9(end-2).Circularity > 0.23 && stats9(end-2).Circularity < 0.30 && stats9(end-2).Solidity > 0.54 && stats9(end-2).Solidity < 0.61
                % disp('Number 7')
                last3 = 7;
        
            elseif stats9(end-2).Area > 131 && stats9(end-2).Area < 139 && stats9(end-2).Circularity > 0.1960 && stats9(end-2).Circularity < 0.24 && stats9(end-2).Solidity > 0.5430 && stats9(end-2).Solidity < 0.60
                % disp('Number 3')
                last3 = 3;
        
            elseif stats9(end-2).Area > 144 && stats9(end-2).Area < 151 && stats9(end-2).Circularity > 0.29 && stats9(end-2).Circularity < 0.33 && stats9(end-2).Solidity > 0.63 && stats9(end-2).Solidity < 0.71
                % disp('Number 8')
                last3 = 8;
        
            elseif stats9(end-2).Area > 137 && stats9(end-2).Area < 152 && stats9(end-2).Circularity > 0.39 && stats9(end-2).Circularity < 0.44 && stats9(end-2).Solidity > 0.70 && stats9(end-2).Solidity < 0.76
                % disp('Number 4')
                last3 = 4;
        
            elseif stats9(end-2).Area > 86 && stats9(end-2).Area < 99 && stats9(end-2).Circularity > 0.27 && stats9(end-2).Circularity < 0.36 && stats9(end-2).Solidity > 0.61 && stats9(end-2).Solidity < 0.77
                % disp('Number 1')
                last3 = 1;
        
            elseif stats9(end-2).Area > 160 && stats9(end-2).Area < 169 && stats9(end-2).Circularity > 0.52 && stats9(end-2).Circularity < 0.54 && stats9(end-2).Solidity > 0.69 && stats9(end-2).Solidity < 0.71
                % disp('Number 0')
                last3 = 0;
        
            elseif stats9(end-2).Area > 142 && stats9(end-2).Area < 153 && stats9(end-2).Circularity > 0.36 && stats9(end-2).Circularity < 0.4520 && stats9(end-2).Solidity > 0.63 && stats9(end-2).Solidity < 0.71
                % disp('Number 6')
                last3 = 6;
        
            elseif stats9(end-2).Area > 135 && stats9(end-2).Area < 147 && stats9(end-2).Circularity > 0.18 && stats9(end-2).Circularity < 0.25 && stats9(end-2).Solidity > 0.56 && stats9(end-2).Solidity < 0.62
                % disp('Number 2')
                last3 = 2;
        
            elseif stats9(end-2).Area > 143 && stats9(end-2).Area < 148 && stats9(end-2).Circularity > 0.22 && stats9(end-2).Circularity < 0.25 && stats9(end-2).Solidity > 0.55 && stats9(end-2).Solidity < 0.58
                % disp('Number 5')
                last3 = 5;
        
            elseif stats9(end-2).Area > 135 && stats9(end-2).Area < 145 && stats9(end-2).Circularity > 0.41 && stats9(end-2).Circularity < 0.47 && stats9(end-2).Solidity > 0.66 && stats9(end-2).Solidity < 0.70
                % disp('Number 9')
                last3 = 9;
        
            else
                % disp('Number 0')
                last3 = 0;
            end
        
        end
        
        if last3 == 0
            numDoor = [num2str(last2), num2str(last1)];
        else
            numDoor = [num2str(last3), num2str(last2), num2str(last1)];
        end
        
        %% ############################ NN TRAINING ###############################
        
        % classify each number
        if numel(cropped_imgs) >= 1
            D1 = classify(net, char1);
        end
        
        if numel(cropped_imgs) >= 2
            D2 = classify(net, char2);
        end
        
        if numel(cropped_imgs) >= 3
            D3 = classify(net, char3);
        end
        
        if numel(cropped_imgs) >= 4
            D4 = classify(net, char4);
        end
        
        if numel(cropped_imgs) >= 5
            D5 = classify(net, char5);
        end
        
        if numel(cropped_imgs) >= 6
            D6 = classify(net, char6);
        end
        
        if numel(cropped_imgs) >= 7
            D7 = classify(net, char7);
        end
        
        if numel(cropped_imgs) >= 8
            D8 = classify(net, char8);
        end
        
        disp('End of the program.')

        % write in the txt file
        fprintf(file,'%d,%d,%d,%d,%d,%d,%s,%s,%s,%s,%s,%s,%s,%s,%s \n', ... 
            numMec, numSeq, numImg, stampN, numNam, numAdd, numDoor, D1, D2, D3, D4, D5, D6, D7, D8);
    end
end
NMec = numMec;
end