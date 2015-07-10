//
//  OrderItem.m
//  Hi鲜果
//
//  Created by rimi on 15/7/10.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "OrderItem.h"

@implementation OrderItem
- (instancetype)initWithInfo:(NSDictionary *)info
{
    self = [super init];
    if (self) {
        self.isChecked = NO;
        self.ddno = info[@"ddno"];
        self.ddtime = info[@"ddtime"];
        self.havePrice = info[@"haveprice"];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isChecked = NO;
    }
    return self;
}
@end
