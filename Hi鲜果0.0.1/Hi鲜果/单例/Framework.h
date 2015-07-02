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
#import "RegisterController.h"
#import "SearchController.h"
#import "MyOrderController.h"
@interface Framework : NSObject
/**主页*/
@property (nonatomic, weak) HomePageController * homePageVC;
/**品类*/
@property (nonatomic, weak) CategoryController * categoryVC;
/**登录*/
@property (nonatomic, weak) LoginController * loginVC;
/**注册*/
@property (nonatomic, weak) RegisterController * registerVC;
/**设置*/
@property (nonatomic, weak) SettingController * settingVC;
/**个人信息*/
@property (nonatomic, weak) PersonalController * personalVC;
/**搜索*/
@property (nonatomic, weak) SearchController * searchVC;
/**我的订单*/
@property (nonatomic, weak) MyOrderController * myOrderVC;
/**窗口*/
@property (nonatomic, weak) UIWindow * window;
/**品类详情*/
@property (nonatomic, weak) CategoryDetailsController * CategoryDetailsVC;
/**单例初始化*/
+ (Framework *)controllers;
@property (nonatomic, weak) UITabBarController * rootViewController;

@end
