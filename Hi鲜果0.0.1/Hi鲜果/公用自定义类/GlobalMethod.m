//
//  GlobalMethod.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/28.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "GlobalMethod.h"

@implementation GlobalMethod


/**
 *  给UIView设置任意两个圆角
 */

+ (void)rectWithView:(UIView *)view corners1:(UIRectCorner)corners1 corners2:(UIRectCorner)corners2 radius:(CGFloat)radius lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor fillColor:(UIColor *)fillColor
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corners1 | corners2 cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.strokeColor = lineColor.CGColor;
    maskLayer.lineWidth = lineWidth;
    maskLayer.fillColor = fillColor.CGColor;
    maskLayer.path = maskPath.CGPath;
    [view.layer addSublayer:maskLayer];
}

+ (void)view:(UIView *)view lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor fillColor:(UIColor *)fillColor
{
    
    for (NSObject *layer in view.layer.sublayers) {
        if ([layer isKindOfClass:[CAShapeLayer class]]) {
            [(CAShapeLayer *)layer setStrokeColor:lineColor.CGColor];
            [(CAShapeLayer *)layer setFillColor:fillColor.CGColor];
            [(CAShapeLayer *)layer setLineWidth:lineWidth];
        }
    }
}


/**
 *  移除所有子视图
 */
+ (void)removeAllSubViews:(UIView *)superView
{
    for (UIView *view in superView.subviews) {
        [view removeFromSuperview];
    }
}

/**
 *  网络请求(无sid)
 */
+ (void)serviceWithMothedName:(NSString *)mothedName parmeter:(id)parmeter success:(void (^)(id responseObject))succeedBlock fail:(void (^)(NSError *error))failBlock
{
    
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    
    NSString *url = [Base_Url stringByAppendingPathComponent:mothedName];
    
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    [manager GET:url parameters:parmeter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        succeedBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failBlock(error);
    }];
    
//    [manager POST:url parameters:parmeter success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        succeedBlock(responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failBlock(error);
//    }];
    
    
    
}

@end
