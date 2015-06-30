//
//  Fruit.h
//  Hi鲜果
//
//  Created by rimi on 15/6/30.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fruit : NSObject
/**商品(水果)ID*/
@property (strong, nonatomic, readonly) NSString * ID;
/**水果照片*/
@property (strong, nonatomic, readonly) NSString * pic;
/**水果名称*/
@property (strong, nonatomic, readonly) NSString * name;
/**水果规格(单位)*/
@property (strong, nonatomic, readonly) NSString * unit;
/**水果原价*/
@property (strong, nonatomic, readonly) NSString * originalPrice;
/**打折后的价格(若有)*/
@property (strong, nonatomic, readonly) NSString * discountPrice;
/**便利初始化所有信息*/
@property (strong, nonatomic) NSDictionary * info;
/**或者使用初始化方法，直接赋值*/
- (instancetype)initWithInfo:(NSDictionary *)info;
@end
