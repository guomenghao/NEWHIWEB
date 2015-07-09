//
//  FruitNameAndPrice.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/28.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "FruitNameAndPrice.h"

@implementation FruitNameAndPrice


- (UILabel *)RMB
{
    if (_RMB == nil) {
        _RMB = [[UILabel alloc] initWithFrame:CGRectMake(10, Screen_height * 0.15 * 0.55 + Screen_height * 0.2 * 0.24 / 2, Screen_width / 30, Screen_height * 0.2 * 0.25 / 2.8)];
        _RMB.textColor = [UIColor orangeColor];
        _RMB.font = [UIFont boldSystemFontOfSize:Screen_height / 45];
    }
    return _RMB;
}

- (UILabel *)fruitName
{
    if (_fruitName == nil) {
        _fruitName = [[UILabel alloc] initWithFrame:CGRectMake(12, 10, Screen_width - 24, Screen_height * 0.2 * 0.2)];
        _fruitName.font = [UIFont systemFontOfSize:Screen_height / 35];
    }
    return _fruitName;
}

- (UILabel *)fruitPrice
{
    if (_fruitPrice == nil) {
        _fruitPrice = [[UILabel alloc] initWithFrame:CGRectMake(10 + Screen_width / 30 + 2, Screen_height * 0.15 * 0.55, Screen_width * 0.3, Screen_height * 0.2 * 0.25)];
        _fruitPrice.textColor = [UIColor orangeColor];
        _fruitPrice.font = [UIFont boldSystemFontOfSize:Screen_height / 25];
    }
    return _fruitPrice;
}

- (UILabel *)original
{
    if (_original == nil) {
        _original = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.fruitPrice.bounds) - 5, Screen_height * 0.15 * 0.55 + Screen_height * 0.2 * 0.22 / 2, Screen_width / 5, Screen_height * 0.2 * 0.25 / 2.8)];
        _original.textColor = [UIColor colorWithWhite:0.298 alpha:1.000];
        _original.font = [UIFont boldSystemFontOfSize:Screen_height / 45];
        _original.textAlignment = NSTextAlignmentLeft;
        
    }
    return _original;
}

- (void)getFruitInfo:(NSDictionary *)info
{
    self.frame = CGRectMake(0, 0, Screen_width, Screen_height * 0.15);
    
    self.fruitName.text = @"老成都盖碗茶";//info[@"title"];
    self.RMB.text = @"￥";
    self.fruitPrice.text = info[@"price"];
    [self addSubview:self.RMB];
    [self addSubview:self.fruitName];
    [self addSubview:self.fruitPrice];
    
    
    /**
     *  如果info中有打折状态
     */
    if (info[@"tprice"] && ![info[@"price"] isEqual:info[@"tprice"]]) {
        NSAttributedString *attstr = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@", info[@"tprice"]] attributes:@{NSStrikethroughStyleAttributeName : @1}];
        self.original.attributedText = attstr;
        [self addSubview:self.original];
    
    }
    
}

@end
