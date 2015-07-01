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



#import <Foundation/Foundation.h>

@protocol URLDefine <NSObject>

@end
