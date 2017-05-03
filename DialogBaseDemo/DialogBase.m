//
//  DialogBase.m
//  DialogBaseDemo
//
//  Created by 王恒求 on 2015/7/4.
//  Copyright © 2015年 王恒求. All rights reserved.
//

#import "DialogBase.h"

@implementation DialogBase

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame superView:nil];
}

-(id)initWithFrame:(CGRect)frame superView:(UIView*)superView
{
    
    if (superView==nil) {
        superView = [UIApplication sharedApplication].keyWindow;
    }
    
    CGRect superRect = superView.bounds;
    
    if (self = [super initWithFrame:frame]) {
        self.needAutoDismissWhenClickBackground = YES;
        [self regiseterNotification];
        self.center = CGPointMake(superRect.size.width/2, superRect.size.height/2);
        self.layer.cornerRadius=8;
        
        _backgroundView = [[UIView alloc]initWithFrame:superView.bounds];
        _backgroundView.backgroundColor =[UIColor colorWithWhite:0 alpha:0.5];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBackkgroundMaskViewDidClick:)];
        [_backgroundView addGestureRecognizer:tap];
        
        _superView = superView;
    }
    
    return self;
}

- (void)onBackkgroundMaskViewDidClick:(id)sender
{
    if ([self needAutoDismissWhenClickBackground]) {
        [self dismiss];
    }
}

- (void)dealloc
{
#ifdef DEBUG
    NSLog(@"%@ dialog dealloc", NSStringFromClass(self.class));
#endif
    [self resignNotification];
}

+ (CGFloat)defaultDialogViewWidth
{
    return 290;
}

#pragma mark 
-(void)show
{
    [_superView addSubview:_backgroundView];
    [_superView addSubview:self];
    
    _backgroundView.alpha=0.1;
    CGFloat animateTime = 0.2;
    [UIView animateWithDuration:animateTime animations:^{
        _backgroundView.alpha=0.5;
    }];
    
    self.alpha=0.1;
    [UIView animateWithDuration:animateTime animations:^{
        self.alpha=1;
    }];
    
    self.transform = CGAffineTransformMakeScale(1.2, 1.2);
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.transform=CGAffineTransformIdentity;
    } completion:nil];
}

-(void)dismiss
{
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformMakeScale(0.7, 0.7);
        self.alpha = 0.0;
        _backgroundView.alpha = 0.2;
    } completion:^(BOOL finished) {
        self.transform = CGAffineTransformIdentity;
        [self removeFromSuperview];
        [_backgroundView removeFromSuperview];
    }];
}


#pragma mark 处理键盘通知
/** 注册键盘通知，防止键盘挡住对话框*/
- (void)regiseterNotification
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(onKeyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(onKeyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

/** 撤销通知*/
- (void)resignNotification
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [center removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)onKeyBoardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    CGFloat duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect keyBoardRect;
    NSValue *rectValue = [[notification userInfo] objectForKey:@"UIKeyboardBoundsUserInfoKey"];
    [rectValue getValue:&keyBoardRect];
    
    CGRect rect = self.superview.bounds;
    CGFloat offset = 20;
    rect.size.height -= keyBoardRect.size.height - offset;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    self.center = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    [UIView commitAnimations];
}

- (void)onKeyBoardWillHide:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    CGFloat duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    CGRect rect = self.superview.bounds;
    self.center = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    [UIView commitAnimations];
}


@end
