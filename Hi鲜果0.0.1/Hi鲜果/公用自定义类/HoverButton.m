//
//  HoverButton.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/29.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "HoverButton.h"

@interface HoverButton () {
    BOOL _isLike;
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

- (void)initializeUserInterfaceWithLike:(BOOL)like controller:(UIViewController *)controller
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 35, 35);
    [backButton setImage:ImageWithName(@"back_0.png") forState:UIControlStateNormal];
    [backButton setImage:ImageWithName(@"back_0.png") forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(backView:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backButton];
    self.viewController = controller;
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(CGRectGetWidth(self.bounds) - 35, 0, 35, 35);
    [shareButton addTarget:self action:@selector(buttonShare:) forControlEvents:UIControlEventTouchUpInside];
    [shareButton setImage:ImageWithName(@"fenxiang_0.png") forState:UIControlStateNormal];
    [self addSubview:shareButton];
    
    if (like) {
        UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        likeButton.frame = CGRectMake(CGRectGetWidth(self.bounds) - 90, 1.5, 32, 32);
        [likeButton addTarget:self action:@selector(buttonLike:) forControlEvents:UIControlEventTouchUpInside];
        /**
         *  如果账号中当前商品是喜欢状态
         */
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
    if (_isLike) {
        [sender setImage:ImageWithName(@"shoucang_0.png") forState:UIControlStateNormal];
        [sender setImage:ImageWithName(@"shoucang_0.png") forState:UIControlStateHighlighted];
        _isLike = NO;
    } else {
        [sender setImage:ImageWithName(@"shoucang_1.png") forState:UIControlStateNormal];
        [sender setImage:ImageWithName(@"shoucang_1.png") forState:UIControlStateHighlighted];
        _isLike = YES;
    }
}

- (void)buttonShare:(UIButton *)sender
{
    [UMSocialSnsService presentSnsIconSheetView:[Framework controllers].homePageVC
                                         appKey:@"559261b267e58e6cda001819"
                                      shareText:@"你要分享的文字"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToRenren,UMShareToDouban,UMShareToSms,UMShareToEmail,nil]
                                       delegate:nil];
}
@end
