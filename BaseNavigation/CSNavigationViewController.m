//
//  CSNavigationViewController.m
//
//
//  Created by e3mo on 16/5/5.
//  Copyright (c) 2016年 e3mo. All rights reserved.
//

#import "CSNavigationViewController.h"
#import "DefineKey.h"

#define DEFAULT_TIPS_BG_COLOR       [UIColor colorWithRed:1 green:0.303 blue:0.303 alpha:1]
#define DEFAULT_TIPS_TEXT_COLOR     [UIColor whiteColor]

@interface CSNavigationViewController () <UIGestureRecognizerDelegate> {
    UIColor *bg_color;
    UIColor *title_color;
    UIFont *title_font;
    UIStatusBarStyle style;
    
    UIView *tips_view;
    int tips_count;
    NSArray *tips_style_array;
    
    UIView *loading_view;
}

@end

@implementation CSNavigationViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (BOOL)shouldAutorotate {
    return YES;
}

// 设备支持方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}
// 默认方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return style;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController {
    if ([super initWithRootViewController:rootViewController]) {
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.interactivePopGestureRecognizer.enabled = YES;
            self.interactivePopGestureRecognizer.delegate = self;
        }
    }
    return self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isEqual:self.interactivePopGestureRecognizer] && [self.viewControllers count]==1) {
        return NO;
    } else {
        return YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!bg_color) {
        bg_color = [UIColor whiteColor];
    }
    tips_count = 0;
    
    self.navigationBar.translucent = NO;//打开这个的时候位置起始都是0，没有这条的话起始位置是0和64
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        self.navigationBar.barTintColor = bg_color;
    }
    else {
        self.navigationBar.tintColor = bg_color;
    }
    
    if (!title_color) {
        title_color = [UIColor blackColor];
    }
    if (!title_font) {
        title_font = [UIFont systemFontOfSize:17];
    }
    
    NSDictionary *dic = @{NSForegroundColorAttributeName:title_color,
                          NSFontAttributeName:title_font,
                          };
    self.navigationBar.titleTextAttributes = dic;
}

- (void)setBgColor:(UIColor *)bgColor {
    bg_color = bgColor;
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        self.navigationBar.barTintColor = bg_color;
    }
    else {
        self.navigationBar.tintColor = bg_color;
    }
}

- (void)setTitleFont:(UIFont*)font color:(UIColor*)color {
    title_font = font;
    title_color = color;
    
    NSDictionary *dic = @{NSForegroundColorAttributeName:title_color,
                          NSFontAttributeName:title_font,
                          };
    self.navigationBar.titleTextAttributes = dic;
}

- (void)setTitleAttributes:(NSDictionary*)dict {
    if (dict) {
        self.navigationBar.titleTextAttributes = dict;
    }
}

- (void)setStatusBarStyle:(UIStatusBarStyle)statusStyle {
    style = statusStyle;
}

#pragma mark - tips
- (void)setDefaultTipsStyleArray:(NSArray *)array {
    tips_style_array = [NSArray arrayWithArray:array];
}

