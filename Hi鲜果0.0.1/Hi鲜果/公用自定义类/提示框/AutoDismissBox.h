//
//  AutoDismissBox.h
//  Hi鲜果
//
//  Created by rimi on 15/7/3.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//
// 自动消失提示框
#import <UIKit/UIKit.h>

@interface AutoDismissBox : UIView
+ (void)showBoxWithTitle:(NSString *)title message:(NSString *)msg;
@end
