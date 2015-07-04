//
//  CartCell.h
//  Hi鲜果
//
//  Created by 吕玉梅 on 15/6/29.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fruit.h"
typedef NS_ENUM(NSInteger, CartCellType) {
    CartCellTypeCart = 0,//购物车中的cell
    CartCellTypeSubmit,//提交订单中的cell
};
@interface CartCell : UITableViewCell
@property (strong, nonatomic) Fruit * fruit;
@property (assign, nonatomic) CartCellType type;
@end
