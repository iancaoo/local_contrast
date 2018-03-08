imgPath = 'image/';
tiffFiles = dir(fullfile(imgPath, '*.tif'));
nefFiles = dir(fullfile(imgPath, '*.nef'));
jpgFiles = dir(fullfile(imgPath, '*.jpg'));
bmpFiles = dir(fullfile(imgPath, '*.bmp'));
allImageFiles = [tiffFiles; nefFiles; jpgFiles; bmpFiles];
% img_path_list = dir(strcat(file_path,'*.jpg'));  
% img_num = length(img_path_list);  
img_num = length(allImageFiles); 
if img_num > 0   
        for j = 1:img_num   
            image_name = allImageFiles(j).name;            
            image =  imread(strcat(imgPath,image_name));
            gray_image = rgb2gray(image);
            std_image = stdfilt(gray_image);
            imshow(gray_image);
            title('original image');
            
            figure
            imshow(std_image,[]);
            title('Result of local contrast');
            saveas(gcf,['output/',int2str(j),'.jpg'])  
  
       end  
end