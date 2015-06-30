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
#import "PersonalController.h"
#import "CategoryDetailsController.h"

@interface Framework : NSObject
/**主页*/
@property (nonatomic, weak) HomePageController * homePageVC;
/**品类*/
@property (nonatomic, weak) CategoryController * categoryVC;
/**登录*/
@property (nonatomic, weak) LoginController * loginVC;
/**设置*/
@property (nonatomic, weak) SettingController * settingVC;
/**个人信息*/
@property (nonatomic, weak) PersonalController * personalVC;
/**窗口*/
@property (nonatomic, weak) UIWindow * window;
/**品类详情*/
@property (nonatomic, weak) CategoryDetailsController * CategoryDetailsVC;
/**单例初始化*/
+ (Framework *)controllers;
@end
