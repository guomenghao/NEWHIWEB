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
    shopCar.frame = CGRectMake(20, 5, 34, 34);
    shopCar.backgroundColor = [UIColor orangeColor];
    [shopCar addTarget:self action:@selector(addShopCar:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:shopCar];
    
    
    UIButton *addShopCar = [UIButton buttonWithType:UIButtonTypeCustom];
    addShopCar.frame = CGRectMake(Screen_width * 0.55, 5, Screen_width * 0.4, 34);
    addShopCar.backgroundColor = [UIColor orangeColor];
    addShopCar.layer.cornerRadius = 17;
    [addShopCar addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addShopCar];
    
}

- (void)addShopCar:(UIButton *)sender
{
    
    NSLog(@"%ld", (long)[GlobalControl myControl].numPicker.fruitsNum);
}


@end
