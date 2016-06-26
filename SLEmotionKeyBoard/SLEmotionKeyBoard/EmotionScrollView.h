//
//  EmotionScrollView.h
//  SLEmotionKeyBoard
//
//  Created by 孙磊 on 16/4/20.
//  Copyright © 2016年 孙磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLKeyboardView;

@protocol EmotionScrollDelegate <NSObject>

- (void)addEmotion:(NSString *)imageName;
//- (void)deleteEmotion;

@end

@interface EmotionScrollView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic, assign) id<EmotionScrollDelegate>emojiDelegate;

-(instancetype)initOnTargetView:(SLKeyboardView *)targetView;

@end
