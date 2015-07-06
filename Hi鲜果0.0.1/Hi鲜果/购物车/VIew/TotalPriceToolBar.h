//
//  CartToolBar.h
//  Hi鲜果
//
//  Created by rimi on 15/7/3.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TotalPriceToolBar : UIView
@property (assign, nonatomic) NSInteger totalPrice;
- (instancetype)initWithFrame:(CGRect)frame submitTitle:(NSString *)title;
@end
