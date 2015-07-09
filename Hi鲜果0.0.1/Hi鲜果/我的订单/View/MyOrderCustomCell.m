//
//  MyOrderCustomCell.m
//  Hi鲜果
//
//  Created by 李波 on 15/7/2.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "MyOrderCustomCell.h"

@interface MyOrderCustomCell ()

@property (nonatomic, strong) UIImageView *fruitImageView;
@property (nonatomic, strong) UILabel *number;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *status;
@property (nonatomic, strong) UIView *background;

@end

@implementation MyOrderCustomCell

- (UIView *)background
{
    if (_background == nil) {
        _background = [[UIView alloc] initWithFrame:CGRectMake(Screen_width / 37.5, Screen_width / 37.5, Screen_width - Screen_width / 44 * 2, Screen_height / 4.5 - Screen_width / 44 * 2)];
        _background.layer.borderColor = [UIColor orangeColor].CGColor;
        _background.layer.borderWidth = Screen_height / 500;
        _background.layer.cornerRadius = Screen_height / 100;
    }
    return _background;
}

- (UIImageView *)fruitImageView
{
    if (_fruitImageView == nil) {
        _fruitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(Screen_width / 43 * 2, Screen_width / 40.5 * 2, CGRectGetHeight(self.background.bounds) - Screen_width / 44 * 2, CGRectGetHeight(self.background.bounds) - Screen_width / 44 * 2)];
        _fruitImageView.backgroundColor = [UIColor orangeColor];
        _fruitImageView.layer.cornerRadius = Screen_height / 100;
    }
    return _fruitImageView;
}

- (UILabel *)time
{
    if (_time == nil) {
        _time = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.fruitImageView.frame) + Screen_width / 37.5, Screen_height / 4.5 / 2 - Screen_height / 25 / 2 - Screen_height / 25 - Screen_height / 25 / 3, Screen_width - CGRectGetMaxX(self.fruitImageView.frame) - Screen_width / 37.5 * 3, Screen_height / 25)];
        _time.font = [UIFont systemFontOfSize:Screen_height / 37];
        if (Screen_height != 480) {
            _time.font = [UIFont systemFontOfSize:Screen_height / 48];
        }
    }
    return _time;
}

- (UILabel *)number
{
    if (_number == nil) {
        _number = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.fruitImageView.frame) + Screen_width / 37.5, CGRectGetMaxY(self.time.frame) + Screen_height / 25  / 2.5, Screen_width - CGRectGetMaxX(self.fruitImageView.frame) - Screen_width / 37.5 * 3, Screen_height / 25)];
        _number.font = self.time.font;
    }
    return _number;
}

- (UILabel *)status
{
    if (_status == nil) {
        _status = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.fruitImageView.frame) + Screen_width / 37.5, CGRectGetMaxY(self.number.frame) + Screen_height / 25  / 2.5, Screen_width - CGRectGetMaxX(self.fruitImageView.frame) - Screen_width / 37.5 * 3, Screen_height / 25)];
        _status.font = self.time.font;
    }
    return _status;
}


- (void)getOrderCellData:(NSDictionary *)data
{
    [self.contentView addSubview:self.background];
    
    [self.fruitImageView sd_setImageWithURL:nil placeholderImage:nil];
    [self.contentView addSubview:self.fruitImageView];
    
    self.time.text = [NSString stringWithFormat:@"下单时间：%@", data[@"ddtime"]];
    [self.contentView addSubview:self.time];
    self.number.text = [NSString stringWithFormat:@"订单编号：%@", data[@"ddno"]];
    [self.contentView addSubview:self.number];
    if ([data[@"haveprice"] integerValue] == 1) {
        self.status.text = [NSString stringWithFormat:@"订单状态：%@", @"已收货"];
    } else {
        self.status.text = [NSString stringWithFormat:@"订单状态：%@", @"待收货"];
    }
    
    [self.contentView addSubview:self.status];
}
@end
