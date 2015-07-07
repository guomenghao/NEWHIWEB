//
//  FruitNumberPicker.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/26.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "FruitNumberPicker.h"

@interface FruitNumberPicker () <UIAlertViewDelegate>

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
    if (self.fruitsNum == 1) {
        if (self.classInfo != nil) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"是否删除该商品？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"删除",nil];
            alert.tag = 2000;
            [alert show];
        }
    }
    
    if (self.fruitsNum > 1) {
        self.fruitsNum --;
        self.fruitNum.text = [NSString stringWithFormat:@"%ld", (long)self.fruitsNum];
        if (self.classInfo != nil) {
            [self changeNumberRequestWithClassInfo:self.classInfo isdel:@"0"];
        }
    }
}

- (void)numberAdd:(UIButton *)sender
{
    self.fruitsNum ++;
    self.fruitNum.text = [NSString stringWithFormat:@"%ld", (long)self.fruitsNum];
    if (self.classInfo != nil) {
        [self changeNumberRequestWithClassInfo:self.classInfo isdel:@"0"];
    }
}

/**
 * 加减操作时，进行网络请求
 */
- (void)changeNumberRequestWithClassInfo:(NSDictionary *)classInfo isdel:(NSString *)isdel{
    
    [GlobalMethod serviceWithMothedName:EditCar_Url
                               parmeter:@{
                                          @"classid":classInfo[@"classid"],
                                          @"id":classInfo[@"id"],
                                          @"num":@(self.fruitsNum),
                                          @"isdel":isdel}
                                success:^(id responseObject) {
                                    if (![responseObject[@"data"] isKindOfClass:[NSNull class]]) {
                                        [self getCartInfo];
                                    }
                                }
                                   fail:^(NSError *error) {}];
}

- (void)getCartInfo {
    
    [GlobalMethod NotHaveAlertServiceWithMothedName:GetCar_Url parmeter:nil success:^(id responseObject) {
        if (![responseObject[@"data"] isKindOfClass:[NSNull class]]) {
            [Framework controllers].shoppingCartVC.toolBar.totalPrice = [responseObject[@"totalmoney"] integerValue];
        } else {
            [[Framework controllers].shoppingCartVC.dataSource removeAllObjects];
            [[Framework controllers].shoppingCartVC showNoDataView];
        }
    } fail:^(NSError *error) {}];
}

#pragma mark - <UIAlertViewDelegate>
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 2000 && buttonIndex == 1) {//确定删除该商品
        [self changeNumberRequestWithClassInfo:self.classInfo isdel:@"1"];
    }
}

@end
