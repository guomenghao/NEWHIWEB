//
//  GlobalMethod.h
//  Hi鲜果
//
//  Created by 李波 on 15/6/28.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalMethod : NSObject


/**
 *  用来移除所有子视图
 *
 *  @param superView 当前需要移除子视图的父视图
 */
+ (void)removeAllSubViews:(UIView *)superView;

@end
