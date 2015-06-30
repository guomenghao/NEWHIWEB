//
//  UserModel.h
//  Hi鲜果
//
//  Created by rimi on 15/6/26.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
/**用户账号*/
@property (strong, nonatomic, readonly) NSString * account;
/**用户头像*/
@property (strong, nonatomic, readonly) NSString * picture;
/**用户昵称*/
@property (strong, nonatomic, readonly) NSString * nickName;
/**用户积分*/
@property (strong, nonatomic, readonly) NSString * score;
/**接收所有信息的字典*/
@property (strong, nonatomic) NSDictionary *info;
/**标记登录状态*/
@property (assign, nonatomic) BOOL isLogin;

/**单例便利构造，返回当前已登录用户，在登录成功后第一次创建对象*/
+ (User *)loginUser;
@end
