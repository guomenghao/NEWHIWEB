//
//  HoverButton.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/29.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "HoverButton.h"

@interface HoverButton ()

@property (nonatomic, strong) UIViewController *viewController;

@end

@implementation HoverButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(22, 22, Screen_width - 44, 35);
    }
    return self;
}

- (void)initializeUserInterfaceWithLike:(BOOL)like controller:(UIViewController *)controller
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 35, 35);
    backButton.backgroundColor = [UIColor orangeColor];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backView:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backButton];
    self.viewController = controller;
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(CGRectGetWidth(self.bounds) - 35, 0, 35, 35);
    shareButton.backgroundColor = [UIColor orangeColor];
    [shareButton setTitle:@"分享" forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(buttonShare:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:shareButton];
    
    if (like) {
        UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        likeButton.frame = CGRectMake(CGRectGetWidth(self.bounds) - 90, 0, 35, 35);
        likeButton.backgroundColor = [UIColor orangeColor];
        [likeButton setTitle:@"喜欢" forState:UIControlStateNormal];
        [likeButton addTarget:self action:@selector(buttonLike:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:likeButton];
    }
}

- (void)backView:(UIButton *)sender
{
    [self.viewController.navigationController popViewControllerAnimated:YES];
    self.viewController = nil;
}

- (void)buttonLike:(UIButton *)sender
{
    NSLog(@"喜欢");
}

- (void)buttonShare:(UIButton *)sender
{
    NSLog(@"分享");
}
@end
