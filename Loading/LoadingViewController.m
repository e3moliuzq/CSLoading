//
//  LoadingViewController.m
//
//
//  Created by e3mo on 16/5/5.
//  Copyright (c) 2016年 e3mo. All rights reserved.
//

#import "LoadingViewController.h"
#import "AppDelegate.h"
#import "DefineKey.h"

@interface LoadingViewController ()

@end

@implementation LoadingViewController
static LoadingViewController *_sharedViewController = nil;

+ (LoadingViewController *)sharedViewController
{
    if (_sharedViewController == nil) {
        _sharedViewController = [[LoadingViewController alloc] init];
    }
    
    return _sharedViewController;
}

#pragma mark - UIView
- (id)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        delay_count = 0;
    }
    
    return self;
}


- (void)showSmallLoadingWithCenter:(CGPoint)center text:(NSString *)text view:(UIView*)view {
    [self hideLoading];
    
    small_loading_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, SYS_UI_SCALE_WIDTH_SIZE(25))];
    [small_loading_view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
    //不能和加阴影同时使用
    small_loading_view.layer.masksToBounds = YES;
    small_loading_view.layer.cornerRadius = 5;//如果圆角为一半，则可以截成圆形
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SYS_UI_SCALE_WIDTH_SIZE(10), SYS_UI_SCALE_WIDTH_SIZE(5), 0, SYS_UI_SCALE_WIDTH_SIZE(15))];
    [label setText:text];
    [label setTextColor:[UIColor whiteColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:SYS_UI_SCALE_WIDTH_SIZE(12)]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label sizeToFit];
    [small_loading_view addSubview:label];
    
    small_loading_view.frame = CGRectMake(0, 0, label.frame.size.width+SYS_UI_SCALE_WIDTH_SIZE(20), SYS_UI_SCALE_WIDTH_SIZE(25));
    if (center.x > 0 && center.y > 0) {
        [small_loading_view setCenter:center];
    }
    else {
        if (view) {
            [small_loading_view setCenter:CGPointMake(view.frame.size.width/2, 5*view.frame.size.height/6)];
        }
        else {
            CGSize winsize = [[UIScreen mainScreen] bounds].size;
            if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
                [small_loading_view setCenter:CGPointMake(winsize.width/2, 5*winsize.height/6)];
            }
            else {
                [small_loading_view setCenter:CGPointMake(winsize.width/2, 5*(winsize.height-64)/6)];
            }
        }
    }
    
    if (view) {
        [view addSubview:small_loading_view];
    }
    else {
        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [[app window] addSubview:small_loading_view];
    }
}

- (void)hideSmallLoading {
    if (small_loading_view) {
        [small_loading_view removeFromSuperview];
        small_loading_view = nil;
    }
}

- (void)showFullLoadingWithText:(NSString *)text view:(UIView*)view {
    [self showFullLoadingWithText:text view:view alpha:0.2];
}

- (void)showFullLoadingWithText:(NSString *)text view:(UIView*)view alpha:(float)alpha {
    [self hideLoading];
    
    CGSize winsize = [[UIScreen mainScreen] bounds].size;
    full_loading_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, winsize.width, winsize.height)];
    if (view) {
        full_loading_view.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
    }
    [full_loading_view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:alpha]];
    
    UIView *base_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SYS_UI_SCALE_WIDTH_SIZE(100), SYS_UI_SCALE_WIDTH_SIZE(100))];
    [base_view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
    //不能和加阴影同时使用
    base_view.layer.masksToBounds = YES;
    base_view.layer.cornerRadius = SYS_UI_SCALE_WIDTH_SIZE(10);//如果圆角为一半，则可以截成圆形
    [base_view setCenter:CGPointMake(full_loading_view.frame.size.width/2, full_loading_view.frame.size.height/2)];
    [full_loading_view addSubview:base_view];
    
    
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] init];
    [activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activityIndicatorView setHidesWhenStopped:YES];//自动隐藏，YES的情况下如果stop时自动hidden
    [activityIndicatorView setColor:[UIColor whiteColor]];//设置小菊花的颜色
    [activityIndicatorView setCenter:CGPointMake(base_view.frame.size.width/2, base_view.frame.size.height/2-SYS_UI_SCALE_WIDTH_SIZE(10))];//大小设置无效，只能设置位置
    [activityIndicatorView startAnimating];
    [base_view addSubview:activityIndicatorView];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, SYS_UI_SCALE_WIDTH_SIZE(20))];
    [label setText:text];
    [label setTextColor:[UIColor whiteColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:SYS_UI_SCALE_WIDTH_SIZE(12)]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label sizeToFit];
    [label setCenter:CGPointMake(base_view.frame.size.width/2, base_view.frame.size.height-SYS_UI_SCALE_WIDTH_SIZE(20))];
    [base_view addSubview:label];
    
    if (view) {
        [view addSubview:full_loading_view];
    }
    else {
        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [[app window] addSubview:full_loading_view];
    }
}

