//
//  EatView.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/28.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "EatView.h"

@interface EatView () {
    NSDictionary *_data;
}

- (void)initializeUserInterfaceData:(NSDictionary *)data;

@end

@implementation EatView
- (instancetype)initWithView:(UIView *)view data:(NSDictionary *)data
{
    self = [self initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame), CGRectGetWidth(view.bounds) + 20, Screen_height - CGRectGetMaxY(view.frame))];
    [self initializeUserInterfaceData:data];
    return self;
}

- (void)initializeUserInterfaceData:(NSDictionary *)data
{
    _data = data;
    /**
     *  申请按钮
     */
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, CGRectGetHeight(self.bounds) / 1.5, CGRectGetHeight(self.bounds) / 1.5);
    button.center = CGPointMake(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2);
    button.backgroundColor = [UIColor whiteColor];
    button.layer.borderWidth = 5;
    button.layer.borderColor = [UIColor orangeColor].CGColor;
    button.layer.cornerRadius = CGRectGetHeight(button.bounds) / 2;
    [button setTitle:@"申请试吃" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:Screen_height / 35];
    [button addTarget:self action:@selector(askFor:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    /**
     *  申请人数
     */
    UILabel *eatNumber = [[UILabel alloc] initWithFrame:button.frame];
    eatNumber.center = CGPointMake(CGRectGetWidth(self.bounds) / 5, CGRectGetHeight(self.bounds) / 2);
    eatNumber.textAlignment = NSTextAlignmentCenter;
    eatNumber.text = @"试吃人数\n12";
    eatNumber.numberOfLines = 0;
    eatNumber.font = [UIFont systemFontOfSize:Screen_height / 45];
    [self addSubview:eatNumber];
    
    /**
     *  截止时间
     */
    UILabel *eatTime = [[UILabel alloc] initWithFrame:button.frame];
    eatTime.center = CGPointMake(CGRectGetWidth(self.bounds) / 5 * 4, CGRectGetHeight(self.bounds) / 2);
    eatTime.textAlignment = NSTextAlignmentCenter;
    eatTime.text = [NSString stringWithFormat:@"截止时间\n%@", data[@"endstime"]];
    eatTime.numberOfLines = 0;
    eatTime.font = [UIFont systemFontOfSize:Screen_height / 45];
    [self addSubview:eatTime];
}

- (void)askFor:(UIButton *)sender
{
    NSLog(@"申请试吃");
}

@end
