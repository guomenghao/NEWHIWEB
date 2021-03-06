//
//  AppDelegate.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/25.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "AppDelegate.h"
#import "HomePageController.h"
#import "CategoryController.h"
#import "ShoppingCartController.h"
#import <SMS_SDK/SMS_SDK.h>
@interface AppDelegate ()<UIAlertViewDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [NSThread sleepForTimeInterval:1];
    
    UIView *splashScreen = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_width, Screen_height)];
    [self.window addSubview:splashScreen];
    
    [UIView animateWithDuration:0.8 animations:^{
        CATransform3D transform = CATransform3DMakeScale(1.05, 1.05, 1.0);
        splashScreen.layer.transform = transform;
        splashScreen.alpha = 0.0;
    } completion:^(BOOL finished) {
        [splashScreen removeFromSuperview];
    }];
    

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [Framework controllers].window = self.window;
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    UINavigationController *homePage = [[UINavigationController alloc] initWithRootViewController:[[HomePageController alloc] init]];
    UINavigationController *category = [[UINavigationController alloc] initWithRootViewController:[[CategoryController alloc] init]];
    UINavigationController *shoppingCart = [[UINavigationController alloc] initWithRootViewController:[[ShoppingCartController alloc] init]];
    [Framework controllers].rootViewController = tabBarController;
    tabBarController.viewControllers = @[homePage, category, shoppingCart];
    [self.window setRootViewController:tabBarController];
    [self.window makeKeyAndVisible];
    
    [UMSocialData setAppKey:@"559261b267e58e6cda001819"];
    
    // 短信验证码
    [SMS_SDK registerApp:@"87b657d7705c" withSecret:@"4b33ba53cc26c1dec823ab836cec5f93"];
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


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 && alertView.tag == 900) {
        [User loginUser].isLogin = NO;
        [Framework controllers].rootViewController.selectedIndex = 0;
//        [[Framework controllers].homePageVC myGardenPressed];
        [[GlobalControl myControl].myGardenView closeGardenAnimation];
        [[[MyGardenView alloc] init] pushLoginViewController];
    }
}

@end
