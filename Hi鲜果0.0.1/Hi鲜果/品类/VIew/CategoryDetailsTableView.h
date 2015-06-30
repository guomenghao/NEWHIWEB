//
//  CategoryDetailsTableView.h
//  Hi鲜果
//
//  Created by 李波 on 15/6/29.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryDetailsTableView : UITableView

@property (nonatomic, strong) NSArray *dataSourceArray;
- (instancetype)initWithView:(UIView *)view;

@end
