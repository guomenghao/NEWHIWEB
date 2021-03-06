//
//  HoverButton.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/29.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "HoverButton.h"

@interface HoverButton () {
    NSDictionary *_data;
}

@property (nonatomic, weak) UIViewController *viewController;

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

- (void)initializeUserInterfaceWithLike:(BOOL)like controller:(UIViewController *)controller data:(NSDictionary *)data
{
    
    [GlobalMethod removeAllSubViews:self];
    _data = data;
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, Screen_height / 19, Screen_height / 19);
    [backButton setImage:ImageWithName(@"back_0.png") forState:UIControlStateNormal];
    [backButton setImage:ImageWithName(@"back_0.png") forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(backView:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backButton];
    self.viewController = controller;
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(CGRectGetWidth(self.bounds) - Screen_height / 19, 0, Screen_height / 19, Screen_height / 19);
    [shareButton addTarget:self action:@selector(buttonShare:) forControlEvents:UIControlEventTouchUpInside];
    [shareButton setImage:ImageWithName(@"fenxiang_0.png") forState:UIControlStateNormal];
    [self addSubview:shareButton];
    
    if (like) {
        UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        likeButton.frame = CGRectMake(CGRectGetWidth(self.bounds) - Screen_height / 8, 1.5, Screen_height / 21, Screen_height / 21);
        [likeButton addTarget:self action:@selector(buttonLike:) forControlEvents:UIControlEventTouchUpInside];
        [likeButton setImage:ImageWithName(@"shoucang_0.png") forState:UIControlStateNormal];
        [likeButton setImage:ImageWithName(@"shoucang_1.png") forState:UIControlStateHighlighted];
        [self addSubview:likeButton];
    }
}

- (void)backView:(UIButton *)sender
{
    [self.viewController.navigationController popViewControllerAnimated:YES];
}

- (void)buttonLike:(UIButton *)sender
{
    if ([User loginUser].isLogin == NO) {
        [[Framework controllers].fruitDetailVC.navigationController pushViewController:[[LoginController alloc] init] animated:YES];
        return;
    }
    [GlobalMethod NotHaveAlertServiceWithMothedName:AddFavFun_Url parmeter:@{@"classid" : _data[@"classid"], @"id" : _data[@"id"]} success:^(id responseObject) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:responseObject[@"info"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    } fail:^(NSError *error) {
    }];
}

- (void)buttonShare:(UIButton *)sender
{
    [UMSocialSnsService presentSnsIconSheetView:[Framework controllers].homePageVC
                                         appKey:@"559261b267e58e6cda001819"
                                      shareText:ShareWord
                                     shareImage:ImageWithName(@"icon.png")
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToRenren,UMShareToDouban,UMShareToSms,UMShareToEmail,nil]
                                       delegate:nil];
}
@end
