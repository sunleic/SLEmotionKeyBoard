//
//  SLKeyboardView.m
//  SLEmotionKeyBoard
//
//  Created by 孙磊 on 16/4/20.
//  Copyright © 2016年 孙磊. All rights reserved.
//

#import "SLKeyboardView.h"
#import "EmotionScrollView.h"
#import "EmotionTextAttachment.h"
#import "NSAttributedString+Emotion.h"

@interface SLKeyboardView ()<EmotionScrollDelegate,UITextViewDelegate>

//标示文本框的text，文本框用富文本显示
@property (nonatomic, strong) NSMutableString *textStr;

@end

@implementation SLKeyboardView{
    
    NSInteger _fontSize;
    
    UIView    *_targetView;
    UIButton  *_emotionBtn;
    
    EmotionScrollView *_emotionScrollView;
    
    CGFloat  _keyboardHeight;  //键盘升起高度
    double   _keyBoardTime;    //键盘升降时间
    
    NSMutableAttributedString *_attributeString;
}

- (instancetype)initWithTargetView:(UIView *)targetView{
    
    self = [super initWithFrame:CGRectMake(0, targetView.frame.size.height, targetView.frame.size.width, 200)];
    if (self) {
        _targetView = targetView;
        //键盘监听
        [self keyBoarNotify];
        [targetView addSubview:self];
        [self createTextViewWithFrame:self.frame];
        
        _attributeString = [[NSMutableAttributedString alloc]init];

        _fontSize = 15;
    }
    return self;
}

//创建输入框背景、输入框、表情按钮、发送按钮
- (void)createTextViewWithFrame:(CGRect)frame{

    _textViewBG = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 45)];
    _textViewBG.clipsToBounds = YES;
    _textViewBG.backgroundColor = [UIColor colorWithRed:230/255.0f green:233/255.0f blue:239/255.0f alpha:1.0f];
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(5, 5, _textViewBG.frame.size.width - 50, _textViewBG.frame.size.height - 10)];
    _textView.returnKeyType = UIReturnKeySend;
    _textView.font = [UIFont systemFontOfSize:_fontSize];
    _textView.layer.cornerRadius = 5;
    _textView.layer.masksToBounds = YES;
    _textView.delegate = self;
    
    _emotionBtn = [[UIButton alloc]initWithFrame:CGRectMake(_textViewBG.frame.size.width - 40, (_textViewBG.frame.size.height - 30)/2, 30, 30)];
    [_emotionBtn setImage:[UIImage imageNamed:@"emotion"] forState:UIControlStateNormal];
    [_emotionBtn addTarget:self action:@selector(emotionBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [_textViewBG addSubview:_textView];
    [_textViewBG addSubview:_emotionBtn];
    
    [self addSubview:_textViewBG];
    
}

- (void)emotionBtn:(UIButton *)button{
    
    if (_textView.isFirstResponder) {
        [_textView resignFirstResponder];
        [_emotionBtn setImage:[UIImage imageNamed:@"keboard"] forState:UIControlStateNormal];
       
        _emotionScrollView = [[EmotionScrollView alloc]initOnTargetView:self];
        _emotionScrollView.emojiDelegate = self;
        
        [UIView animateWithDuration:0.35 animations:^{
            self.transform = CGAffineTransformMakeTranslation(0, -210);
        } completion:nil];
        
    }else{
        [_emotionBtn setImage:[UIImage imageNamed:@"emotion"] forState:UIControlStateNormal];
        [_textView becomeFirstResponder];
        [_emotionScrollView removeFromSuperview];
        _emotionScrollView = nil;
    }
}

#pragma mark -键盘监听
- (void)keyBoarNotify{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)KeyboardWillShow:(NSNotification *)sender {
    
    CGRect rect = [[sender.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _keyboardHeight = rect.size.height;
    _keyBoardTime = [[sender.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    
    [UIView animateWithDuration:_keyBoardTime animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, -_keyboardHeight - self.textViewBG.frame.size.height);
        
    } completion:nil];
}

- (void)KeyboardWillHide:(NSNotification *)sender{
    
    [UIView animateWithDuration:_keyBoardTime animations:^{

        self.transform = CGAffineTransformIdentity;//重置状态
        
    } completion:nil];
}

#pragma mark - EmotionScrollDelegate

- (void)addEmotion:(NSString *)imageName{
    //富文本
    EmotionTextAttachment *attachment = [EmotionTextAttachment new];
    
    attachment.bounds = CGRectMake(0, 0,_fontSize,_fontSize);// _textView.font.lineHeight, _textView.font.lineHeight);
    attachment.image = [UIImage imageNamed:imageName];
    attachment.emotionTag = [NSString stringWithFormat:@"[%@]",imageName];
    
    NSAttributedString *emojiAttributedString = [NSAttributedString attributedStringWithAttachment:attachment];
    
    NSMutableAttributedString *mutableAttributeString = [[NSMutableAttributedString alloc] initWithAttributedString:_textView.attributedText];
    [mutableAttributeString replaceCharactersInRange:_textView.selectedRange withAttributedString:emojiAttributedString];
    
    _textView.attributedText = mutableAttributeString;

    //刷新文本框
    [_textView insertText:@""];
    
    _textView.font = [UIFont systemFontOfSize:_fontSize];
    
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        [self.delegate returnTextStr:[_textView.attributedText getPlainString]];
        
        _textView.attributedText = nil;
        
        return NO;
    }
    return YES;
}

@end
