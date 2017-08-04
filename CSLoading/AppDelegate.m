//
//  AppDelegate.m
//  CSLoading
//
//  Created by e3mo on 16/5/5.
//  Copyright © 2016年 e3mo. All rights reserved.
//

#import "AppDelegate.h"
#import "CSNavigationViewController.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    UIColor *tipsBgColor = [style_dict objectForKey:@"bgcolor"];
//    UIColor *tipsTextColor = [style_dict objectForKey:@"textcolor"];
    //    UIImage *image = [style_dict objectForKey:@"image"];
    NSDictionary *dict1 = @{@"bgcolor":[UIColor colorWithRed:1 green:0.333 blue:0.217 alpha:1],@"textcolor":[UIColor whiteColor],@"image":[UIImage imageNamed:@"Cancel.png"]};
    NSDictionary *dict2 = @{@"bgcolor":[UIColor colorWithRed:0.505 green:1 blue:0.372 alpha:1],@"textcolor":[UIColor darkGrayColor],@"image":[UIImage imageNamed:@"Ok.png"]};
    NSDictionary *dict3 = @{@"bgcolor":[UIColor colorWithRed:1 green:0.811 blue:0.286 alpha:1],@"textcolor":[UIColor whiteColor],@"image":[UIImage imageNamed:@"Info.png"]};
    NSArray *arr = [NSArray arrayWithObjects:dict1, dict2, dict3, nil];
    
    ViewController *controller = [[ViewController alloc] init];
    CSNavigationViewController *navi = [[CSNavigationViewController alloc] initWithRootViewController:controller];
    [navi setBgColor:[UIColor colorWithRed:0.169 green:0.451 blue:1 alpha:1]];
    [navi setTitleFont:[UIFont systemFontOfSize:17] color:[UIColor whiteColor]];
    [navi setStatusBarStyle:UIStatusBarStyleLightContent];
    [navi setDefaultTipsStyleArray:arr];
    
    self.window.rootViewController = navi;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
