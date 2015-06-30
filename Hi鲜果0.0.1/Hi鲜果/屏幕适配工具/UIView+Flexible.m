//
//  UIView+Flexible.m
//  屏幕适配
//
//  Created by rimi on 15/6/26.
//  Copyright (c) 2015年 吕玉梅. All rights reserved.
//

@implementation UIView (Flexible)
- (instancetype)initWithiPhone5Frame:(CGRect)frame {
    
    self = [self initWithFrame:[FlexibleFrame frameWithIPhone5Frame:frame]];
    // 不要这样写，会崩溃
//    self = [super init];
//    self.frame = [FlexibleFrame frameWithIPhone5Frame:frame];
    return self;
}
@end
