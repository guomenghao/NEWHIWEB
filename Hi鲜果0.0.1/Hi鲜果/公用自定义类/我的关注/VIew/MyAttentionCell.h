//
//  MyAttentionCell.h
//  Hi鲜果
//
//  Created by 李波 on 15/7/8.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAttentionCell : UITableViewCell
@property (nonatomic, strong) UILabel *RMB;
@property (nonatomic, strong) UILabel *fruitPrice;
@property (nonatomic, strong) UILabel *original;

- (void)getCategoryDetailsCelldata:(NSDictionary *)data;

@end
