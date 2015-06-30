//
//  GlobalMethod.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/28.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "GlobalMethod.h"

@implementation GlobalMethod

+ (void)removeAllSubViews:(UIView *)superView
{
    for (UIView *view in superView.subviews) {
        [view removeFromSuperview];
    }
}

@end
