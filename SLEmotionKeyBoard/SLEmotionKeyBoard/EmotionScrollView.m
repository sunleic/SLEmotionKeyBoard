//
//  EmotionScrollView.m
//  SLEmotionKeyBoard
//
//  Created by 孙磊 on 16/4/20.
//  Copyright © 2016年 孙磊. All rights reserved.
//

#import "EmotionScrollView.h"
#import "SLKeyboardView.h"

#define SCREEN_H     [UIScreen mainScreen].bounds.size.height
#define SCREEN_W     [UIScreen mainScreen].bounds.size.width

#define EMOJI_NUMBER 107

@implementation EmotionScrollView{

    NSMutableArray *_emojiArray;
    UIPageControl *pageCtl;
}


-(instancetype)initOnTargetView:(SLKeyboardView *)targetView{

    if (self = [super init]) {
        self.frame = CGRectMake(0, targetView.textViewBG.frame.origin.y + targetView.textViewBG.frame.size.height, targetView.frame.size.width, 160);
        self.pagingEnabled = YES;
        self.backgroundColor = [UIColor colorWithRed:240/255.0f green:243/255.0f blue:249/255.0f alpha:1.0f];
        [targetView addSubview:self];
        
        self.delegate = self;
        
        [self emojiContainer];
        [self createEmotionViewOnTargetView:targetView];
        [self createPageCtlWithTargetView:targetView];
        
        self.showsHorizontalScrollIndicator = NO;
    }
    
    return self;
}

//创建自定义emotion
- (void)createEmotionViewOnTargetView:(UIView *)targetView{

    long pages;
    if (_emojiArray.count/21.0f > _emojiArray.count/21) {
        pages = _emojiArray.count/21 + 1;
    }else{
        pages = _emojiArray.count/21;
    }
    self.contentSize = CGSizeMake(targetView.frame.size.width *pages, 160);
    //NSLog(@"总共%ld页表情",pages);
    for (int i = 0; i < pages; i++) {
        [self createCurrentEmotioPage:i];
    }
}

//获取表情
- (NSMutableArray *)emojiContainer{
    
    if (!_emojiArray) {//1.png
        _emojiArray = [NSMutableArray array];
    }

    for (int i = 0; i < EMOJI_NUMBER; i++) {
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"emoji_%d",i + 1] ofType:@"png"];
        
        [_emojiArray addObject:imagePath];
    }
    return _emojiArray;
}

//创建当前页的表情视图
- (void)createCurrentEmotioPage:(int)page{

    UIView *currentPageView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width*page + 10, 0, self.frame.size.width - 20, self.frame.size.height - 35)];
    CGFloat emojiBtn_w = (self.frame.size.width - 60)/7.0f;
    CGFloat emojiBtn_h = (self.frame.size.width - 60)/7.0f;
    
    int emoji_row = 3;
    int emoji_col = 7;
    
    if (page == 5) {
        emoji_row = 1;
        emoji_col = 2;
    }
    
    for (int i = 0; i < emoji_row; i++) {
        for (int j = 0; j < emoji_col; j++) {
            UIButton *emojiBtn = [[UIButton alloc]initWithFrame:CGRectMake(j * (emojiBtn_w + 5) + 5, i * (emojiBtn_h - 5) , emojiBtn_w, emojiBtn_h)];
            //emojiBtn.backgroundColor = [UIColor redColor];
            emojiBtn.adjustsImageWhenHighlighted = NO;
            [emojiBtn addTarget:self action:@selector(emojiBtn:) forControlEvents:UIControlEventTouchUpInside];
            NSMutableString *string = _emojiArray[i * 7 + j + page * 21];
            emojiBtn.titleLabel.text = [[string componentsSeparatedByString:@"/"] lastObject];
        
            emojiBtn.tag = i * 7 + j + page * 21;
            [emojiBtn setImage:[[UIImage alloc]initWithContentsOfFile:_emojiArray[i * 7 + j + page * 21]] forState:UIControlStateNormal];
            
            [currentPageView addSubview:emojiBtn];
        }
    }
    //currentPageView.backgroundColor = [UIColor purpleColor];
    [self addSubview:currentPageView];
}

- (void)emojiBtn:(UIButton *)button{
    [self.emojiDelegate addEmotion:button.titleLabel.text];
}


-(void)createPageCtlWithTargetView:(UIView *)targetView{

    pageCtl = [[UIPageControl alloc]initWithFrame:CGRectMake(targetView.frame.origin.x, targetView.frame.size.height - 20, targetView.frame.size.width, 20)];
    
    pageCtl.pageIndicatorTintColor = [UIColor blackColor];
    pageCtl.currentPageIndicatorTintColor = [UIColor purpleColor];
    pageCtl.numberOfPages = 6;
    
    [targetView addSubview:pageCtl];
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    pageCtl.currentPage = self.contentOffset.x/self.frame.size.width;
}



@end
