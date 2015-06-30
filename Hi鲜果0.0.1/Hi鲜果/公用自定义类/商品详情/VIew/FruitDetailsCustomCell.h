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


- (void)getScrollViewCell;
- (void)getFruitInfoCell;
- (void)getUnitCell;
- (void)getEvaluateCell;

@end
