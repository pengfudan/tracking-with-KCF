%将视频文件转化成图片格式保存
clear;close all;
v = VideoReader('caixukun.mp4');
for i=1:200
    img = read(v,i+10);
    i_str = int2str(i);
    switch 4-length(i_str)
        case 1
            num_str = strcat('0',i_str);
        case 2
            num_str = strcat('00',i_str);
        case 3
            num_str = strcat('000',i_str);
    end
    filename = strcat(num_str,'.jpg');
    filename = strcat('./data/Benchmark/Caixukun/img/',filename);
    imwrite(img,filename);
end