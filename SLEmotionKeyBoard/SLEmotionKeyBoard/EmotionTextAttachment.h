//
//  EmotionTextAttachment.h
//  SLEmotionKeyBoard
//
//  Created by 孙磊 on 16/6/7.
//  Copyright © 2016年 孙磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmotionTextAttachment : NSTextAttachment

//将表情的的名字外加中括号作为该attachment的tag，以便实现表情和文字的一一映射，如 [123.jpg]
@property(strong, nonatomic) NSString *emotionTag;

@end
