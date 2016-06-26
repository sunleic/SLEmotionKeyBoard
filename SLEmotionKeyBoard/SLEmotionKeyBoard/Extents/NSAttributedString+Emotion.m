//
//  NSAttributedString+Emotion.m
//  SLEmotionKeyBoard
//
//  Created by 孙磊 on 16/6/7.
//  Copyright © 2016年 孙磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSAttributedString+Emotion.h"
#import "EmotionTextAttachment.h"

@implementation NSAttributedString (Emotion)

- (NSString *)getPlainString {
    
    NSMutableString *plainString = [NSMutableString stringWithString:self.string];
    __block NSUInteger base = 0;
    
    [self enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.length)
                     options:0
                  usingBlock:^(id value, NSRange range, BOOL *stop) {
//                      NSLog(@"+++++%lu___%lu",range.location,range.length);
                      if (value && [value isKindOfClass:[EmotionTextAttachment class]]) {
                          [plainString replaceCharactersInRange:NSMakeRange(range.location + base, range.length)
                                                     withString:((EmotionTextAttachment *) value).emotionTag];
                          base += ((EmotionTextAttachment *) value).emotionTag.length - 1;
                      }
                  }];
    
    return plainString;
}
@end






