- (void)showDelayTipsWithStyle:(int)index text:(NSString *)text delay:(float)delay {
    if (tips_style_array.count == 0) {
        [self showDelayTipsWithText:text image:nil tipsBgColor:nil textColor:nil delay:delay];
        return;
    }
    if (index >= tips_style_array.count) {
        index = 0;
    }
    [self removeTips];
    [self endLoading];
    
    NSDictionary *style_dict = [tips_style_array objectAtIndex:index];
    UIColor *tipsBgColor = [style_dict objectForKey:@"bgcolor"];
    UIColor *tipsTextColor = [style_dict objectForKey:@"textcolor"];
    UIImage *image = [style_dict objectForKey:@"image"];
    
    if (!tipsBgColor) {
        tipsBgColor = DEFAULT_TIPS_BG_COLOR;
    }
    if (!tipsTextColor) {
        tipsTextColor = DEFAULT_TIPS_TEXT_COLOR;
    }
    
    CGSize winsize = [[UIScreen mainScreen] bounds].size;
    tips_view = [[UIView alloc] initWithFrame:CGRectMake(0, -64, winsize.width, 64)];
    [tips_view setBackgroundColor:tipsBgColor];
    tips_view.tag = tips_count;
    [self.view addSubview:tips_view];
    
    float width = 0;
    if (image) {
        float ratio = 20.f/image.size.height;
        width = image.size.width * ratio;
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20+12, width, 20)];
        [imageview setImage:image];
        [imageview setBackgroundColor:[UIColor clearColor]];
        [imageview setContentMode:UIViewContentModeScaleAspectFit];
        [tips_view addSubview:imageview];
        
        width += 10.f;
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15+width, 20+12, winsize.width-30-width, 20)];
    [label setText:text];
    [label setTextColor:tipsTextColor];
    [label setTextAlignment:NSTextAlignmentLeft];
    [label setFont:[UIFont systemFontOfSize:15]];
    [label setBackgroundColor:[UIColor clearColor]];
    [tips_view addSubview:label];
    
    [self showTips];
    
    
    NSDictionary *dict = @{@"count":[NSString stringWithFormat:@"%d",tips_count]};
    
    tips_count ++;
    if (tips_count > 100) {
        tips_count = 0;
    }
    
    [self performSelector:@selector(delayHide:) withObject:dict afterDelay:delay];
}

- (void)showDelayTipsWithText:(NSString*)text image:(UIImage *)image tipsBgColor:(UIColor *)tipsBgColor textColor:(UIColor *)tipsTextColor delay:(float)delay {
    [self removeTips];
    [self endLoading];
    
    if (!tipsBgColor) {
        tipsBgColor = DEFAULT_TIPS_BG_COLOR;
    }
    if (!tipsTextColor) {
        tipsTextColor = DEFAULT_TIPS_TEXT_COLOR;
    }
    
    CGSize winsize = [[UIScreen mainScreen] bounds].size;
    tips_view = [[UIView alloc] initWithFrame:CGRectMake(0, -64, winsize.width, 64)];
    [tips_view setBackgroundColor:tipsBgColor];
    tips_view.tag = tips_count;
    [self.view addSubview:tips_view];
    
    float width = 0;
    if (image) {
        float ratio = 20.f/image.size.height;
        width = image.size.width * ratio;
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20+12, width, 20)];
        [imageview setImage:image];
        [imageview setBackgroundColor:[UIColor clearColor]];
        [imageview setContentMode:UIViewContentModeScaleAspectFit];
        [tips_view addSubview:imageview];
        
        width += 10.f;
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15+width, 20+12, winsize.width-30-width, 20)];
    [label setText:text];
    [label setTextColor:tipsTextColor];
    [label setTextAlignment:NSTextAlignmentLeft];
    [label setFont:[UIFont systemFontOfSize:15]];
    [label setBackgroundColor:[UIColor clearColor]];
    [tips_view addSubview:label];
    
    [self showTips];
    
    
    NSDictionary *dict = @{@"count":[NSString stringWithFormat:@"%d",tips_count]};
    
    tips_count ++;
    if (tips_count > 100) {
        tips_count = 0;
    }
    
    [self performSelector:@selector(delayHide:) withObject:dict afterDelay:delay];
}

- (void)delayHide:(NSDictionary*)dict {
    int count = [[dict objectForKey:@"count"] intValue];
    if (tips_view) {
        if (tips_view.tag == count) {
            [self hideTips];
        }
    }
}

- (void)showTips {
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = tips_view.frame;
        frame.origin.y = 0;
        tips_view.frame = frame;
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hideTips {
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = tips_view.frame;
        frame.origin.y = -tips_view.frame.size.height;
        tips_view.frame = frame;
        
    } completion:^(BOOL finished) {
//        [self removeTips];
    }];
}

- (void)removeTips {
    if (tips_view) {
        [tips_view removeFromSuperview];
        tips_view = nil;
    }
}

