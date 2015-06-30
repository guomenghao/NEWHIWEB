//
//  FruitDetailsCustomCell.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/26.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "FruitDetailsCustomCell.h"
#import "DetailsScrollView.h"
#import "FruitNumberPicker.h"
#import "EvaluateView.h"
#import "FruitNameAndPrice.h"

@interface FruitDetailsCustomCell ()

@property (nonatomic, strong) UIView *separator;
@property (nonatomic, strong) EvaluateView *evaluateView;
@property (nonatomic, strong) FruitNameAndPrice *fruitNameAndPrice;
@property (nonatomic, strong) DetailsScrollView *detailsScrollView;

@end

@implementation FruitDetailsCustomCell

- (FruitNameAndPrice *)fruitNameAndPrice
{
    if (_fruitNameAndPrice == nil) {
        _fruitNameAndPrice = [[FruitNameAndPrice alloc] init];
    }
    return _fruitNameAndPrice;
}

- (EvaluateView *)evaluateView
{
    if (_evaluateView == nil) {
        _evaluateView = [[EvaluateView alloc] init];
    }
    return _evaluateView;
}

- (UIView *)separator
{
    if (_separator == nil) {
        _separator = [[UIView alloc] init];
        _separator.backgroundColor = [UIColor lightGrayColor];
    }
    return _separator;
}

- (UILabel *)fruitUnit
{
    if (_fruitUnit == nil) {
        _fruitUnit = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, Screen_width - 24, Screen_height / 20)];
        _fruitUnit.font = [UIFont systemFontOfSize:Screen_height / 45];
    }
    return _fruitUnit;
}

- (DetailsScrollView *)detailsScrollView
{
    if (_detailsScrollView == nil) {
        _detailsScrollView = [[DetailsScrollView alloc] initWithArray:@[@"1.jpg", @"2.jpg", @"3.jpg"]];

    }
    return _detailsScrollView;
}

- (void)getScrollViewCellData:(NSDictionary *)data
{
    [self.contentView addSubview:self.detailsScrollView];
}


- (void)getFruitInfoCellData:(NSDictionary *)data
{
    [self.fruitNameAndPrice getFruitInfo:data];
    [self.contentView addSubview:self.fruitNameAndPrice];
    FruitNumberPicker *fruitNumpicker = [[FruitNumberPicker alloc] initWithPoint:CGPointMake(Screen_width * 0.65 - 5, Screen_height * 0.15 * 0.55)];
    [self.contentView addSubview:fruitNumpicker];
    
    self.separator.frame = CGRectMake(0, Screen_height * 0.15 - 0.5, Screen_width, 0.5);
    [self.contentView addSubview:self.separator];
}

- (void)getUnitCellData:(NSDictionary *)data
{
    self.fruitUnit.text = [NSString stringWithFormat:@"规格：%@", @"个"];
    [self.contentView addSubview:self.fruitUnit];
    self.separator.frame = CGRectMake(0, Screen_height / 20 - 0.5, Screen_width, 0.5);
    [self.contentView addSubview:self.separator];
}


- (void)getEvaluateCellData:(NSDictionary *)data
{
    [self.contentView addSubview:self.evaluateView];
    [self.evaluateView getStarLevel:99];
}









@end