- (void)hideFullLoading {
    if (full_loading_view) {
        [full_loading_view removeFromSuperview];
        full_loading_view = nil;
    }
}

- (void)showProgressLoadingWithMode:(int)mode text:(NSString*)text view:(UIView*)view count:(int)count {
    [self hideLoading];
    
    progress_mode = mode;
    progress_count = count;
    if (progress_count < 0) {
        progress_count = 0;
    }
    
    CGSize winsize = [[UIScreen mainScreen] bounds].size;
    progress_loading_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, winsize.width, winsize.height)];
    if (view) {
        progress_loading_view.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
    }
    [progress_loading_view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]];
    
    
    float base_height = SYS_UI_SCALE_WIDTH_SIZE(105);
    if (progress_mode == 2) {
        base_height -= SYS_UI_SCALE_WIDTH_SIZE(25);
    }
    UIView *base_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, progress_loading_view.frame.size.width/3*2, base_height)];
    [base_view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
    //不能和加阴影同时使用
    base_view.layer.masksToBounds = YES;
    base_view.layer.cornerRadius = SYS_UI_SCALE_WIDTH_SIZE(10);//如果圆角为一半，则可以截成圆形
    [base_view setCenter:CGPointMake(progress_loading_view.frame.size.width/2, progress_loading_view.frame.size.height/2)];
    base_view.tag = 999;
    [progress_loading_view addSubview:base_view];
    
    UILabel *title_label = [[UILabel alloc] initWithFrame:CGRectMake(0, SYS_UI_SCALE_WIDTH_SIZE(15), base_view.frame.size.width, SYS_UI_SCALE_WIDTH_SIZE(20))];
    [title_label setText:text];
    [title_label setTextColor:[UIColor whiteColor]];
    [title_label setTextAlignment:NSTextAlignmentCenter];
    [title_label setFont:[UIFont boldSystemFontOfSize:SYS_UI_SCALE_WIDTH_SIZE(15)]];
    [title_label setBackgroundColor:[UIColor clearColor]];
    title_label.tag = 1000;
    [base_view addSubview:title_label];
    
    if (mode != 2) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, SYS_UI_SCALE_WIDTH_SIZE(45), base_view.frame.size.width, SYS_UI_SCALE_WIDTH_SIZE(20))];
        if (mode == 1) {
            if (progress_count == 0) {
                [label setText:@"100 %"];
            }
            else {
                [label setText:@"0 %"];
            }
        }
        else {
            [label setText:[NSString stringWithFormat:@"0 / %d",count]];
        }
        [label setTextColor:[UIColor whiteColor]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setFont:[UIFont systemFontOfSize:SYS_UI_SCALE_WIDTH_SIZE(14)]];
        [label setBackgroundColor:[UIColor clearColor]];
        label.tag = 1001;
        [base_view addSubview:label];
    }
    
    UIProgressView *pro_view = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    CGRect frame = pro_view.frame;
    frame.size.width = base_view.frame.size.width/5*4;
    pro_view.frame = frame;
    [pro_view setCenter:CGPointMake(base_view.frame.size.width/2, base_view.frame.size.height-SYS_UI_SCALE_WIDTH_SIZE(25))];
    if (progress_count == 0) {
        pro_view.progress = 1;
    }
    else {
        pro_view.progress = 0;
    }
    pro_view.progressTintColor = [UIColor greenColor];
    pro_view.trackTintColor = [UIColor grayColor];
    pro_view.tag = 1002;
    [base_view addSubview:pro_view];
    
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 3.0f);
    pro_view.transform = transform;
    //不能和加阴影同时使用
    pro_view.layer.masksToBounds = YES;
    pro_view.layer.cornerRadius = 3.f;//如果圆角为一半，则可以截成圆形
    
    
    if (view) {
        [view addSubview:progress_loading_view];
    }
    else {
        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [[app window] addSubview:progress_loading_view];
    }
}

