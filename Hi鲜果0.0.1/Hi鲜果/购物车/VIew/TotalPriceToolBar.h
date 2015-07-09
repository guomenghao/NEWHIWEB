//
//  CartToolBar.h
//  Hi鲜果
//
//  Created by rimi on 15/7/3.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TotalPriceToolBarDelegate <NSObject>
/**告诉代理可以提交订单了*/
- (void)shouldSubmitOrder;

@end

@interface TotalPriceToolBar : UIView
@property (assign, nonatomic) NSInteger totalPrice;
@property (weak, nonatomic) id<TotalPriceToolBarDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame submitTitle:(NSString *)title;

@end
