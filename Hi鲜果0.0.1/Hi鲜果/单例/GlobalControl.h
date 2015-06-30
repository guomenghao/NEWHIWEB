//
//  GlobalControl.h
//  Hi鲜果
//
//  Created by 李波 on 15/6/26.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GlobalControl : NSObject

+ (GlobalControl *)myControl;

@property (nonatomic, strong) UIPageControl *pageControl;

@end
