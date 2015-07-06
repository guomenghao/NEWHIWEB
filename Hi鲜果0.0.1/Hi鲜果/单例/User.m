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

- (void)getUserInfo:(NSDictionary *)data
{
    self.userid = data[@"userid"];
    self.username = data[@"username"];
    self.nickName = data[@"nikename"];
    self.headId = data[@"headId"];
    self.sex = data[@"sex"];
    self.level = data[@"level"];
    self.birthday = data[@"birthday"];
    self.userAddressList = data[@"addressList"];
    self.userMoney = data[@"userMoney"];
}

@end
