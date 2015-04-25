//  github: https://github.com/MakeZL/MLSelectPhoto
//  author: @email <120886865@qq.com>
//
//  AppDelegate.m
//  MLSelectPhoto
//
//  Created by 张磊 on 15/4/22.
//  Copyright (c) 2015年 com.zixue101.www. All rights reserved.
//

#import "AppDelegate.h"
#import "MLSelectPhotoNavigationViewController.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc ]initWithFrame:[UIScreen mainScreen].bounds];
    MLSelectPhotoNavigationViewController *navVc = [[MLSelectPhotoNavigationViewController alloc] initWithRootViewController:[[ViewController alloc] init]];
    self.window.rootViewController = navVc;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
