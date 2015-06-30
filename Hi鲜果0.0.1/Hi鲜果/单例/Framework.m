//
//  Framework.m
//  Hi鲜果
//
//  Created by rimi on 15/6/26.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "Framework.h"

@implementation Framework
+ (id)controllers {
    
    static dispatch_once_t onceToken;
    static Framework * framework;
    dispatch_once(&onceToken, ^{
        framework = [[Framework alloc] init];
    });
    return framework;
}

@end
