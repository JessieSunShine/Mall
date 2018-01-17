//
//  TopListScrollView.m
//  BaseDemo
//
//  Created by zizilink on 2017/12/25.
//  Copyright © 2017年 Jessie. All rights reserved.
//

#import "TopListScrollView.h"
#import "TopLitstModel.h"

@interface TopListScrollView ()<UIScrollViewDelegate>
{
    //   分类最小宽度
    CGFloat lableW;
    //    间距
    CGFloat spaceW;
    //    记录lable的位置
    CGFloat AllLableW;
}
@property(nonatomic,strong)NSMutableArray*dataSource;
@property(nonatomic,strong)NSMutableArray*dataLableSource;

@property(nonatomic,strong)UIView*selectBottomView;
@end


@implementation TopListScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        
        self.dataSource=[[NSMutableArray alloc]init];
        
        lableW=40;
        spaceW=10;
        AllLableW=0;
        
        [self initDataSource];
        
        [self setupCreatUI];
    }
    
    return self;
}

//数据源
-(void)initDataSource{
    
//    NSArray*titleArr=@[@"热卖",@"生鲜",@"日用百货",@"今日上新-Top",@"女士服饰",@"男士服饰",@"婴幼儿用品",@"厨房用品"];
    NSArray*titleArr=@[@"热卖",@"生鲜",@"百货",@"上新",@"女士",@"男士",@"婴幼儿",@"厨房"];

    for (int i=0;  i<titleArr.count;i++) {
        
        TopLitstModel*item=[[TopLitstModel alloc]init];
        item.name=titleArr[i];
        [self.dataSource addObject:item];
        
    }
    
}

-(void)setupCreatUI{
    
    self.delegate=self;
    self.scrollEnabled=YES;
    self.showsHorizontalScrollIndicator=NO;
    
//    底部分割线
    UIView*lineView=[[UIView alloc]initWithFrame:CGRectMake(0, self.height-1, self.width, 1)];
    lineView.backgroundColor=JS_RGB(222, 222, 222);
    [self addSubview:lineView];
    
//    分类lable的创建
    for (int index=0; index<self.dataSource.count; index++) {
        
        TopLitstModel*item=self.dataSource[index];
        
        UIButton*btn=[[UIButton alloc]init];
        [btn setTitleColor:JS_RGB(113, 113, 113) forState:UIControlStateNormal];
        btn.titleLabel.font=[JS_Tool PXFontConversionIOS:28];
        btn.tag=index;
        btn.userInteractionEnabled=YES;
        [btn setTitle:item.name forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(touchTag:) forControlEvents:UIControlEventTouchUpInside];
        if (index==0) {
            [btn setTitleColor:MAIN_COLOR_VALUE forState:UIControlStateNormal];
            
        }
        CGFloat textWidth=[item.name textSizeWith:CGSizeMake(MAXFLOAT, MAXFLOAT) andFont:[JS_Tool PXFontConversionIOS:28]].width;
        
        
        if (lableW>=textWidth) {
            
            item.itemWidth=lableW;
            
        }else{
            
            item.itemWidth=textWidth;
        }
        
//        记录所有item的总长度
        AllLableW+=item.itemWidth;
        
//        存储每个lable的位置
        item.AllLableX=AllLableW-item.itemWidth+spaceW*index;
        
        btn.frame=CGRectMake(item.AllLableX, 0, item.itemWidth, self.height-4);
        [self addSubview:btn];
        [self.dataLableSource addObject:btn];
        self.contentSize=CGSizeMake(AllLableW+spaceW*index, 0);
        
        
        NSLog(@"当前位置：%d------ 长度:%.f----总长度：%.f--------间距长度：%.f------X位置：%.f",index,item.itemWidth,AllLableW,spaceW*index,item.AllLableX);
        
    }
    
//    底部滑动指示条
    TopLitstModel*item0=self.dataSource[0];
    CGFloat item0W=item0.itemWidth;

    self.selectBottomView=[[UIView alloc]initWithFrame:CGRectMake(item0.AllLableX,self.height-4,item0W, 3)];
    self.selectBottomView.backgroundColor=MAIN_COLOR_VALUE;
    [self addSubview:self.selectBottomView];
    
}

#pragma mark--touch事件

-(void)touchTag:(UIButton*)sender{
    
    TopLitstModel*item=self.dataSource[sender.tag];
    
    [UIView animateWithDuration:0.3 animations:^{
       
        self.selectBottomView.frame=CGRectMake(item.AllLableX,self.height-4,item.itemWidth, 3);
    }];
    
}

-(void)scrollToSelect:(NSInteger)index{
    
    
}

@end
