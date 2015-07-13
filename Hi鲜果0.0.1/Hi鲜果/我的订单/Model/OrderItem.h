//
//  OrderItem.h
//  Hi鲜果
//
//  Created by rimi on 15/7/10.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderItem : NSObject

@property (strong, nonatomic) NSString * ddno;

@property (strong, nonatomic) NSString * ddtime;

@property (strong, nonatomic) NSString * havePrice;

@property (strong, nonatomic) NSString * picture;

@property (assign, nonatomic) BOOL isChecked;

- (instancetype)initWithInfo:(NSDictionary *)info;
@end
