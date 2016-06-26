//
//  SLKeyboardView.h
//  SLEmotionKeyBoard
//
//  Created by 孙磊 on 16/4/20.
//  Copyright © 2016年 孙磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SLKeyboardViewDelegate <NSObject>

//返回转化好的字符串，不带表情的
-(void)returnTextStr:(NSString *)str;

@end

@interface SLKeyboardView : UIView

@property (nonatomic, assign) id<SLKeyboardViewDelegate> delegate;

@property (nonatomic, strong) UITextView  *textView;

//subView有textView 和 表情button
@property (nonatomic, strong) UIView  *textViewBG;


//创建表情键盘
- (instancetype)initWithTargetView:(UIView *)targetView;


@end
