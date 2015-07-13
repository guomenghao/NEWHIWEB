//
//  OrderDetailModel.h
//  Hi鲜果
//
//  Created by 吕玉梅 on 15/7/12.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderDetailModel : NSObject

@property (strong, nonatomic) NSDictionary * info;

- (instancetype)initWithOrderID:(NSString *)orderID;

@end
