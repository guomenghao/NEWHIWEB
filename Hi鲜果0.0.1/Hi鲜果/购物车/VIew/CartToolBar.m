//
//  CartToolBar.m
//  Hi鲜果
//
//  Created by rimi on 15/7/3.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "CartToolBar.h"
#import "SubmitOrderController.h"
#define Margin 10
@interface CartToolBar ()
@property (strong, nonatomic) UILabel * totalPriceLabel;
- (void)initializeUserInterface;
- (void)updatePriceLabel;
/**立即结算按钮点击事件*/
- (void)settleButtonPressed:(UIButton *)sender;
@end

@implementation CartToolBar

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeUserInterface];
    }
    return self;
}

- (void)initializeUserInterface {
    
    self.backgroundColor = RGBAColor(255, 255, 255, 0.8);
    [self addSubview:self.totalPriceLabel];
    // 添加"立即结算"按钮
    UIButton * button = ({
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(Screen_width - Margin - 100 * [FlexibleFrame ratios].width, 0, 100 * [FlexibleFrame ratios].width, 30);
        button.center = CGPointMake(button.center.x, self.totalPriceLabel.center.y);
        button.backgroundColor = BtnBkColor;
        [button setTitle:@"立即结算" forState:UIControlStateNormal];
        button.layer.cornerRadius = button.bounds.size.width / 8;
        [button addTarget:self action:@selector(settleButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self addSubview:button];
}

- (void)setTotalPrice:(NSInteger)totalPrice {
    
    _totalPrice = totalPrice;
    [self updatePriceLabel];
}
- (void)updatePriceLabel {
    NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%ld", (long)_totalPrice]];
    // 现价富文本属性
    NSDictionary * attrs1 = @{
                              NSFontAttributeName:LargeFont,
                              NSForegroundColorAttributeName:[UIColor orangeColor]
                              };
    [attrString addAttribute:NSFontAttributeName value:SmallFont range:NSMakeRange(0, 1)];
    [attrString addAttributes:attrs1 range:NSMakeRange(1, attrString.length - 1)];
    self.totalPriceLabel.attributedText = attrString;
}

- (UILabel *)totalPriceLabel {
    
    if (_totalPriceLabel == nil) {
        _totalPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(Margin, 0, Screen_width / 2 - Margin, self.bounds.size.height)];
        _totalPriceLabel.textColor = [UIColor orangeColor];
    }
    return _totalPriceLabel;
}
// 立即结算按钮点击事件
- (void)settleButtonPressed:(UIButton *)sender {
    
    [[Framework controllers].shoppingCartVC.navigationController pushViewController:[[SubmitOrderController alloc] init] animated:YES];
}

@end
