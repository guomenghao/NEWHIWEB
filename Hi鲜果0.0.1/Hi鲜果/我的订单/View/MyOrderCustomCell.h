//
//  MyOrderCustomCell.h
//  Hi鲜果
//
//  Created by 李波 on 15/7/2.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderCustomCell : UITableViewCell
/**标记cell的行数*/
@property (assign, nonatomic) NSInteger row;
- (void)getOrderCellData:(NSDictionary *)data;

@end
