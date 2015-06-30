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

- (void)getFruitCategoryCellData:(NSDictionary *)data
{
    
    
    
    UILabel *category = [[UILabel alloc] initWithFrame:CGRectMake(Screen_height / 7, Screen_height / 7 / 5, Screen_width - Screen_height / 7 - 10, Screen_height / 7 / 5)];
    category.text = data[@"fruitname"];
    category.font = [UIFont systemFontOfSize:Screen_height / 35];
    [self.contentView addSubview:category];
    
    UILabel *categoryInfo = [[UILabel alloc] initWithFrame:CGRectMake(Screen_height / 7, Screen_height / 7 / 5 * 3, Screen_width - Screen_height / 7 - 10, Screen_height / 7 / 6)];
    categoryInfo.text = data[@"title"];
    categoryInfo.textColor = [UIColor lightGrayColor];
    categoryInfo.font = [UIFont systemFontOfSize:Screen_height / 45];
    [self.contentView addSubview:categoryInfo];
    
    
    
    
    CustomSeparator *separator = [[CustomSeparator alloc] initWithFrame:CGRectMake(Screen_height / 7, Screen_height / 7 - 1, Screen_width - Screen_height / 7, 1)];
    [self.contentView addSubview:separator];
}

@end
