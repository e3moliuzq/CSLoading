//
//  CSNavigationViewController.h
//  
//
//  Created by e3mo on 16/5/5.
//  Copyright (c) 2016年 e3mo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefineKey.h"

@interface CSNavigationViewController : UINavigationController {
    
}
//导航栏设置
- (void)setBgColor:(UIColor*)bgColor;//导航栏背景颜色
- (void)setTitleFont:(UIFont*)font color:(UIColor*)color;
- (void)setTitleAttributes:(NSDictionary*)dict;//导航栏文字状态设置
- (void)setStatusBarStyle:(UIStatusBarStyle)statusStyle;//状态条设置

//提示消息
/*
    预设tips的多个默认状态值，每个状态都为一个NSDictionary，包含三个key，
        bgcolor为tips的背景颜色，UIColor
        textcolor为tips的文字颜色，UIColor
            两个都可不设定，则为默认颜色
        image为图片，UIImage
            可不设定，则无图片显示
 */
- (void)setDefaultTipsStyleArray:(NSArray*)array;
/*
    显示预设状态的tips
    index为预设状态值
    text为显示文字
    delay为显示时长
 */
- (void)showDelayTipsWithStyle:(int)index text:(NSString*)text delay:(float)delay;
/*
    显示非预设状态的tips
    text为显示文字
    image为显示图片
    tipsBgColor为tips的背景颜色，UIColor
    textColor为tips的文字颜色，UIColor
    delay为显示时长
 */
- (void)showDelayTipsWithText:(NSString*)text image:(UIImage*)image tipsBgColor:(UIColor*)tipsBgColor textColor:(UIColor*)tipsTextColor delay:(float)delay;

//Loading
/*
 显示文字状态的loading，TitleHideLoading会阻挡所有navi的操作
 text为显示文字
 textColor为loading的文字颜色，UIColor
 activityIndicatorColor为loading小菊花的颜色，UIColor
 */
- (void)showTitleHideLoadingWithText:(NSString*)text textColor:(UIColor*)textColor activityIndicatorColor:(UIColor*)activityIndicatorColor;
- (void)showTitleLoadingWithPosX:(float)posx activityIndicatorColor:(UIColor *)activityIndicatorColor;

/*
 显示进度条，在navi最下方
 */
- (void)showProgressLoadingWithBgColor:(UIColor*)bgColor progressColor:(UIColor*)progressColor;
- (void)changeProogressPercent:(float)percent;
- (void)endLoading;



@end
