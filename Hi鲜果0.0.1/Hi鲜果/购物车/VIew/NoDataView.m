//
//  NoDataView.m
//  Hi鲜果
//
//  Created by rimi on 15/7/3.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "NoDataView.h"
#define Margin 15*[FlexibleFrame ratios].height
@implementation NoDataView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 添加"去首页逛逛"按钮
        UIButton * goHomePageButton = ({
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.bounds = CGRectMake(0, 0, 100 * [FlexibleFrame ratios].width, 30);
            button.center = CGPointMake(Screen_width / 2, self.bounds.size.height / 2);
            button.backgroundColor = BtnBkColor;
            button.titleLabel.font = MiddleFont;
            [button setTitle:@"去首页逛逛" forState:UIControlStateNormal];
            button.layer.cornerRadius = button.bounds.size.width / 8;
            [button addTarget:self action:@selector(goHomePageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
        [self addSubview:goHomePageButton];
        
        // 添加提示语
        UILabel * tips = ({
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
            label.center = CGPointMake(goHomePageButton.center.x, CGRectGetMinY(goHomePageButton.frame) - Margin - label.bounds.size.height / 2);
            label.textAlignment = NSTextAlignmentCenter;
            label.font = MiddleFont;
            label.text = @"您的购物车还是空的哦";
            label.textColor = [UIColor lightGrayColor];
            label;
        });
        [self addSubview:tips];
        
        // 添加图片
        UIImageView * imageView = ({
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 128*[FlexibleFrame ratios].height, 128*[FlexibleFrame ratios].height)];
            imageView.image = ImageWithName(@"cart-nodata.png");
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.center = CGPointMake(goHomePageButton.center.x, CGRectGetMinY(tips.frame) - Margin - imageView.bounds.size.height / 2);
            imageView;
        });
        [self addSubview:imageView];
    }
    return self;
}

- (void)goHomePageButtonPressed:(UIButton *)sender {
    
    [Framework controllers].rootViewController.selectedIndex = 0;
}
@end
