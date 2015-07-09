//
//  SubmitOrderController.h
//  Hi鲜果
//
//  Created by rimi on 15/7/3.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubmitOrderController : BasicViewController
@property (strong, nonatomic) NSDictionary * address;
@property (assign, nonatomic, readonly) NSInteger orderTotalPrice;
- (void)switchValueChanged:(UISwitch *)sender;
@end
