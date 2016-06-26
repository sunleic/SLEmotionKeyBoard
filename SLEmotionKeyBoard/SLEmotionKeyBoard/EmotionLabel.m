//
//  EmotionLabel.m
//  SLEmotionKeyBoard
//
//  Created by 孙磊 on 16/6/6.
//  Copyright © 2016年 孙磊. All rights reserved.
//

#import "EmotionLabel.h"

@implementation EmotionLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        
//    }
//    return self;
//}

-(void)setEmotionText:(NSString *)emotionText{

    [self emotionTextWithText:emotionText];
}

-(void)emotionTextWithText:(NSString *)string{
    
    NSString *regex = @"\\[[^\\]]+\\]";

    NSError *error;
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:&error];
    // 对str字符串进行匹配
    NSArray *matches = [regular matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    if (matches.count == 0) {
        self.text = string;
        return;
    }
    
    
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:string];
    
    for (int i = (int)matches.count - 1; i >= 0; i--) {
        
        NSTextCheckingResult *resultTmp = [matches objectAtIndex:i];
        //富文本
        NSTextAttachment *attachment = [NSTextAttachment new];
        attachment.bounds = CGRectMake(0, 0, 20, 20);
        attachment.image = [UIImage imageNamed:[string substringWithRange:NSMakeRange(resultTmp.range.location + 1, resultTmp.range.length - 2)]];
//        NSLog(@"测单----%@",[string substringWithRange:NSMakeRange(resultTmp.range.location + 1, resultTmp.range.length - 2)]);
        //表情的属性字符串
        NSAttributedString *emojiAttributedString = [NSAttributedString attributedStringWithAttachment:attachment];
        [attributeStr replaceCharactersInRange:[[matches objectAtIndex:i] range] withAttributedString:emojiAttributedString];
        
        self.attributedText = attributeStr;
    }
    
}

@end
