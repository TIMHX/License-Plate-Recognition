clear;
clc;
Scolor=imread('³µ1.bmp');

Sgray=rgb2gray(Scolor);

s=strel('disk',13);
Bgray=imopen(Sgray,s);%´ò¿ªsgraysÍ¼Ïñ
Egray=imsubtract(Sgray,Bgray);

grd=edge(Egray,'roberts',0.09,'both');
se=[1;1;1];
I3=imerode(grd,se);

bg1=imclose(I3,strel('rectangle',[8,18]));
bg3=imclose(bg1,strel('rectangle',[8,14]));
bg2=bwareaopen(bg3,700);

[y,x]=size(bg2);
I6=double(bg2);
Y1=zeros(y,1);
for i=1:y
    for j=1:x
        if(I6(i,j,1)==1)
            Y1(i,1)=Y1(i,1)+1;
        end
    end
end
[temp,MaxY]=max(Y1);
PY1=MaxY;
while((Y1(PY1,1)>=50)&&(PY1>1))
   PY1=PY1-7;end
PY2=MaxY;
while((Y1(PY2,1)>=50)&&(PY2<y))
   PY2=PY2+7;
end
X1=zeros(1,x);
for j=1:x
    for i=PY1:PY2
        if(I6(i,j,1)==1)
            X1(1,j)=X1(1,j)+1;
        end
    end
end
PX1=1;
while((X1(1,PX1)<3)&&(PX1<x))
   PX1=PX1+1;
end
PX2=x;
while((X1(1,PX2)<3)&&(PX2>PX1))
   PX2=PX2-1;
end
DW=Scolor(PY1:PY2,PX1:PX2,:);

%if isrgb(DW)   
    I1=rgb2gray(DW);
%else  I1=DW;
%end
g_max=double(max(max(I1)));
g_min=double(min(min(I1)));
T=round(g_max-(g_max-g_min)/3);
[m,n]=size(I1);
imane_bw=im2bw(I1,T/256);
[y1,x1,z1]=size(imane_bw);
I3=double(imane_bw);
TT=1;

Y1=zeros(y1,1);
for i=1:y1
    for j=1:x1
        if(I3(i,j,1)==1)
            Y1(i,1)=Y1(i,1)+1;
        end
    end
end
Py1=1;
Py0=1;
while((Y1(Py0,1)<9)&&(Py0<y1))
   Py0=Py0+1;end
Py1=Py0;
while((Y1(Py1,1)>=9)&&(Py1<y1))
  Py1=Py1+1;
end
I2=imane_bw(Py0:Py1,:,:);
%imshow(I2);


d=qiege(I2);
[m,n]=size(d);
k1=1;k2=1;s=sum(d);j=1;
while j~=n
    while s(j)==0
        j=j+1;
    end
    k1=j;
    while s(j)~=0 && j<=n-1
        j=j+1;
    end
    k2=j-1;
    if k2-k1>=round(n/6.5)
        [val,num]=min(sum(d(:,[k1+5,k2-5])));
        d(:,k1+num+5)=0;
    end
end
d=qiege(d);
y1=10;y2=0.25;flag=0;word1=[];
while flag==0
    [m,n]=size(d);
    left=1;wide=0;
    while sum(d(:,wide+1))~=0
        wide=wide+1;
    end
    if wide<y1
        d(:,[1:wide])=0;
        d=qiege(d);
    else
        temp=qiege(imcrop(d,[1 1 wide m]));
        [m,n]=size(temp);
        all=sum(sum(temp));
        two_thirds=sum(sum(temp([round(m/3):2*round(m/3)],:)));
        if two_thirds/all>y2
            flag=1;word1=temp;
        end
        d(:,[1:wide])=0;d=qiege(d);
    end
end
[word2,d]=getword(d);
[word3,d]=getword(d);
[word4,d]=getword(d);
[word5,d]=getword(d);
[word6,d]=getword(d);
[word7,d]=getword(d);
[m,n]=size(word1);
word1=imresize(word1,[22 14]);
word2=imresize(word2,[22 14]);
word3=imresize(word3,[22 14]);
word4=imresize(word4,[22 14]);
word5=imresize(word5,[22 14]);
word6=imresize(word6,[22 14]);
word7=imresize(word7,[22 14]);
figure,
subplot(3,7,8),imshow(word1),title('1');
subplot(3,7,9),imshow(word2),title('2');
subplot(3,7,10),imshow(word3),title('3');
subplot(3,7,11),imshow(word4),title('4');
subplot(3,7,12),imshow(word5),title('5');
subplot(3,7,13),imshow(word6),title('6');
subplot(3,7,14),imshow(word7),title('7');
imwrite(word1,'1.jpg');
imwrite(word2,'2.jpg');
imwrite(word3,'3.jpg');
imwrite(word4,'4.jpg');
imwrite(word5,'5.jpg');
imwrite(word6,'6.jpg');
imwrite(word7,'7.jpg');

liccode=char(['0':'9' 'A':'Z'  '²Ø´¨¸Ê¸Ó¹ó¹ðºÚ»¦¼ª¼Ã¼½½ò½ú¾©¾¯À¼ÁÉÁìÂ³ÃÉÃöÄþÇàÇíÉÂÊ¹ËÕÍîÏæÐÂÑ§ÓåÔ¥ÔÁÔÆÕã']);
tt=1;
l=1;
for I=1:7
    ii=int2str(I);
    t=imread([ii,'.jpg']);
    t=255-t;
    level=graythresh(t);
    t=im2bw(t,level);
    SegBw2=imresize(t,[22 14],'nearest');
    if tt==1
        kmin=37;
        kmax=72;
        t=~t;
        SegBw2=imresize(t,[22 14],'nearest');
    else if tt==2
        kmin=11;
        kmax=36;
        else
        kmin=1;
        kmax=36;
        end
    end
    
        for k2=kmin:kmax
            fname=strcat('Sam',liccode(k2),'.jpg');
            SamBw22=imread(fname);
            SamBw22=rgb2gray(SamBw22);
            SamBw2=imresize(SamBw22,[22 14],'nearest');
            level=graythresh(SamBw2);
            SamBw2=im2bw(SamBw2,level);
            for i=1:22
                for j=1:14
                    SubBw2(i,j)=SegBw2(i,j)-SamBw2(i,j);
                end
            end
            Dmax=0;
            for k1=1:22
                for l1=1:14
                    if(SubBw2(k1,l1)>0||SubBw2(k1,l1)<0)
                        Dmax=Dmax+1;
                    end
                end
            end
            Error(k2)=Dmax;
        end
        Error1=Error(kmin:kmax);
        MinError=min(Error1);
        findc=find(Error1== MinError);
        if tt==1
            findc=findc+36;
        end
        if tt==2
            findc=findc+10;
        end
        tt=tt+1;
        res=liccode(findc);
        shibiejieguo(1,l)=res;
        l=l+1;
end

    msgbox(shibiejieguo,'Ê¶±ð½á¹û');
    duchushengyin(shibiejieguo);   
  