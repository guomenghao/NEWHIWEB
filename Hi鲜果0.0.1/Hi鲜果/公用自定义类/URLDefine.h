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
 *  编辑购物车
 */
#define EditCar_Url @"/e/api/editBuyCar.php"

/**
 *  清空购物车
 */
#define ClearCar_Url @"/e/api/clearBuyCar.php"

/**
 *  立即结算
 */
#define Settle_Url @"/e/api/getOrderStepOne.php"

/**
 *  显示用户信息
 */
#define GetUserInfo_Url @"/e/api/getUserInfo.php"

/**
 *  修改用户信息
 */
#define EditUserInfo_Url @"/e/api/editUserInfo.php"

/**
 *  新增收货地址
 */
#define AddAddress_Url @"/e/api/addAddress.php"

/**
 *  修改收货地址
 */
#define EditAddress_Url @"/e/api/editAddress.php"

/**
 *  删除收货地址
 */
#define DelAddress_Url @"/e/api/delAddress.php"

/**
 *  增加收藏
 */
#define AddFavFun_Url @"/e/api/addFavFun.php"

/**
 *  默认收货地址
 */
#define DefaultAddress_Url @"/e/api/defAddress.php"

/**
 *  商品搜索
 */
#define GetSearch_Url @"/e/api/getSearch.php"

/**
 *  提交订单
 */
#define SubmitOrder_Url @"/e/api/getSubmitOrder.php"

/**
 *  订单列表
 */
#define GetOrderList_Url @"/e/api/getDdList.php"

/**
 *  确认收货,参数ddno=订单编号
 */
#define ConfirmOrder_Url @"/e/api/ShopDdToConform.php"

/**
 *  删除订单,参数ddno=订单编号
 */
#define DelOrder_Url @"/e/api/ShopSysDelDd.php"
/**
 *  查看订单详情,参数ddno=订单编号
 */
#define GetOrderDetail_Url @"/e/api/ShopSysShowDd.php"
/**
 *  我的关注
 */
#define GetFavaList_Url @"/e/api/getFavaList.php"

/**
 *  删除收藏
 */
#define DelFavaFun_Url @"/e/api//delFavaFun.php"

/**
 *  试吃
 */
#define GetTriedList_Url @"/e/api//getTriedList.php"

/**
 *  申请试吃
 */
#define AddTriedNum_Url @"/e/api/addTriedNum.php"

/**
 *  我的试吃
 */
#define GetMyTriedList_Url @"/e/api/getMyTriedList.php"



#import <Foundation/Foundation.h>

@protocol URLDefine <NSObject>

@end
