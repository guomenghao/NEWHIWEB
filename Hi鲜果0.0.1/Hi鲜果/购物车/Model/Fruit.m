//
//  Fruit.m
//  Hi鲜果
//
//  Created by rimi on 15/6/30.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "Fruit.h"

@implementation Fruit
- (instancetype)initWithInfo:(NSDictionary *)info {
    
    self = [super init];
    if (self) {
        
        self.info = info;//调用setter方法
    }
    return self;
}

#pragma mark - getter

- (NSString *)pic {
    
    return _info[@"titlepic"];
}

- (NSString *)ID {
    
    return _info[@"id"];
}

- (NSString *)name {
    
    return _info[@"title"];
}

- (NSString *)unit {
    
    //return _info[@"unit"];
    return @"一个";
}

- (NSString *)originalPrice {
    
    return _info[@"tprice"];
}

- (NSString *)discountPrice {
    
    return _info[@"price"];
}

- (NSNumber *)number {
    
    return _info[@"pnum"];
}

- (NSString *)classid {
    
    return _info[@"classid"];
}
@end
