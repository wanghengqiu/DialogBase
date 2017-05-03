//
//  DialogBase.h
//  DialogBaseDemo
//
//  Created by 王恒求 on 2015/7/4.
//  Copyright © 2015年 王恒求. All rights reserved.
//  Description:
//      DialogBase是一个弹框视图，它是一个基类，不建议直接使用

#import <UIKit/UIKit.h>

@interface DialogBase : UIView {
@protected
    UIView *_backgroundView;
    __weak UIView *_superView;
}

/** 是否支持点击背景图隐藏对话框，默认是yes*/
@property (nonatomic, assign) BOOL needAutoDismissWhenClickBackground;

+(CGFloat)defaultDialogViewWidth;


/**
 * @Description:
 *      初始化
 * @Parameters:
 *      @param frame 弹框的大小
 *      @param superView 弹框的父视图
 */
- (id)initWithFrame:(CGRect)frame superView:(UIView *)superView;

/**
 * @Description:
 *      初始化
 * @Parameters:
 *      @param frame 弹框的大小
 *      此时的父视图是keywindow
 */
- (id)initWithFrame:(CGRect)frame;

#pragma mark -

/**
 * @Description:
 *      显示弹框
 */
- (void)show;

/**
 * @Description:
 *      弹框消失
 */
- (void)dismiss;

@end