#pragma mark - loading
- (void)showTitleHideLoadingWithText:(NSString *)text textColor:(UIColor *)textColor activityIndicatorColor:(UIColor *)activityIndicatorColor {
    [self removeTips];
    [self endLoading];
    
    if (!textColor) {
        textColor = DEFAULT_TIPS_TEXT_COLOR;
    }
    if (!activityIndicatorColor) {
        activityIndicatorColor = DEFAULT_TIPS_TEXT_COLOR;
    }
    
    CGSize winsize = [[UIScreen mainScreen] bounds].size;
    loading_view = [[UIView alloc] initWithFrame:CGRectMake(0, 20, winsize.width, 44)];
    [loading_view setBackgroundColor:bg_color];
    loading_view.userInteractionEnabled = NO;
    [self.view addSubview:loading_view];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, winsize.width, 44)];
    [view setBackgroundColor:[UIColor clearColor]];
    [loading_view addSubview:view];
    
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] init];
    [activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [activityIndicatorView setHidesWhenStopped:NO];//自动隐藏，YES的情况下如果stop时自动hidden
    [activityIndicatorView setColor:activityIndicatorColor];//设置小菊花的颜色
    [activityIndicatorView startAnimating];
    [view addSubview:activityIndicatorView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 12, 0, 20)];
    [label setText:text];
    [label setTextColor:textColor];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:17]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label sizeToFit];
    CGRect frame = label.frame;
    frame.size.height = 20;
    label.frame = frame;
    [view addSubview:label];
    
    frame = view.frame;
    frame.size.width = label.frame.size.width + label.frame.origin.x;
    frame.origin.x = winsize.width/2 - frame.size.width/2;
    view.frame = frame;
    
    activityIndicatorView.center = CGPointMake(10, 22);
}

- (void)showTitleLoadingWithPosX:(float)posx activityIndicatorColor:(UIColor *)activityIndicatorColor {
    [self removeTips];
    [self endLoading];
    
    loading_view = [[UIView alloc] initWithFrame:CGRectMake(posx, 20+12, 20, 20)];
    [loading_view setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:loading_view];
    
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] init];
    [activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [activityIndicatorView setHidesWhenStopped:NO];//自动隐藏，YES的情况下如果stop时自动hidden
    [activityIndicatorView setColor:activityIndicatorColor];//设置小菊花的颜色
    [activityIndicatorView startAnimating];
    activityIndicatorView.center = CGPointMake(10, 10);
    [loading_view addSubview:activityIndicatorView];
}

- (void)showProgressLoadingWithBgColor:(UIColor *)bgColor progressColor:(UIColor *)progressColor {
    if (!bgColor) {
        bgColor = [UIColor clearColor];
    }
    if (!progressColor) {
        progressColor = bg_color;
    }
    [self removeTips];
    [self endLoading];
    
    CGSize winsize = [[UIScreen mainScreen] bounds].size;
    loading_view = [[UIView alloc] initWithFrame:CGRectMake(0, 65, winsize.width, 2)];
    [loading_view setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:loading_view];
    
    
    UIProgressView *pro_view = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    [pro_view setFrame:CGRectMake(0, 0, winsize.width, 2)];
    pro_view.progress = 0;
    pro_view.progressTintColor = progressColor;
    pro_view.trackTintColor = bgColor;
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 1.3);
    pro_view.transform = transform;
    pro_view.tag = 1002;
    [loading_view addSubview:pro_view];
}

- (void)changeProogressPercent:(float)percent {
    if (loading_view) {
        UIProgressView *pro_view = (UIProgressView*)[loading_view viewWithTag:1002];
        [pro_view setProgress:percent animated:YES];
    }
}

- (void)endLoading {
    if (loading_view) {
        [loading_view removeFromSuperview];
        loading_view = nil;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
    
    [self endLoading];
}

- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated {
    
    [self endLoading];
    
    return [super popViewControllerAnimated:animated];
}

@end
