//
//  FruitDetailsCustomCell.h
//  Hi鲜果
//
//  Created by 李波 on 15/6/26.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FruitDetailsCustomCell : UITableViewCell

@property (nonatomic, strong) UILabel *fruitUnit;


- (void)getScrollViewCellData:(NSDictionary *)data;
- (void)getFruitInfoCellData:(NSDictionary *)data;
- (void)getUnitCellData:(NSDictionary *)data;
- (void)getEvaluateCellData:(NSDictionary *)data;

@end
