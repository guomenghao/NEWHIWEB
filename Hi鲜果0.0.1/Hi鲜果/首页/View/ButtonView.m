//
//  ButtonView.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/25.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "ButtonView.h"
#import "EatForFreeController.h"
#import "MyAttentionController.h"

@implementation ButtonView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, Screen_width, Screen_height * 0.16);
        self.backgroundColor = [UIColor whiteColor];
        [self initializeDataSource];
        [self initializeUserInterface];
    }
    return self;
}


- (void)initializeDataSource
{
    
}

- (void)initializeUserInterface
{
    NSArray *buttonNames = @[@"mianfeishichi.png", @"wodedingdan.png", @"wodeguanzhu.png", @"chongzhiyouli.png"];
    for (int i = 0; i < 4; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(Screen_width * 0.25 * i, 0, Screen_width / 4, Screen_height * 0.16);
        [button setImage:ImageWithName(buttonNames[i]) forState:UIControlStateNormal];
        [button setImage:ImageWithName(buttonNames[i]) forState:UIControlStateHighlighted];
        [button setTag:i + 100];
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

- (void)buttonPressed:(UIButton *)sender
{
    if (sender.tag == 100) {
        [[[UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers firstObject] pushViewController:[[EatForFreeController alloc] init] animated:YES];
    }
    if (sender.tag == 101) {
        if ([User loginUser].isLogin == NO) {
            [[Framework controllers].homePageVC.navigationController pushViewController:[[LoginController alloc] init] animated:YES];
        } else {
            [[Framework controllers].homePageVC.navigationController pushViewController:[[MyOrderController alloc] init] animated:YES];
        }
    }
    if (sender.tag == 102) {
        if ([User loginUser].isLogin == NO) {
            [[Framework controllers].homePageVC.navigationController pushViewController:[[LoginController alloc] init] animated:YES];
        } else {
            [[Framework controllers].homePageVC.navigationController pushViewController:[[MyAttentionController alloc] init] animated:YES];
        }
    }
    if (sender.tag == 103) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"功能开发中..." delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}

@end
