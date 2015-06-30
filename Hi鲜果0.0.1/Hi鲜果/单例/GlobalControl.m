//
//  GlobalControl.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/26.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "GlobalControl.h"

static GlobalControl *globalControl = nil;
@implementation GlobalControl

+ (GlobalControl *)myControl
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        globalControl = [[GlobalControl alloc] init];
    });
    return globalControl;
}

@end
