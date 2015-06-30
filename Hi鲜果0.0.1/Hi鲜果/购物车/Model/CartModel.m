//
//  CartModel.m
//  Hi鲜果
//
//  Created by 吕玉梅 on 15/6/29.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "CartModel.h"

@implementation CartModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.goods = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
