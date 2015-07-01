//
//  ButtonView.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/25.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "ButtonView.h"
#import "EatForFreeController.h"

@implementation ButtonView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(5, 0, Screen_width - 10, Screen_height * 0.25);
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColor colorWithWhite:0.843 alpha:1.000].CGColor;
        self.layer.borderWidth = 1;
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
    NSArray *buttonNames = @[@"mianfeishichi.png", @"wodedingdan.png", @"higuotuangou.png", @"chongzhiyouli.png"];
    for (int i = 0; i < 4; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:Screen_height / 35];
        button.frame = CGRectMake((Screen_width * 0.5 - 5) * (i % 2), Screen_height * 0.25 * 0.5 * (i / 2), Screen_width / 2 - 5, Screen_height * 0.25 * 0.5);
        [button.layer setBorderWidth:0.5];
        [button.layer setBorderColor:[UIColor colorWithWhite:0.843 alpha:1.000].CGColor];
//        [button setTitle:buttonNames[i] forState:UIControlStateNormal];
        [button setImage:ImageWithName(buttonNames[i]) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
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
}

@end
