//
//  FruitNumberPicker.h
//  Hi鲜果
//
//  Created by 李波 on 15/6/26.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FruitNumberPicker : UIView

@property (nonatomic, assign) NSInteger fruitsNum;
@property (nonatomic, strong) UILabel *fruitNum;

/**
 * 商品信息，如有则在点击加减时，网络请求加入购物车
 */
@property (strong, nonatomic) NSDictionary *classInfo;

- (instancetype)initWithPoint:(CGPoint)point;

@end
