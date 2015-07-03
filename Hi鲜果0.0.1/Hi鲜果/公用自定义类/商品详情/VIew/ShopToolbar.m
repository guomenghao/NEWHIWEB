//
//  ShopToolbar.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/26.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "ShopToolbar.h"
#import "FruitNumberPicker.h"

@interface ShopToolbar()

- (void)initializeUserInterface;

@end

@implementation ShopToolbar

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, Screen_height, Screen_width, 44);
        self.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
        [self initializeUserInterface];
    }
    return self;
}

- (void)initializeUserInterface
{
    UIButton *shopCar = [UIButton buttonWithType:UIButtonTypeCustom];
    shopCar.frame = CGRectMake(20, 2, 40, 40);
    [shopCar setImage:ImageWithName(@"gouwuche_0.png") forState:UIControlStateNormal];
    [shopCar addTarget:self action:@selector(addShopCar:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:shopCar];
    
    
    UIButton *forward = [UIButton buttonWithType:UIButtonTypeCustom];
    forward.frame = CGRectMake(Screen_width * 0.55, 5, Screen_width * 0.4, 34);
    forward.backgroundColor = [UIColor orangeColor];
    forward.layer.cornerRadius = 17;
    [forward setTitle:@"立即结账" forState:UIControlStateNormal];
    forward.titleLabel.font = [UIFont boldSystemFontOfSize:Screen_height / 40];
    [forward addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:forward];
    
}

- (void)addShopCar:(UIButton *)sender
{
    NSInteger number = (long)[GlobalControl myControl].numPicker.fruitsNum;
    [GlobalMethod serviceWithMothedName:AddCar_Url
                               parmeter:@{
                                          @"classid":self.classInfo[@"classid"],
                                          @"id":self.classInfo[@"id"],
                                          @"pn":[NSString stringWithFormat:@"%ld", (long)number]}
                                success:^(id responseObject) {
                                    
                                    NSLog(@"---->加购物车成功%@", responseObject);
    }
                                   fail:^(NSError *error) {
        
    }];
    //NSLog(@"%ld", (long)[GlobalControl myControl].numPicker.fruitsNum);
}

@end
