//
//  FruitNameAndPrice.h
//  Hi鲜果
//
//  Created by 李波 on 15/6/28.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FruitNameAndPrice : UIView

@property (nonatomic, strong) UILabel *RMB;
@property (nonatomic, strong) UILabel *fruitName;
@property (nonatomic, strong) UILabel *fruitPrice;
@property (nonatomic, strong) UILabel *original;

- (void)getFruitInfo:(NSDictionary *)info;

@end
