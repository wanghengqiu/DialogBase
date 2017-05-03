//
//  TestDialog.m
//  DialogBaseDemo
//
//  Created by 王恒求 on 2015/7/4.
//  Copyright © 2015年 王恒求. All rights reserved.
//

#import "TestDialog.h"

@implementation TestDialog

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame superView:nil];
    
    if (self) {
        self.backgroundColor =[UIColor whiteColor];
        UILabel *testLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, frame.size.width-20, 30)];
        testLabel.text = @"这是一个测试dialog";
        [self addSubview:testLabel];
        
        UIButton *testBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, frame.size.height-50, frame.size.width-40, 40)];
        testBtn.backgroundColor=[UIColor redColor];
        [testBtn setTitle:@"点我关闭" forState:UIControlStateNormal];
        [self addSubview:testBtn];
        [testBtn addTarget:self action:@selector(testBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

-(void)testBtnClicked
{
    [self dismiss];
}

@end
