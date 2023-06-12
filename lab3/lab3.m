%% Project 1 
[P,Q]=size(data);
%P = 2*P;
%Q = 2*Q;
I = data;


F=fftshift(fft2(I));
F_spectrum = abs(F);
F_log_spectrum = log(1+F_spectrum);
figure;
subplot(1,3,1), imshow(F_spectrum, []);
title('原始频谱');
subplot(1,3,2), imshow(F_log_spectrum, []);
title('对数频谱');
%F_1 = fftshift(real(log(fft2(f_1)+1)));
%F_1_2= fftshift(real(fft2(f_1)));

%subplot(1,5,3);
%imshow(F_1,[]);
%subplot(1,5,4);
%imshow(F_1_2,[]);

g_1 = real(ifft2(F));
subplot(1,3,3), imshow(g_1, []);
title('处理后的图像');



%% Project 2 higherfilter 


T1=zeros(P,Q);
T1(1:P,1:Q)=data;
for i=1:P
    for j=1:Q
        T1(i,j) = T1(i,j) * (-1)^(i+j);
    end
end
F1=fft2(T1);

D0=sqrt(185^2+93^2);
D=zeros(P,Q);
for l=1:P
    for r=1:Q
        D(l,r)=sqrt((l-P/2)^2+(r-Q/2)^2);
    end
end

D0 = 10;
H_Gaussian_higherfilter=1-exp((-(D.^2))./(2*(D0^2)));
G_2 = F1 .* H_Gaussian_higherfilter;
g_2 = real(ifft2(G_2));

for l=1:P
    for r=1:Q
        g_2(l,r)=g_2(l,r)*(-1)^(l+r);
    end
end
result_2 = g_2(1:370,1:286);

subplot(2,3,1), imshow(data,[]);
title('原始图像');
subplot(2,3,2), imshow(result_2,[]);
title('高通高斯滤波器图像');

p = historgram(result_2+data);
rs = cal(p);
rs = uint8(rs*255);
result_2_his = transform(result_2,rs);
%result_2_his = uint8(result_2_his);

subplot(2,3,3), imshow(result_2_his,[0,255]);
title('均衡化后的Enhance图像');

subplot(2,3,4), imshow(data+result_2,[]);
title('Enhance图像');

rs1=rs;
pre=rs1(1);
for i=2:256
    tmp = rs1(i);
    rs1(i) = rs1(i)-pre;
    pre = tmp;
end

subplot(2,3,6), stem(rs1,'.');
title('均衡化后的Enhance图像直方图');

%% Project 3 lowerfilter

H_Gaussian_lowerfilter=exp((-D.^2)./(2*D0^2));
G_3 =  F1 .* H_Gaussian_lowerfilter;
g_3 = real(ifft2(G_3));
for l=1:P
    for r=1:Q
        g_3(l,r)=g_3(l,r)*(-1)^(l+r);
    end
end
result_3=g_3(1:370,1:286);
subplot(1,2,1), imshow(data,[]);
title('原始图像');
subplot(1,2,2), imshow(result_3,[]);
title('低通高斯滤波器图像');

%subplot(1,3,3), imshow(result_3-data,[]);

%% 各种函数
%归一化
function p = historgram(data)
    [width,height] = size(data);
    nums = zeros(1,256);    %保存各灰度级对应的像素点数
    for i = 0:255
        bw = (data<=i) & (data>i-1);
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
        %bw = (data==i);
        bw = (data<=i) & (data>i-1);
        dstImg(bw) = rs(i+1); % 原图像中值为k的像素点变为s(k+1)
    end
end


