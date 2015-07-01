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
+ (void)rectWithView:(UIView *)view corners1:(UIRectCorner)corners1 corners2:(UIRectCorner)corners2 radius:(CGFloat)radius;

/*邮箱是否有效*/
+ (BOOL) validateEmail:(NSString *)email;
/**手机号码是否有效：13、15、17、18开头*/
+ (BOOL) validateMobile:(NSString *)mobile;
/**用户名是否有效：是字母数字开头，6~20位*/
+ (BOOL) validateUserName:(NSString *)name;
/**密码是否有效：是字母数字组合，6-16位*/
+ (BOOL) validatePassword:(NSString *)passWord;
@end
