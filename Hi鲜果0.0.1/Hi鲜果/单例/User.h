//
//  UserModel.h
//  Hi鲜果
//
//  Created by rimi on 15/6/26.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
/**用户ID*/
@property (strong, nonatomic) NSString * userid;
/**用户账号<为手机号>*/
@property (strong, nonatomic) NSString * username;
/**用户昵称*/
@property (strong, nonatomic) NSString * nickName;
/**用户积分*/
@property (strong, nonatomic) NSString * score;
/**接收所有信息的字典*/
@property (strong, nonatomic) NSDictionary *info;
/**标记登录状态*/
@property (assign, nonatomic) BOOL isLogin;


/**
 *  临时信息库，用于修改个人信息储存
 */
@property (weak, nonatomic) UIImageView *tempHeadImage;
@property (weak, nonatomic) NSString *tempHead;
@property (weak, nonatomic) UITextField *tempName;
@property (weak, nonatomic) UILabel *tempSex;
@property (weak, nonatomic) UILabel *tempBirthday;


/**单例便利构造，返回当前已登录用户，在登录成功后第一次创建对象*/
+ (User *)loginUser;
@end
