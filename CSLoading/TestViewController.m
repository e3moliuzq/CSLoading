//
//  TestViewController.m
//  CSLoading
//
//  Created by e3mo on 2017/5/5.
//  Copyright © 2017年 e3mo. All rights reserved.
//

#import "TestViewController.h"
#import "LoadingViewController.h"
#import "CSNavigationViewController.h"

@interface TestViewController () {
    
    int pro_index;
    int navi_pro_index;
}

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"导航栏";
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(rightAction)];
    right.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *right1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(rightAction)];
    right1.tintColor = [UIColor whiteColor];
    UIBarButtonItem *right2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(rightAction)];
    right2.tintColor = [UIColor whiteColor];
    UIBarButtonItem *right3 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(rightAction)];
    right3.tintColor = [UIColor whiteColor];
    
    
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects: right, right1, right2, right3, nil]];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(20, 20, 140, 40)];
    [btn setTitle:@"全屏loading" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(fullLoading) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setFrame:CGRectMake(20, 80, 140, 40)];
    [btn1 setTitle:@"小屏loading" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 setBackgroundColor:[UIColor redColor]];
    [btn1 addTarget:self action:@selector(smallLoading) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setFrame:CGRectMake(20, 140, 140, 40)];
    [btn2 setTitle:@"提示消息" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 setBackgroundColor:[UIColor redColor]];
    [btn2 addTarget:self action:@selector(delayTips) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 setFrame:CGRectMake(20, 200, 140, 40)];
    [btn3 setTitle:@"进度条loading" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn3 setBackgroundColor:[UIColor redColor]];
    [btn3 addTarget:self action:@selector(progressLoading) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn4 setFrame:CGRectMake(20, 260, 140, 40)];
    [btn4 setTitle:@"navi消息提示" forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn4 setBackgroundColor:[UIColor redColor]];
    [btn4 addTarget:self action:@selector(naviTips) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    
    btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn4 setFrame:CGRectMake(20, 320, 140, 40)];
    [btn4 setTitle:@"navi消息提示0" forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn4 setBackgroundColor:[UIColor redColor]];
    [btn4 addTarget:self action:@selector(naviStyleTips:) forControlEvents:UIControlEventTouchUpInside];
    btn4.tag = 0;
    [self.view addSubview:btn4];
    
    btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn4 setFrame:CGRectMake(20, 380, 140, 40)];
    [btn4 setTitle:@"navi消息提示1" forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn4 setBackgroundColor:[UIColor redColor]];
    [btn4 addTarget:self action:@selector(naviStyleTips:) forControlEvents:UIControlEventTouchUpInside];
    btn4.tag = 1;
    [self.view addSubview:btn4];
    
    btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn4 setFrame:CGRectMake(20, 440, 140, 40)];
    [btn4 setTitle:@"navi消息提示2" forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn4 setBackgroundColor:[UIColor redColor]];
    [btn4 addTarget:self action:@selector(naviStyleTips:) forControlEvents:UIControlEventTouchUpInside];
    btn4.tag = 2;
    [self.view addSubview:btn4];
    
    btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn4 setFrame:CGRectMake(20, 500, 140, 40)];
    [btn4 setTitle:@"navi hide loading" forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn4 setBackgroundColor:[UIColor redColor]];
    [btn4 addTarget:self action:@selector(naviTitleLoading) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    
    btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn4 setFrame:CGRectMake(20, 560, 140, 40)];
    [btn4 setTitle:@"navi进度条" forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn4 setBackgroundColor:[UIColor redColor]];
    [btn4 addTarget:self action:@selector(naviProgressLoading) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    
    btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn4 setFrame:CGRectMake(20+160, 560, 140, 40)];
    [btn4 setTitle:@"navi title loading" forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn4 setBackgroundColor:[UIColor redColor]];
    [btn4 addTarget:self action:@selector(naviLoading) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightAction {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"测试" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)naviTips {
    CSNavigationViewController *navi = (CSNavigationViewController*)self.navigationController;
    [navi showDelayTipsWithText:@"Navi消息提示" image:[UIImage imageNamed:@"Cancel.png"] tipsBgColor:nil textColor:nil delay:2.f];
}

- (void)naviStyleTips:(UIButton*)btn {
    CSNavigationViewController *navi = (CSNavigationViewController*)self.navigationController;
    [navi showDelayTipsWithStyle:(int)btn.tag text:[NSString stringWithFormat:@"默认Navi类型%d",(int)btn.tag] delay:2.f];
}

- (void)naviLoading {
    CSNavigationViewController *navi = (CSNavigationViewController*)self.navigationController;
    [navi showTitleLoadingWithPosX:130 activityIndicatorColor:[UIColor whiteColor]];
    
    [self performSelector:@selector(hideNaviLoading) withObject:nil afterDelay:1.5];
}

- (void)naviTitleLoading {
    CSNavigationViewController *navi = (CSNavigationViewController*)self.navigationController;
    [navi showTitleHideLoadingWithText:@"加载中..." textColor:nil activityIndicatorColor:nil];
    
    [self performSelector:@selector(hideNaviLoading) withObject:nil afterDelay:1.5];
}

- (void)hideNaviLoading {
    CSNavigationViewController *navi = (CSNavigationViewController*)self.navigationController;
    [navi endLoading];
}

- (void)naviProgressLoading {
    CSNavigationViewController *navi = (CSNavigationViewController*)self.navigationController;
    [navi showProgressLoadingWithBgColor:nil progressColor:[UIColor greenColor]];
    
    navi_pro_index = 0;
    
    [self performSelector:@selector(naviProIndexAdd) withObject:nil afterDelay:0.1];
}

- (void)naviProIndexAdd {
    if (navi_pro_index >= 330) {
        [self hideNaviLoading];
        return;
    }
    CSNavigationViewController *navi = (CSNavigationViewController*)self.navigationController;
    
    navi_pro_index += arc4random()%100+1;
    if (navi_pro_index > 330) {
        navi_pro_index = 330;
    }
    [navi changeProogressPercent:(float)navi_pro_index/330.f];
    
    [self performSelector:@selector(naviProIndexAdd) withObject:nil afterDelay:1.f];
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
    [[LoadingViewController sharedViewController] showSmallLoadingWithCenter:CGPointMake(winsize.width/2, winsize.height/2) text:@"小屏loading..." view:self.view];
    
    [self performSelector:@selector(hideLoading) withObject:nil afterDelay:3.f];
}

- (void)delayTips {
    [[LoadingViewController sharedViewController] showDelayTipsWithCenter:CGPointZero text:@"提示消息，根据设定时间自动消失" view:self.view delay:3.f];
}

- (void)progressLoading {
    [[LoadingViewController sharedViewController] showProgressLoadingWithMode:0 text:@"检查更新中..." view:self.view count:330];
    pro_index = 0;
    
    [self performSelector:@selector(proIndexAdd) withObject:nil afterDelay:0.1];
}

- (void)proIndexAdd {
    if (pro_index >= 330) {
        [self hideLoading];
        return;
    }
    
    pro_index += arc4random()%50+1;
    if (pro_index >= 66 && pro_index < 145) {
        [[LoadingViewController sharedViewController] changeProgressLoadingIndex:pro_index text:@"加载网络文件中..."];
    }
    else if (pro_index >= 145 && pro_index < 220) {
        [[LoadingViewController sharedViewController] changeProgressLoadingIndex:pro_index text:@"加载网络图片中..."];
    }
    else if (pro_index >= 220 && pro_index < 300) {
        [[LoadingViewController sharedViewController] changeProgressLoadingIndex:pro_index text:@"加载本地文件中..."];
    }
    else if (pro_index >= 300) {
        if (pro_index > 330) {
            pro_index = 330;
        }
        [[LoadingViewController sharedViewController] changeProgressLoadingIndex:pro_index text:@"即将完成..."];
    }
    else {
        [[LoadingViewController sharedViewController] changeProgressLoadingIndex:pro_index text:nil];
    }
    
    [self performSelector:@selector(proIndexAdd) withObject:nil afterDelay:0.5];
}

@end
