//
//  GlobalMethod.h
//  Hi鲜果
//
//  Created by 李波 on 15/6/28.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalMethod : NSObject


/**
 *  用来移除所有子视图
 *
 *  @param superView 当前需要移除子视图的父视图
 */
+ (void)removeAllSubViews:(UIView *)superView;

+ (void)serviceWithMothedName:(NSString *)mothedName parmeter:(id)parmeter success:(void (^)(id responseObject))succeedBlock fail:(void (^)(NSError *error))failBlock;
+ (void)NotHaveAlertServiceWithMothedName:(NSString *)mothedName parmeter:(id)parmeter success:(void (^)(id responseObject))succeedBlock fail:(void (^)(NSError *error))failBlock;
+ (void)rectWithView:(UIView *)view corners1:(UIRectCorner)corners1 corners2:(UIRectCorner)corners2 radius:(CGFloat)radius lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor fillColor:(UIColor *)fillColor;
+ (void)view:(UIView *)view lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor fillColor:(UIColor *)fillColor;
+ (BOOL) validateEmail:(NSString *)email;
+ (BOOL) validateUserName:(NSString *)name;
+ (BOOL) validateMobile:(NSString *)mobile;
+ (BOOL) validatePassword:(NSString *)passWord;
/**label的size适应文字*/
+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font maxWidth:(CGFloat)width maxHeight:(CGFloat)height;

/**
 *  刷新用户数据
 */
+ (void)getUserInfoSuccess:(void (^)(id responseObject))succeedBlock;


@end
