//
//  FruitNumberPicker.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/26.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "FruitNumberPicker.h"

@interface FruitNumberPicker ()

- (void)initializeUserInterface;

@end

@implementation FruitNumberPicker

- (UILabel *)fruitNum
{
    if (_fruitNum == nil) {
        _fruitNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds) * 0.33, CGRectGetHeight(self.bounds) - 2)];
        _fruitNum.center = CGPointMake(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2 - 0.01);
        _fruitNum.textAlignment = NSTextAlignmentCenter;
        _fruitNum.textColor = [UIColor blackColor];
        _fruitNum.backgroundColor = [UIColor whiteColor];
        _fruitNum.text = [NSString stringWithFormat:@"%ld", (long)self.fruitsNum];
    }
    return _fruitNum;
}

- (instancetype)initWithPoint:(CGPoint)point
{
    self = [self initWithFrame:CGRectMake(point.x, point.y, Screen_width * 0.3, Screen_height * 0.2 * 0.25)];
    self.backgroundColor = [UIColor colorWithRed:1.000 green:0.502 blue:0.000 alpha:1.000];
    self.layer.cornerRadius = Screen_height / 51;
    [GlobalControl myControl].numPicker = self;
    [self initializeUserInterface];
    return self;
}

- (void)initializeUserInterface
{
    self.fruitsNum = 1;
    UIButton *numSub = [UIButton buttonWithType:UIButtonTypeCustom];
    numSub.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds) / 3, CGRectGetHeight(self.bounds));
    [numSub setImage:ImageWithName(@"fruit_jian.png") forState:UIControlStateNormal];
    
    [numSub addTarget:self action:@selector(numberSub:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:numSub];
    
    UIButton *numAdd = [UIButton buttonWithType:UIButtonTypeCustom];
    numAdd.frame = CGRectMake(CGRectGetWidth(self.bounds) - CGRectGetWidth(self.bounds) / 3, 0, CGRectGetWidth(self.bounds) / 3, CGRectGetHeight(self.bounds));
    [numAdd setImage:ImageWithName(@"fruit_jia.png") forState:UIControlStateNormal];
    [numAdd addTarget:self action:@selector(numberAdd:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:numAdd];
    
    
    [self addSubview:self.fruitNum];
}

- (void)numberSub:(UIButton *)sender
{
    if (self.fruitsNum > 1) {
        self.fruitsNum --;
        self.fruitNum.text = [NSString stringWithFormat:@"%ld", (long)self.fruitsNum];
        if (self.classInfo != nil) {
            [self changeNumberRequestWithClassInfo:self.classInfo num:-1];
        }
    }
}

- (void)numberAdd:(UIButton *)sender
{
    self.fruitsNum ++;
    self.fruitNum.text = [NSString stringWithFormat:@"%ld", (long)self.fruitsNum];
    if (self.classInfo != nil) {
        [self changeNumberRequestWithClassInfo:self.classInfo num:1];
    }
}

/**
 * 加减操作时，进行网络请求
 */
- (void)changeNumberRequestWithClassInfo:(NSDictionary *)classInfo num:(NSInteger)num{
    
    if (num == 1) {
        NSLog(@"商品数量为1了");
    }
    [GlobalMethod serviceWithMothedName:AddCar_Url
                               parmeter:@{
                                          @"classid":classInfo[@"classid"],
                                          @"id":classInfo[@"id"],
                                          @"pn":@(num)}
                                success:^(id responseObject) {
                                    NSLog(@"---->加购物车成功");
                                    [self getCartInfo];
                                }
                                   fail:^(NSError *error) {
                                       
                                   }];
}

- (void)getCartInfo {
    
    [GlobalMethod serviceWithMothedName:GetCar_Url parmeter:nil success:^(id responseObject) {
        if (![responseObject[@"data"] isKindOfClass:[NSNull class]]) {
            // 注意返回的总价和个数是NSNumber
            NSLog(@"购物车总价为：%@", responseObject[@"totalmoney"]);
            // 更新购物车的总价
            [Framework controllers].shoppingCartVC.toolBar.totalPrice = [responseObject[@"totalmoney"] integerValue];
        } else {
            NSLog(@"购物车内没有任何商品哦");
        }
    } fail:^(NSError *error) {}];
}

@end
