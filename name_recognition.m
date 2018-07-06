function [ img_name ] = name_recognition( recog_img )

n=str2num(recog_img(1:end-4));
fid=fopen('datar.txt','rt');
tmp=textscan(fid,'%d,%c,%s','Delimiter','\n');
fclose(fid);
img_name=strcat(tmp{3}(n,1),',',int2str(tmp{1}(n,1)),',',(tmp{2}(n,1)));
% img_rollno=;
% img_gender=;
% if(strcmp(recog_img,'1.jpg')||strcmp(recog_img,'2.jpg'))
%     img_name=' Pranjal Srivastava (IT/2K14)';
% elseif(strcmp(recog_img,'3.jpg')||strcmp(recog_img,'4.jpg'))
%     img_name=' Akash kashyap (IT/2K14)';
% elseif(strcmp(recog_img,'5.jpg')||strcmp(recog_img,'6.jpg'))
%     img_name=' Rishabha Sachan (IT/2K14)';
% elseif(strcmp(recog_img,'7.jpg')||strcmp(recog_img,'8.jpg'))
%     img_name=' Aman kumar (IT/2K14)';
% elseif(strcmp(recog_img,'9.jpg')||strcmp(recog_img,'10.jpg'))
%     img_name=' Abhishek Pandey (IT/2K14)';
% else
%     img_name=' Details not registered in database ';
% end
end

