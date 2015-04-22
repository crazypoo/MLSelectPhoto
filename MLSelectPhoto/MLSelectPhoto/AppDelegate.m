//
//  AppDelegate.m
//  MLSelectPhoto
//
//  Created by 张磊 on 15/4/22.
//  Copyright (c) 2015年 com.zixue101.www. All rights reserved.
//

#import "AppDelegate.h"
#import "MLSelectPhotoCommon.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc ]initWithFrame:[UIScreen mainScreen].bounds];
    UINavigationController *navVc = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    
    [navVc.navigationBar setValue:UIColorFromRGB(0x2f3535) forKeyPath:@"barTintColor"];
    [navVc.navigationBar setTintColor:UIColorFromRGB(0xd5d5d5)];
    [navVc.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0xd5d5d5)}];
    
    self.window.rootViewController = navVc;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
