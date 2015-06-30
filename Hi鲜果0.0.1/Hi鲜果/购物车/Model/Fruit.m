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
    
    return _info[@"pic"];
}

- (NSString *)ID {
    
    return _info[@"ID"];
}

- (NSString *)name {
    
    return _info[@"name"];
}

- (NSString *)unit {
    
    return _info[@"unit"];
}

- (NSString *)originalPrice {
    
    return _info[@"originalPrice"];
}

- (NSString *)discountPrice {
    
    return _info[@"discountPrice"];
}

@end
