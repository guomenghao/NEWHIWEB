//
//  CategoryDetailsCell.h
//  Hi鲜果
//
//  Created by 李波 on 15/6/29.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryDetailsCell : UITableViewCell
@property (nonatomic, strong) UILabel *RMB;
@property (nonatomic, strong) UILabel *fruitPrice;
@property (nonatomic, strong) UILabel *original;

- (void)getCategoryDetailsCelldata:(NSDictionary *)data;
@end
