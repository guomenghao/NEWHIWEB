//
//  FlexibleFrame.m
//  屏幕适配
//
//  Created by rimi on 15/6/26.
//  Copyright (c) 2015年 吕玉梅. All rights reserved.
//

#import "FlexibleFrame.h"
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
#define IPHONE5_SIZE CGSizeMake(320,568)
@implementation FlexibleFrame
+ (CGSize)ratios
{
    
    CGSize ratios;
    if (SCREEN_SIZE.height == 480) {
        
        ratios = CGSizeMake(SCREEN_SIZE.height / IPHONE5_SIZE.height, SCREEN_SIZE.height / IPHONE5_SIZE.height);
        
    } else {
        
        ratios = CGSizeMake(SCREEN_SIZE.width / IPHONE5_SIZE.width, SCREEN_SIZE.height / IPHONE5_SIZE.height) ;
    }
    return ratios;
}

+ (CGRect)frameWithIPhone5Frame:(CGRect)iPhone5Frame
{
    CGFloat x = iPhone5Frame.origin.x * [self ratios].width;
    CGFloat y = iPhone5Frame.origin.y * [self ratios].height;
    CGFloat width = iPhone5Frame.size.width * [self ratios].width;
    CGFloat height = iPhone5Frame.size.height * [self ratios].height;
    return CGRectMake(x, y, width, height);
}
@end
