//
//  FlexibleFrame.h
//  屏幕适配
//
//  Created by rimi on 15/6/26.
//  Copyright (c) 2015年 吕玉梅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface FlexibleFrame : NSObject
/**宽高比值*/
+ (CGSize)ratios;
/**传入视图在iPhone5下的尺寸，返回当前屏幕下的尺寸*/
+ (CGRect)frameWithIPhone5Frame:(CGRect)iPhone5Frame;
@end
