//
//  CartModel.h
//  Hi鲜果
//
//  Created by 吕玉梅 on 15/6/29.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CartModel : NSObject
/**加入购物车的商品*/
@property (strong, nonatomic) NSMutableArray *goods;

@end