- (void)changeProgressLoadingIndex:(int)index text:(NSString *)text {
    if (progress_loading_view) {
        UIView *base_view = (UIView*)[progress_loading_view viewWithTag:999];
        
        if (text && text.length > 0) {
            UILabel *title_label = (UILabel*)[base_view viewWithTag:1000];
            [title_label setText:text];
        }
        
        if (index >= 0) {
            UIProgressView *pro_view = (UIProgressView*)[base_view viewWithTag:1002];
            if (index >= progress_count) {
                index = progress_count;
            }
            
            float percent = (float)index/(float)progress_count;
            [pro_view setProgress:percent animated:YES];
            
            if (progress_mode != 2) {
                UILabel *label = (UILabel*)[base_view viewWithTag:1001];
                if (progress_mode == 1) {
                    [label setText:[NSString stringWithFormat:@"%.2f %%",percent*100.f]];
                }
                else {
                    [label setText:[NSString stringWithFormat:@"%d / %d",index,progress_count]];
                }
            }
        }
    }
}

- (void)hideProgressLoading {
    if (progress_loading_view) {
        [progress_loading_view removeFromSuperview];
        progress_loading_view = nil;
    }
}

- (void)hideLoading {
    [self hideSmallLoading];
    [self hideFullLoading];
    [self hideDelayTips];
    [self hideProgressLoading];
}

- (void)showDelayTipsWithCenter:(CGPoint)center text:(NSString *)text view:(UIView *)view delay:(float)delay {
    [self hideLoading];
    
    delay_tips_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, SYS_UI_SCALE_WIDTH_SIZE(25))];
    [delay_tips_view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
    delay_tips_view.tag = delay_count;
    //不能和加阴影同时使用
    delay_tips_view.layer.masksToBounds = YES;
    delay_tips_view.layer.cornerRadius = 5;//如果圆角为一半，则可以截成圆形
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SYS_UI_SCALE_WIDTH_SIZE(10), SYS_UI_SCALE_WIDTH_SIZE(5), 0, SYS_UI_SCALE_WIDTH_SIZE(15))];
    [label setText:text];
    [label setTextColor:[UIColor whiteColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:SYS_UI_SCALE_WIDTH_SIZE(12)]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label sizeToFit];
    [delay_tips_view addSubview:label];
    
    delay_tips_view.frame = CGRectMake(0, 0, label.frame.size.width+SYS_UI_SCALE_WIDTH_SIZE(20), SYS_UI_SCALE_WIDTH_SIZE(25));
    if (center.x > 0 && center.y > 0) {
        [delay_tips_view setCenter:center];
    }
    else {
        if (view) {
            [delay_tips_view setCenter:CGPointMake(view.frame.size.width/2, 5*view.frame.size.height/6)];
        }
        else {
            CGSize winsize = [[UIScreen mainScreen] bounds].size;
            if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
                [delay_tips_view setCenter:CGPointMake(winsize.width/2, 5*winsize.height/6)];
            }
            else {
                [delay_tips_view setCenter:CGPointMake(winsize.width/2, 5*(winsize.height-64)/6)];
            }
        }
    }
    
    if (view) {
        [view addSubview:delay_tips_view];
    }
    else {
        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [[app window] addSubview:delay_tips_view];
    }
    
    NSDictionary *dict = @{@"count":[NSString stringWithFormat:@"%d",delay_count]};
    
    delay_count ++;
    if (delay_count > 100) {
        delay_count = 0;
    }
    
    [self performSelector:@selector(delayHide:) withObject:dict afterDelay:delay];
}

- (void)delayHide:(NSDictionary*)dict {
    int count = [[dict objectForKey:@"count"] intValue];
    if (delay_tips_view) {
        if (delay_tips_view.tag == count) {
            [delay_tips_view removeFromSuperview];
            delay_tips_view = nil;
        }
    }
}

- (void)hideDelayTips {
    if (delay_tips_view) {
        [delay_tips_view removeFromSuperview];
        delay_tips_view = nil;
    }
}


@end
