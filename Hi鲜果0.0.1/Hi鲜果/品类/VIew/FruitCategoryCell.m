//
//  FruitCategoryCell.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/29.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "FruitCategoryCell.h"
#import "CustomSeparator.h"

@implementation FruitCategoryCell

- (void)getFruitCategoryCell
{
    
    UIImageView *categoryImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, Screen_height / 7 - 10, Screen_height / 7 - 10)];
    categoryImageView.contentMode = UIViewContentModeScaleAspectFill;
    categoryImageView.image = ImageWithName(@"jiuzhuan.jpg");
    [self.contentView addSubview:categoryImageView];
    
    UILabel *category = [[UILabel alloc] initWithFrame:CGRectMake(Screen_height / 7, Screen_height / 7 / 5, Screen_width - Screen_height / 7 - 10, Screen_height / 7 / 5)];
    category.text = @"九转金丹";
    category.font = [UIFont systemFontOfSize:Screen_height / 35];
    [self.contentView addSubview:category];
    
    UILabel *categoryInfo = [[UILabel alloc] initWithFrame:CGRectMake(Screen_height / 7, Screen_height / 7 / 5 * 3, Screen_width - Screen_height / 7 - 10, Screen_height / 7 / 6)];
    categoryInfo.text = @"九转金丹,服用后可自动领悟神通-九转天功";
    categoryInfo.textColor = [UIColor lightGrayColor];
    categoryInfo.font = [UIFont systemFontOfSize:Screen_height / 45];
    [self.contentView addSubview:categoryInfo];
    
    
    
    
    CustomSeparator *separator = [[CustomSeparator alloc] initWithFrame:CGRectMake(Screen_height / 7, Screen_height / 7 - 1, Screen_width - Screen_height / 7, 1)];
    [self.contentView addSubview:separator];
}

@end
