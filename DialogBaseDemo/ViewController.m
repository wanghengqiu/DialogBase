//
//  ViewController.m
//  DialogBaseDemo
//
//  Created by 王恒求 on 2015/7/4.
//  Copyright © 2015年 王恒求. All rights reserved.
//

#import "ViewController.h"
#import "TestDialog.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor =[UIColor whiteColor];
    
    UIButton *testBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 100, self.view.frame.size.width-20, 45)];
    testBtn.backgroundColor=[UIColor redColor];
    [testBtn setTitle:@"点我查看测试dialog" forState:UIControlStateNormal];
    [self.view addSubview:testBtn];
    [testBtn addTarget:self action:@selector(testBtnClicked) forControlEvents:UIControlEventTouchUpInside];
}


-(void)testBtnClicked
{
    TestDialog *dialog = [[TestDialog alloc]initWithFrame:CGRectMake(0, 0, [TestDialog defaultDialogViewWidth], 150)];
    [dialog show];
}


@end
