//
//  EatView.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/28.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "EatView.h"

@interface EatView ()

- (void)initializeUserInterface;

@end

@implementation EatView
- (instancetype)initWithView:(UIView *)view
{
    self = [self initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame), CGRectGetWidth(view.bounds) + 20, Screen_height - CGRectGetMaxY(view.frame))];
    [self initializeUserInterface];
    return self;
}

- (void)initializeUserInterface
{
    /**
     *  申请按钮
     */
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, CGRectGetHeight(self.bounds) / 1.5, CGRectGetHeight(self.bounds) / 1.5);
    button.center = CGPointMake(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2);
    button.backgroundColor = [UIColor orangeColor];
    button.layer.cornerRadius = CGRectGetHeight(button.bounds) / 2;
    [button setTitle:@"申请试吃" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:Screen_height / 35];
    [self addSubview:button];
    
    /**
     *  申请人数
     */
    UILabel *eatNumber = [[UILabel alloc] initWithFrame:button.frame];
    eatNumber.center = CGPointMake(CGRectGetWidth(self.bounds) / 5, CGRectGetHeight(self.bounds) / 2);
    eatNumber.textAlignment = NSTextAlignmentCenter;
    eatNumber.text = @"试吃人数";
    eatNumber.font = [UIFont systemFontOfSize:Screen_height / 40];
    [self addSubview:eatNumber];
    
    /**
     *  截止时间
     */
    UILabel *eatTime = [[UILabel alloc] initWithFrame:button.frame];
    eatTime.center = CGPointMake(CGRectGetWidth(self.bounds) / 5 * 4, CGRectGetHeight(self.bounds) / 2);
    eatTime.textAlignment = NSTextAlignmentCenter;
    eatTime.text = @"截止时间";
    eatTime.font = [UIFont systemFontOfSize:Screen_height / 40];
    [self addSubview:eatTime];
}

@end
