//
//  URLDefine.h
//  Hi鲜果
//
//  Created by 李波 on 15/6/29.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

/**
 *  首字段
 */
#define Base_Url @"http://218.6.128.225:8088/"

/**
 *  获取商品列表
 */
#define GetNewsList_Url @"/e/api/getNewsList.php"

/**
 *  获取商品详情
 */
#define GetNewsContent_Url @"/e/api/getNewsContent.php"

/**
 *  用户注册
 */
#define Register_Url @"/e/api/getRigister.php"

/**
 *  用户登录验证
 */
#define Login_Url @"/e/api/getLogin.php"

/**
 *  用户注销
 */
#define Logout_Url @"/e/api/getOutLogin.php"

/**
 *  加入购物车
 */
#define AddCar_Url @"/e/api/addBuyCar.php"

/**
 *  查看购物车
 */
#define GetCar_Url @"/e/api/getBuyCarList.php"

/**
 *  立即结算
 */
#define Settle_Url @"/e/api/getOrderStepOne.php"

#import <Foundation/Foundation.h>

@protocol URLDefine <NSObject>

@end
