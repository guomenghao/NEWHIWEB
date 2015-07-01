//
//  EatRules.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/28.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "EatRules.h"

@interface EatRules ()

- (void)rulesText;

@end

@implementation EatRules

- (instancetype)initWithView:(UIView *)view
{
    self = [self initWithFrame:CGRectMake(10, CGRectGetMaxY(view.frame), CGRectGetWidth(view.bounds) - 20, Screen_height / 4.5)];
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    [self rulesText];
    return self;
}

- (void)rulesText
{
    NSMutableAttributedString *rules = [[NSMutableAttributedString alloc] initWithString:@"试吃规则\n\n1、试吃过程您无需支付任何费用\n2、提交申请后，可在我的账户—我的试吃申请查看是否申请成功\n3、试吃产品数量有限，每个免费试吃活动，同一用户仅限参与1次\n4、申请试吃之后分享到微博，转发次数越多试吃成功率越高\n5、申请成功的用户，我们将与2-3个工作日内免费将试吃品送到您申请时填写的收货地址\n6、收到试吃品后，需在30天内提交真实试吃报告，逾期未提交将无法享有试吃权利\n7、提交带有试吃产品图片的试吃报告，将提升您下次申请试吃成功的概率"];
    [rules addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:Screen_height / 40] range:NSMakeRange(0, 4)];
    [rules addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 4)];
    [rules addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:Screen_height / 45] range:NSMakeRange(6, rules.length - 6)];
    self.attributedText = rules;
}

- (BOOL)canBecomeFirstResponder
{
    return NO;
}

@end
