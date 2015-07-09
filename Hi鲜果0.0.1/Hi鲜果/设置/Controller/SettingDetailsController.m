//
//  SettingDetailsController.m
//  Hi鲜果
//
//  Created by 李波 on 15/7/7.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "SettingDetailsController.h"

@interface SettingDetailsController ()

@end

@implementation SettingDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeUserInterface];
}


- (void)initializeUserInterface
{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(5, 64, Screen_width - 10, Screen_height - 64)];
    if ([self.title isEqual:@"关于我们"]) {
        textView.text = AboutUs;
    }
    if ([self.title isEqual:@"用户协议"]) {
        textView.text = UserAg;
    }
    textView.font = FontWithHeight(50);
    [self.view addSubview:textView];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

@end
