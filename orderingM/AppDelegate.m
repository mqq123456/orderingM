//
//  AppDelegate.m
//  orderingM
//
//  Created by HeQin on 2017/11/3.
//  Copyright © 2017年 HeQin. All rights reserved.
//

#import "AppDelegate.h"
#import "HQLoginVC.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    HQLoginVC *viewController = [[HQLoginVC alloc]init];
    self.window.rootViewController  = [[UINavigationController alloc] initWithRootViewController:viewController];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    self.window.backgroundColor     = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
