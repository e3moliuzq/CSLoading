//
//  LoadingViewController.h
//
//
//  Created by e3mo on 16/5/5.
//  Copyright (c) 2016年 e3mo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingViewController : UIViewController {
    UIView *small_loading_view;
    UIView *full_loading_view;
    UIView *delay_tips_view;
    UIView *progress_loading_view;
    int progress_mode;
    int progress_count;
}

+ (LoadingViewController *)sharedViewController;

/**
 只能同时出现一个
 */

/**
 小屏loading，不会阻碍其他操作
 center：传入CGPointZero为默认位置，也可传值设定位置
 text：显示文字，不能换行，文字大小自适应
 view：显示的view，可不传，不传时为window添加
 */
- (void)showSmallLoadingWithCenter:(CGPoint)center text:(NSString*)text view:(UIView*)view;

/**
 全屏loading，会阻碍loading覆盖的所有操作
 text：显示文字，不能换行，文字大小自适应
 view：显示的view，可不传，不传时为window添加
 alpha:阻挡层透明度
 */
- (void)showFullLoadingWithText:(NSString*)text view:(UIView*)view;
- (void)showFullLoadingWithText:(NSString*)text view:(UIView*)view alpha:(float)alpha;

/**
 提示消息，不会阻碍其他操作
 center：传入CGPointZero为默认位置，也可传值设定位置
 text：显示文字，不能换行，文字大小自适应
 view：显示的view，可不传，不传时为window添加
 delay:移除时间
 */
- (void)showDelayTipsWithCenter:(CGPoint)center text:(NSString*)text view:(UIView*)view delay:(float)delay;

/**
 进度条loading，会阻碍loading覆盖的所有操作
 mode：显示模式，mode == 2时无进度文字，mode == 1时进度条上方会有"2.23 %"样式的进度文字，mode == 0时进度条上会有"1 / 20"样式的进度文字
 text：显示文字，不能换行，文字大小自适应
 view：显示的view，可不传，不传时为window添加
 count：进度的基数，必须大于0，不然进度会保持100%不变
 */
- (void)showProgressLoadingWithMode:(int)mode text:(NSString*)text view:(UIView*)view count:(int)count;
/**
 进度条loading进度调整方法
 index：范围为0~进度的基数，小于0时进度不会变化，只改变text时index传-1
 text：改变进度文字，可为空
 */
- (void)changeProgressLoadingIndex:(int)index text:(NSString*)text;

- (void)hideLoading;//移除loading

@end
