%% Project1.1
width = 256;  % 图片宽度
height = 256; % 图片高度

wid=5;
r0=100;
I=zeros(width,height)
for l=1:width
    for r=1:height
        rt=sqrt((l-width/2).^2+(r-height/2).^2);
        if abs(rt-r0)<=wid
            I(l,r)=1;
        end
    end
end
imshow(I);

%% Project1.2
width = 256;  % 图片宽度
height = 256; % 图片高度
cont=1/256;

I=zeros(width,height);
for l=1:width
    for r=1:height
        I(l,r)=(r)*cont;
    end
end
imshow(I)

%% Project2

width = 256;  % 图片宽度
height = 256; % 图片高度



subplot(1,3,1);
grey(x,4);
%imshow(x,[0,16]);
subplot(1,3,2);
grey(x,6);
%imshow(x,[0,64]);
subplot(1,3,3);
grey(x,8);
%imshow(x,[0,256]);


%% Project3.1
t1=x(:,40);
plot(t1);
%% Project3.2
imrgc=gray2rgb(x);
for i=1:370
    for j=1:286
        if j==40
            %显示红色
            imrgc(i,j,1)=255;
            imrgc(i,j,2)=0;
            imrgc(i,j,3)=0; 
        else
            %line之外仍为原灰度图显示的颜色
            imrgc(i,j,1)=x(i,j);
            imrgc(i,j,2)=x(i,j);
            imrgc(i,j,3)=x(i,j); 
        end
    end
end
imshow(imrgc);
%% Project3.3
N=2;
wid_new=N*370;
hei_new=N*286;
subplot(1,3,1);
imshow(x,[0,128]);
rt=zeros(wid_new,hei_new);
for i=1:wid_new
    for j=1:hei_new
        z=i/N;
        y=j/N;
        u=z-floor(z);
        v=y-floor(y);
        if z<1
            z=1;
        end
        if y<1
            y=1;
        end
        rt(i,j,:)=x(floor(z),floor(y),:)*(1-u)*(1-v)+x(floor(z),ceil(y),:)*(1-u)*v+x(ceil(z),ceil(y),:)*(u)*(1-v)+x(ceil(z),ceil(y),:)*u*v;
    end
end
subplot(1,3,2);
imshow(rt,[0,128]);
N=0.4;
wid_new=floor(N*370);
hei_new=floor(N*286);
rt=zeros(wid_new,hei_new);
for i=1:wid_new
    for j=1:hei_new
        z=i/N;
        y=j/N;
        u=z-floor(z);
        v=y-floor(y);
        if z<1
            z=1;
        end
        if y<1
            y=1;
        end
        rt(i,j,:)=x(floor(z),floor(y),:)*(1-u)*(1-v)+x(floor(z),ceil(y),:)*(1-u)*v+x(ceil(z),ceil(y),:)*(u)*(1-v)+x(ceil(z),ceil(y),:)*u*v;
    end
end
subplot(1,3,3);
imshow(rt,[0,128]);
%https://blog.csdn.net/m0_58837398/article/details/121110917?ops_request_misc=&request_id=&biz_id=102&utm_term=matlab%E5%AE%9E%E7%8E%B0%E5%9B%BE%E5%83%8F%E7%9A%84%E6%94%BE%E5%A4%A7&utm_medium=distribute.pc_search_result.none-task-blog-2~all~sobaiduweb~default-0-121110917.142^v73^insert_down3,201^v4^add_ask,239^v2^insert_chatgpt&spm=1018.2226.3001.4187
%MATLAB实现图像的放大和缩放
%借鉴了双线性插值实现方法
%% Project4
%  x为导入的灰度矩阵
imrgb=gray2rgb(x);
maskred=233;
for i=1:370
    for j=1:286
        if imrgb(i,j,1)>maskred && j<135 && j>90 && i<300 && i>250
            
        else
            %未选中部分仍为原灰度图显示的颜色
            imrgb(i,j,1)=x(i,j);
            imrgb(i,j,2)=x(i,j);
            imrgb(i,j,3)=x(i,j); 
        end
    end
end

subplot(1,2,1);
imshow(imrgb,[]);

%% functions
function result=grey(y,n)
    imshow(y,[0,2^n]);
end

% 灰度图转换为彩色图
function I = gray2rgb(X)
R = red(X);
G = green(X);
B = blue(X);
I(:,:,1) = R;
I(:,:,2) = G;
I(:,:,3) = B;
I = uint8(I);
end
 
% 红色通道
function R = red(X)
R = zeros(size(X));
R(X < 128) = 30;
R(128 <= X & X < 192) = 2*X(128 <= X & X < 192)-150;
R(192 <= X) = 234;
end
% 绿色通道
function G = green(X)
G = zeros(size(X));
G(X < 90) = 2*X(X < 90)+40;
G(90 <= X & X < 160) = 180;
G(160 <= X) = 0;

end
% 蓝色通道
function B = blue(X)
B = zeros(size(X));
B(X < 64) = 115;
B(64 <= X & X < 128) = 510-4*X(64 <= X & X < 128);
B(128 <= X) = 36;

end

%https://blog.csdn.net/qq_42276781/article/details/121500544?ops_request_misc=%257B%2522request%255Fid%2522%253A%2522167811071816800197067048%2522%252C%2522scm%2522%253A%252220140713.130102334..%2522%257D&request_id=167811071816800197067048&biz_id=0&utm_medium=distribute.pc_search_result.none-task-blog-2~all~baidu_landing_v2~default-3-121500544-null-null.142^v73^insert_down3,201^v4^add_ask,239^v2^insert_chatgpt&utm_term=matlab%E5%B0%86%E7%81%B0%E5%BA%A6%E5%9B%BE%E8%BD%AC%E5%8C%96%E4%B8%BArgb&spm=1018.2226.3001.4187