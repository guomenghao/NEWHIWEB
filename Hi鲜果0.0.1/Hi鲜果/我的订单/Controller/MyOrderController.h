//
//  MyOrderController.h
//  Hi鲜果
//
//  Created by 李波 on 15/7/2.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderController : BasicViewController
/**确认订单*/
- (void)cellAtIndex:(NSInteger)index confirmOrder:(NSString *)orderID;

@end
