//
//  GlobalMethod.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/28.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "GlobalMethod.h"

@interface GlobalMethod () <UIAlertViewDelegate>


@end

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
    [view.layer insertSublayer:maskLayer atIndex:0];
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
    
    __block UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Loading..." message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [alert show];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    
    NSString *url = [Base_Url stringByAppendingPathComponent:mothedName];
    
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    [manager GET:url parameters:parmeter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [alert dismissWithClickedButtonIndex:0 animated:YES];
        if ([responseObject isKindOfClass:[NSDictionary class]] && [responseObject[@"info"] isEqual:@"用户未登录！"]) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"登录失效，请重新登陆" delegate:[UIApplication sharedApplication].delegate cancelButtonTitle:@"确定" otherButtonTitles:nil];
            alert.tag = 900;
            [alert show];
        } else {
            succeedBlock(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error.localizedDescription);
        [alert dismissWithClickedButtonIndex:0 animated:YES];
        alert = nil;
        alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络连接失败，请稍后再试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
        failBlock(error);
    }];
}

+ (void)NotHaveAlertServiceWithMothedName:(NSString *)mothedName parmeter:(id)parmeter success:(void (^)(id responseObject))succeedBlock fail:(void (^)(NSError *error))failBlock
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    
    NSString *url = [Base_Url stringByAppendingPathComponent:mothedName];
    
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    [manager GET:url parameters:parmeter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]] && [responseObject[@"info"] isEqual:@"用户未登录！"]) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"登录失效，请重新登陆" delegate:[UIApplication sharedApplication].delegate cancelButtonTitle:@"确定" otherButtonTitles:nil];
            alert.tag = 900;
            [alert show];
        } else {
            succeedBlock(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"服务器连接失败，请稍后再试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        failBlock(error);
    }];
}

/**
 *  刷新用户数据
 */
+ (void)getUserInfoSuccess:(void (^)(id responseObject))succeedBlock
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    
    NSString *url = [Base_Url stringByAppendingPathComponent:GetUserInfo_Url];
    
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        if ([responseObject[@"err_msg"] isEqual:@"success"]) {
            [User loginUser].isLogin = YES;
            [[User loginUser] getUserInfo:responseObject];
            succeedBlock(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"服务器连接失败，请稍后再试" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [alert show];
    }];
}

#pragma mark - 正则表达式验证
//邮箱
+ (BOOL) validateEmail:(NSString *)email
{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//手机号码验证
/*
 移动号段：134、135、136、137、138、139、150、151、152、157、158、159、182、183、184、187、188、178（4G)、147号段；
 联通号段：130、131、132、155、156、185、186、176（4G)、145号段；
 电信号段：133、153、180、181、189、177（4G)号段
 */
+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(147)|(17[6-8])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

//用户名
+ (BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}

//密码
+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,16}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}

// 定义成方法方便多个label调用 增加代码的复用性
+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font maxWidth:(CGFloat)width maxHeight:(CGFloat)height
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, height)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
}

+ (float)getIOSVersion
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}


@end
