//
//  MyAttentionCell.m
//  Hi鲜果
//
//  Created by 李波 on 15/7/8.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "MyAttentionCell.h"
#import "CustomSeparator.h"

@implementation MyAttentionCell
- (UILabel *)RMB
{
    if (_RMB == nil) {
        _RMB = [[UILabel alloc] initWithFrame:CGRectMake(Screen_height / 5, Screen_height / 5 * 0.8, Screen_width / 30, Screen_height * 0.2 * 0.25 / 2.8)];
        _RMB.textColor = [UIColor orangeColor];
        _RMB.font = [UIFont boldSystemFontOfSize:Screen_height / 45];
    }
    return _RMB;
}


- (UILabel *)fruitPrice
{
    if (_fruitPrice == nil) {
        _fruitPrice = [[UILabel alloc] initWithFrame:CGRectMake(Screen_height / 5 + Screen_width / 30 + 2, Screen_height / 5 * 0.68, Screen_width * 0.3, Screen_height * 0.2 * 0.25)];
        _fruitPrice.textColor = [UIColor orangeColor];
        _fruitPrice.font = [UIFont boldSystemFontOfSize:Screen_height / 25];
    }
    return _fruitPrice;
}

- (UILabel *)original
{
    if (_original == nil) {
        _original = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.fruitPrice.frame) - 25, Screen_height / 5 * 0.8 - 1, Screen_width / 5, Screen_height * 0.2 * 0.25 / 2.8)];
        _original.textColor = [UIColor colorWithWhite:0.298 alpha:1.000];
        _original.font = [UIFont boldSystemFontOfSize:Screen_height / 45];
        _original.textAlignment = NSTextAlignmentLeft;
        
    }
    return _original;
}
- (void)getCategoryDetailsCelldata:(NSDictionary *)data
{
    NSString *url = [Base_Url stringByAppendingPathComponent:data[@"titlepic"]];
    UIImageView *categoryImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, Screen_height / 5 - 10, Screen_height / 5 - 10)];
    [categoryImageView sd_setImageWithURL:[NSURL URLWithString:url]];
    [self.contentView addSubview:categoryImageView];
    
    UILabel *category = [[UILabel alloc] initWithFrame:CGRectMake(Screen_height / 5, Screen_height / 5 / 15, Screen_width - Screen_height / 5 - 10, Screen_height / 5 / 5)];
    category.text = data[@"title"];
    category.font = [UIFont systemFontOfSize:Screen_height / 35];
    [self.contentView addSubview:category];
    
    UILabel *categoryInfo = [[UILabel alloc] initWithFrame:CGRectMake(Screen_height / 5, Screen_height / 16, Screen_width - Screen_height / 5 - 10, Screen_height / 5 / 6)];
    categoryInfo.text = [NSString stringWithFormat:@"单位：%@", data[@"unit"]];
    categoryInfo.textColor = [UIColor lightGrayColor];
    categoryInfo.font = [UIFont systemFontOfSize:Screen_height / 45];
    [self.contentView addSubview:categoryInfo];
    
    
    self.RMB.text = @"￥";
    self.fruitPrice.text = data[@"price"];
    [self.contentView addSubview:self.RMB];
    [self.contentView addSubview:self.fruitPrice];
    
    
  
    CustomSeparator *separator = [[CustomSeparator alloc] initWithFrame:CGRectMake(0, Screen_height / 5 - 0.5, Screen_width, 0.5)];
    [self.contentView addSubview:separator];
}

@end
