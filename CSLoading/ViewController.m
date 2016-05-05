//
//  ViewController.m
//  CSLoading
//
//  Created by e3mo on 16/5/5.
//  Copyright © 2016年 e3mo. All rights reserved.
//

#import "ViewController.h"
#import "LoadingViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(20, 50, 100, 40)];
    [btn setTitle:@"全屏loading" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(fullLoading) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setFrame:CGRectMake(20, 120, 100, 40)];
    [btn1 setTitle:@"小屏loading" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 setBackgroundColor:[UIColor redColor]];
    [btn1 addTarget:self action:@selector(smallLoading) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setFrame:CGRectMake(20, 210, 100, 40)];
    [btn2 setTitle:@"提示消息" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 setBackgroundColor:[UIColor redColor]];
    [btn2 addTarget:self action:@selector(delayTips) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)hideLoading {
    [[LoadingViewController sharedViewController] hideLoading];
}

- (void)fullLoading {
    [[LoadingViewController sharedViewController] showFullLoadingWithText:@"全屏loading..." view:nil];
    
    [self performSelector:@selector(hideLoading) withObject:nil afterDelay:3.f];
}

- (void)smallLoading {
    CGSize winsize = [[UIScreen mainScreen] bounds].size;
    [[LoadingViewController sharedViewController] showSmallLoadingWithCenter:CGPointMake(winsize.width/2, winsize.height/2) text:@"小屏loading...\n提示消息，根据设定时间自动消失" view:self.view];
    
    [self performSelector:@selector(hideLoading) withObject:nil afterDelay:3.f];
}

- (void)delayTips {
    [[LoadingViewController sharedViewController] showDelayTipsWithCenter:CGPointZero text:@"提示消息，根据设定时间自动消失" view:self.view delay:3.f];
}

@end
