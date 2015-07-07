//
//  ShoppingCartController.h
//  Hi鲜果
//
//  Created by 李波 on 15/6/25.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TotalPriceToolBar.h"
@interface ShoppingCartController : BasicViewController
@property (strong, nonatomic) TotalPriceToolBar * toolBar;
/**编辑购物车信息时修改dataSource*/
@property (strong, nonatomic) NSMutableArray * dataSource;
- (void)requestData;
- (void)showNoDataView;
@end
