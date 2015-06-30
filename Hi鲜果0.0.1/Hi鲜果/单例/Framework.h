//
//  Framework.h
//  Hi鲜果
//
//  Created by rimi on 15/6/26.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HomePageController.h"
#import "CategoryController.h"
#import "LoginController.h"
#import "AppDelegate.h"
#import "SettingController.h"
#import "CategoryDetailsController.h"

@interface Framework : NSObject
@property (nonatomic, weak) HomePageController * homePageVC;
@property (nonatomic, weak) CategoryController * categoryVC;
@property (nonatomic, weak) LoginController * loginVC;
@property (nonatomic, weak) SettingController * settingVC;
@property (nonatomic, weak) CategoryDetailsController * CategoryDetailsVC;
@property (nonatomic, weak) UIWindow * window;
/**单例初始化*/
+ (Framework *)controllers;
@end
