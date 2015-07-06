//
//  AutoDismissBox.m
//  Hi鲜果
//
//  Created by rimi on 15/7/3.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "AutoDismissBox.h"

@implementation AutoDismissBox

+ (void)showBoxWithTitle:(NSString *)title message:(NSString *)msg {
    
    AutoDismissBox * box = [[AutoDismissBox alloc] initWithFrame:CGRectMake(0, 0, 200*[FlexibleFrame ratios].width, 100*[FlexibleFrame ratios].height) title:title message:msg];
    box.center = CGPointMake(Screen_width / 2, Screen_height / 2);
    [box show];
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title message:(NSString *)msg
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RGBAColor(0, 0, 0, 0);
        // 修改圆角
        self.layer.cornerRadius = frame.size.width / 16;
        UILabel * titleLabel = ({
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height / 2)];
            label.text = title;
            label.font = LargeFont;
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor whiteColor];
            label;
        });
        [self addSubview:titleLabel];
        
        UILabel * msgLabel = ({
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height / 2, self.bounds.size.width, self.bounds.size.height / 2)];
            label.text = msg;
            label.font = MiddleFont;
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor whiteColor];
            label;
        });
        [self addSubview:msgLabel];
    }
    return self;
}

- (void)show {
    
    [[Framework controllers].rootViewController.view addSubview:self];
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor = RGBAColor(0, 0, 0, 0.8);
    } completion:^(BOOL finished) {
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1];
    }];
}

- (void)dismiss {
    
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor = RGBAColor(0, 0, 0, 0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
