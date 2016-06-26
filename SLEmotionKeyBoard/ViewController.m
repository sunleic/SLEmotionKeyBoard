//
//  ViewController.m
//  SLEmotionKeyBoard
//
//  Created by 孙磊 on 16/4/20.
//  Copyright © 2016年 孙磊. All rights reserved.
//

#import "ViewController.h"
#import "SLKeyboardView.h"
#import "EmotionLabel.h"

@interface ViewController ()<SLKeyboardViewDelegate>

@property (nonatomic, strong) SLKeyboardView *keyboardView;

@end

@implementation ViewController{

    EmotionLabel *lbl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 40)];
    
    [btn setImage:[UIImage imageNamed:@"emoji_1"] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    _keyboardView = [[SLKeyboardView alloc]initWithTargetView:self.view];
    _keyboardView.delegate = self;
    
    lbl = [[EmotionLabel alloc]initWithFrame:CGRectMake(10, 150, self.view.frame.size.width, 100)];
    lbl.numberOfLines = 0;

    [self.view addSubview:lbl];
}

#pragma mark - SLKeyboardViewDelegate

-(void)returnTextStr:(NSString *)str{

    lbl.emotionText = str;

//    NSLog(@"哈哈哈哈哈+++%@",[NSString stringWithFormat:@"%@",str]);
}

-(void)resizeTextView:(NSInteger)dValue{
    
//    CGRect frame = _keyboardView.frame;
//    
//    frame.origin.y -= dValue;
//    frame.size.height += dValue;
//    
//    _keyboardView.frame = frame;
}







- (void)btnClick{
//    NSLog(@"**********");
    [_keyboardView.textView becomeFirstResponder];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
