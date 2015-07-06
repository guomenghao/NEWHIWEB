//
//  ChangeHeadImage.m
//  Hi鲜果
//
//  Created by 李波 on 15/7/3.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "ChangeHeadImage.h"

@interface ChangeHeadImage () {
    NSArray *_headImages;
}

@end

@implementation ChangeHeadImage

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, Screen_width / 1.2, Screen_height / 1.85);
        self.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.000];
        self.layer.cornerRadius = (Screen_height / 5 - 20) / 2;
        [self initializeUserInterface];
    }
    return self;
}

- (void)initializeUserInterface
{
    _headImages = @[@"1", @"2", @"3", @"4", @"5", @"7", @"7", @"8", @"9"];
    for (int i = 0; i < 9; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((CGRectGetWidth(self.bounds) - Screen_height / 8.35 * 3) / 4 + (i % 3) * (Screen_height / 8.35 + (CGRectGetWidth(self.bounds) - Screen_height / 8.35 * 3) / 4), (CGRectGetHeight(self.bounds) - Screen_height / 8.35 * 3) / 4 + (i / 3) * (Screen_height / 8.35 + (CGRectGetHeight(self.bounds) - Screen_height / 8.35 * 3) / 4), Screen_height / 8.35, Screen_height / 8.35);
        NSString *headImage = [NSString stringWithFormat:@"T%@.png", _headImages[i]];
        [button setBackgroundImage:ImageWithName(headImage) forState:UIControlStateNormal];
        [button setTag:i + 200];
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    self.transform = CGAffineTransformMakeScale(0.01, 0.01);
    self.center = CGPointMake(Screen_width - (Screen_height / 5 + 10) / 2, 74 + (Screen_height / 5 - 20) / 2);
    [UIView animateWithDuration:0.7 animations:^{
        self.transform = CGAffineTransformIdentity;
        self.center = CGPointMake(Screen_width / 2, Screen_height / 2);
    }];
}

- (void)buttonPressed:(UIButton *)sender
{
    [User loginUser].tempHead = [NSString stringWithFormat:@"T%@.png", _headImages[sender.tag - 200]];
    [User loginUser].tempHeadImage.image = ImageWithName([User loginUser].tempHead);
    [UIView animateWithDuration:0.7 animations:^{
        self.transform = CGAffineTransformMakeScale(0.01, 0.01);
        self.center = CGPointMake(Screen_width - (Screen_height / 5 + 10) / 2, 74 + (Screen_height / 5 - 20) / 2);
    } completion:^(BOOL finished) {
        [GlobalControl myControl].tableView.userInteractionEnabled = YES;
        [self removeFromSuperview];
    }];
}

@end
