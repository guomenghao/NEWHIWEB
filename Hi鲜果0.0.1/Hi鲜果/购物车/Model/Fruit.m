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
        
        self.info = _info;//调用setter方法
    }
    return self;
}

#pragma mark - getter

- (NSString *)fruitID {
    
    return _info[@"ID"];
}

- (NSString *)fruitName {
    
    return _info[@"name"];
}

- (NSString *)fruitUnit {
    
    return _info[@"unit"];
}

- (NSString *)originalPrice {
    
    return _info[@"originalPrice"];
}

- (NSString *)discountPrice {
    
    return _info[@"discountPrice"];
}

@end
