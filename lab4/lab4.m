%% Project 1 add and estimate noise
[P,Q]=size(data);
subplot(1,2,1),imshow(data,[]),title('原图');

data_1 = data./256;
result1 = imnoise(data_1,'gaussian',0,0.01);

subplot(1,2,2),imshow(result1,[]),title('添加均值为0，方差为0.01的高斯噪声');

%% Project 2 denoise

subplot(1,4,1),imshow(data,[]),title('原图');
result2_1 = data;

ps = 1/3;
p = 0.3;
% ps=0.1，pp=0.2
for i = 1:P
    for j = 1:Q
        if(rand()<p)
            if(rand()<ps)
                result2_1(i,j) = 255;
            else
                result2_1(i,j) = 0;
            end 
        end
    end
end
subplot(1,4,2),imshow(result2_1,[]),title('添加ps=0.1，pp=0.2的椒盐噪声');
result2_2 = data;
ps = 0;
p = 0.3;
% ps=0，pp=0.3
for i = 1:P
    for j = 1:Q
        if(rand()<p)
            if(rand()<ps)
                result2_2(i,j) = 255;
            else
                result2_2(i,j) = 0;
            end 
        end
    end
end
subplot(1,4,3),imshow(result2_2,[]),title('添加ps=0，pp=0.3的椒盐噪声');

result2_3 = data;
ps = 1;
p = 0.3;
% ps=0.3，pp=0.3
for i = 1:P
    for j = 1:Q
        if(rand()<p)
            if(rand()<ps)
                result2_3(i,j) = 255;
            else
                result2_3(i,j) = 0;
            end 
        end
    end
end
subplot(1,4,4),imshow(result2_3,[]),title('添加ps=0.3，pp=0的椒盐噪声');



%% 各种函数











