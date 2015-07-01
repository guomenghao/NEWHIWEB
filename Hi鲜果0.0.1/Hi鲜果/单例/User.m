//
//  UserModel.m
//  Hi鲜果
//
//  Created by rimi on 15/6/26.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "User.h"

@implementation User

+ (User *)loginUser {
    static dispatch_once_t onceToken;
    static User * loginUser;
    dispatch_once(&onceToken, ^{
        loginUser = [[User alloc] init];
    });
    return loginUser;
}

// 重写getter方法，将_info中的数据返回

- (void)setInfo:(NSDictionary *)info {
    
    _info = info;
}

- (NSString *)username {
    
    return _info[@"username"];
}

- (NSString *)nickName {
    
    return _info[@"nickname"];
}

- (NSString *)score {
    
    return _info[@"score"];
}

- (NSString *)userid {
    
    return _info[@"userid"];
}

// 重写description
- (NSString *)description {
    
    return [NSString stringWithFormat:@"用户信息为\n手机号：%@\n昵称：%@\n积分：%@\n登录状态：%d", self.username, self.nickName, self.score, self.isLogin];
}

@end
