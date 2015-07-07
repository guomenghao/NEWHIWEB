//
//  AddrInfoController.h
//  Hi鲜果
//
//  Created by 李波 on 15/7/5.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "BasicViewController.h"

@interface AddrInfoController : BasicViewController

@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, assign) int index;
@property (nonatomic, assign) BOOL isAmend;

- (instancetype)initWithData:(NSDictionary *)data isAmend:(BOOL)amend index:(int)index;

@end
