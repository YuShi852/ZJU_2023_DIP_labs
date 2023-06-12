%% Project1.1
%对数变换

C = 1.5;

r=im2uint8(C.*data.*log(1+double(data)));
subplot(1,2,1);
imshow(data),title("原图");

subplot(1,2,2);
imshow(r),title("对数变换");
%% Project1.2
%幂变换

C = 1;
y = 1.5;

s=im2uint8(C.*data.^y);
subplot(1,2,1);
imshow(data),title("原图");

subplot(1,2,2);
imshow(s,[0,255]),title("幂变换");
%% Project2.1
%直方图显示以及直方图均衡化
%I=rgb2gray(data);
I=im2uint8(data);
I=rgb2gray(I);
J=histeq(I);
%J=255.*int();
%J=rgb2gray(J);

p=historgram(I);
rs = cal(p);
rs = uint8(rs*255);
dstImg = transform(I,rs);
dstImg = uint8(dstImg);

subplot(2,2,1),imshow(I,[0,255]),title("原灰度图像");
subplot(2,2,2),imshow(dstImg,[0,255]),title("均衡化后的灰度图像");
subplot(2,2,3),imhist(I),title("原灰度图像直方图");
subplot(2,2,4),imhist(dstImg),title("均衡化后的灰度图像直方图");


%% Project2.2
%任务1中增强图像直方图对比
I=rgb2gray(data);

data1=im2uint8(data);


subplot(2,3,1),imshow(data1,[0,255]),title("原灰度图像");
subplot(2,3,2),imshow(r,[0,255]),title("对数变换后的灰度图像");
subplot(2,3,3),imshow(s,[0,255]),title("幂变换后的灰度图像");

subplot(2,3,4),imhist(data1),title("原灰度直方图");
subplot(2,3,5),imhist(r),title("对数变换后的灰度直方图");
subplot(2,3,6),imhist(s),title("幂变换后的灰度直方图");

%% Project3.1
%低通滤波器——3*3盒式滤波器
k_a = 1/9;
h1=k_a*[1,1,1;
        1,1,1;
        1,1,1];%盒式核
y1=rgb2gray(data);
Img_res_0 = wzc_filter(y1,h1);
Img_res_1 = wzc_filter(Img_res_0,h1);
Img_res_1 = wzc_filter(Img_res_1,h1);
Img_res_1 = wzc_filter(Img_res_1,h1);
Img_res_1 = wzc_filter(Img_res_1,h1);
Img_res_Duplicate = wzc_filter(Img_res_1,h1);
subplot(1,2,1);
imshow(y1),title("原图");
subplot(1,2,2);
imshow(Img_res_Duplicate),title("重复CT图像的增强（盒式滤波器）");
%% Project3.2
%高通滤波器_拉普拉斯
h2_1=[-1,-1,-1;
     -1,8,-1;
      -1,-1,-1];%拉普拉斯核1
h2_2=[0,-1,0;
      -1,4,-1;
      0,-1,0];%拉普拉斯核2
%y2=rgb2gray(data);
y2=mean(data,3);
Img_res_2_1 = wzc_filter(y2,h2_1);
Img_res_2_2 = wzc_filter(y2,h2_2);
Img_res_2_1 = ceil(Img_res_2_1/max(Img_res_2_1(:))*255);
Img_res_2_2 = ceil(Img_res_2_2/max(Img_res_2_2(:))*255);
subplot(1,3,1);
imshow(y2),title("原图");
subplot(1,3,2);
imshow(Img_res_2_1,[]),title("拉普拉斯核1");
subplot(1,3,3);
imshow(Img_res_2_2,[]),title("拉普拉斯核2");

%% Project3.2
%高通滤波器_sobel
h3_1=[-1,-2,-1;
      0,0,0;
      1,2,1];%sobel核1
h3_2=[-1,0,1;
      -2,0,2;
      -1,0,1];%sobel核2
y3=rgb2gray(data);
Img_res_3_1 = wzc_filter(y3,h3_1);
Img_res_3_2 = wzc_filter(y3,h3_2);
subplot(1,3,1);
imshow(y2),title("原图");
subplot(1,3,2);
imshow(Img_res_3_1),title("sobel核1  x轴");
subplot(1,3,3);
imshow(Img_res_3_2),title("sobel核1  y轴");
%% Project3.3
%
k_a = 1/9;
h1=k_a*[1,1,1;
        1,1,1;
        1,1,1];%盒式核
y1=rgb2gray(data);
Img_res_0 = wzc_filter(y1,h1);
Img_res_1 = wzc_filter(Img_res_0,h1);
Img_res_1 = wzc_filter(Img_res_1,h1);
Img_res_1 = wzc_filter(Img_res_1,h1);
Img_res_1 = wzc_filter(Img_res_1,h1);
Img_res_Duplicate = wzc_filter(Img_res_1,h1);
subplot(1,2,1);
imshow(y1),title("原图");
subplot(1,2,2);
imshow(Img_res_Duplicate),title("重复CT图像的增强（盒式滤波器）");
%% 各种函数

% 归一化
function p = historgram(data)
    [width,height] = size(data);
    nums = zeros(1,256);    %保存各灰度级对应的像素点数
    for i = 0:255
        bw = (data==i);
        h(i+1) = sum(bw(:)); %bw中所有元素的和即为灰度级k对应的像素点数
    end
    p = h/(width*height);
end

function s = cal(p) %计算累积
    s = zeros(1,256);
    s(1) = p(1);
    for i=2:256
        s(i) = s(i-1)+p(i);
    end
end

function dstImg = transform(data,rs)
    [width,height] = size(data);
    dstImg = zeros(width,height);
    for i = 0:255
        bw = (data==i);
        dstImg(bw) = rs(i+1); % 原图像中值为k的像素点变为s(k+1)
    end
end

function Img_res = wzc_filter(data,filterMat)%自制3*3滤波器函数（卷积）
    [width,height] = size(data);
    newdata = zeros(width+2,height+2);
    newdata(2:width+1,2:height+1) = data;
    Img_res = zeros(width,height);
    for i=2:width+1
        for j=2:height+1
            newintensity = 0;
            newintensity = newintensity + newdata(i-1,j-1)*filterMat(3,3);
            newintensity = newintensity + newdata(i-1,j)*filterMat(3,2);
            newintensity = newintensity + newdata(i-1,j+1)*filterMat(3,1);
            newintensity = newintensity + newdata(i,j-1)*filterMat(2,3);
            newintensity = newintensity + newdata(i,j)*filterMat(2,2);
            newintensity = newintensity + newdata(i,j+1)*filterMat(2,1);
            newintensity = newintensity + newdata(i+1,j-1)*filterMat(1,3);
            newintensity = newintensity + newdata(i+1,j)*filterMat(1,2);
            newintensity = newintensity + newdata(i+1,j+1)*filterMat(1,1);
            Img_res(i-1,j-1) = newintensity;
        end
    end
end




