//
//  EvaluateView.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/27.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "EvaluateView.h"

@implementation EvaluateView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, Screen_width, Screen_height / 10);
//        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

- (void)getStarLevel:(int)level
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) / 2)];
    label.text = @"商品评价：";
    label.font = [UIFont systemFontOfSize:Screen_height / 45];
    [self addSubview:label];
    for (int i = 0; i < 5; i ++) {
        UIImageView *star = [[UIImageView alloc] initWithFrame:CGRectMake(12 + CGRectGetHeight(self.bounds) / 2 * 0.9 * i, CGRectGetHeight(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2* 0.8, CGRectGetHeight(self.bounds) / 2 * 0.8)];
        star.image = ImageWithName(@"star_0.png");
        if (i < level) {
            star.image = ImageWithName(@"star_2.png");
        }
        [self addSubview:star];
    }
}



@end
