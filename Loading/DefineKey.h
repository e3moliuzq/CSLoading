//
//  DefineKey.h
//
//
//  Created by e3mo on 16/5/5.
//  Copyright (c) 2016年 times. All rights reserved.
//

#ifndef _DefineKey_h
#define _DefineKey_h


//屏幕尺寸
#define SYS_UI_WINSIZE_WIDTH                        [[UIScreen mainScreen] bounds].size.width
#define SYS_UI_BASE_WIDTH                           320.f
#define SYS_UI_WIDTH_RADIO                          (SYS_UI_WINSIZE_WIDTH/SYS_UI_BASE_WIDTH)
#define SYS_UI_SCALE_WIDTH_SIZE(ScaleSize)          (SYS_UI_WIDTH_RADIO*ScaleSize)


//系统版本
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)



#endif
