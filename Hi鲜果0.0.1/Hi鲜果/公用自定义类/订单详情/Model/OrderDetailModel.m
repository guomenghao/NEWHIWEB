//
//  OrderDetailModel.m
//  Hi鲜果
//
//  Created by 吕玉梅 on 15/7/12.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "OrderDetailModel.h"

@interface OrderDetailModel ()

@property (strong, nonatomic) NSString * orderID;
@end

@implementation OrderDetailModel

- (instancetype)initWithOrderID:(NSString *)orderID {
    self = [super init];
    if (self) {
            self.orderID = orderID;
            [GlobalMethod serviceWithMothedName:GetOrderDetail_Url parmeter:@{@"ddno":self.orderID} success:^(id responseObject) {
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    self.info = responseObject;
                }
            } fail:^(NSError *error) {}];
            }
    return self;
}

@end
