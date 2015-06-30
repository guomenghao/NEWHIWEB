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
- (NSString *)account {
    
    return _info[@"account"];
}

- (NSString *)picture {
    
    return _info[@"picture"];
}

- (NSString *)nickName {
    
    return _info[@"nickName"];
}

- (NSString *)score {
    
    return _info[@"score"];
}

@end
