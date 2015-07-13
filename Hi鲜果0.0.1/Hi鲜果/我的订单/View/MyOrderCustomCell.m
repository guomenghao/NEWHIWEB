//
//  MyOrderCustomCell.m
//  Hi鲜果
//
//  Created by 李波 on 15/7/2.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "MyOrderCustomCell.h"

#define TagBase 6000
@interface MyOrderCustomCell ()

@property (nonatomic, strong) UIImageView *fruitImageView;
@property (nonatomic, strong) UILabel *number;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *status;
@property (nonatomic, strong) UIView *background;
@property (nonatomic, strong) NSString * ddno;
/**以下属性用于多选删除功能*/
@property (nonatomic, strong) UIImageView * checkImageView;
@property (nonatomic, assign) BOOL checked;
@end

@implementation MyOrderCustomCell

- (UIView *)background
{
    if (_background == nil) {
        _background = [[UIView alloc] initWithFrame:CGRectMake(Screen_width / 37.5, Screen_width / 37.5, Screen_width - Screen_width / 44 * 2, Screen_height / 4.5 - Screen_width / 44 * 2)];
        _background.layer.borderColor = [UIColor orangeColor].CGColor;
        _background.layer.borderWidth = Screen_height / 500;
        _background.layer.cornerRadius = Screen_height / 100;
    }
    return _background;
}

- (UIImageView *)fruitImageView
{
    if (_fruitImageView == nil) {
        _fruitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(Screen_width / 43 * 2, Screen_width / 40.5 * 2, CGRectGetHeight(self.background.bounds) - Screen_width / 44 * 2, CGRectGetHeight(self.background.bounds) - Screen_width / 44 * 2)];
        _fruitImageView.backgroundColor = [UIColor orangeColor];
        _fruitImageView.layer.cornerRadius = Screen_height / 100;
    }
    return _fruitImageView;
}

- (UILabel *)time
{
    if (_time == nil) {
        _time = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.fruitImageView.frame) + Screen_width / 37.5, Screen_height / 4.5 / 2 - Screen_height / 25 / 2 - Screen_height / 25 - Screen_height / 25 / 3, Screen_width - CGRectGetMaxX(self.fruitImageView.frame) - Screen_width / 37.5 * 3, Screen_height / 25)];
        _time.font = [UIFont systemFontOfSize:Screen_height / 37];
        if (Screen_height != 480) {
            _time.font = [UIFont systemFontOfSize:Screen_height / 48];
        }
    }
    return _time;
}

- (UILabel *)number
{
    if (_number == nil) {
        _number = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.fruitImageView.frame) + Screen_width / 37.5, CGRectGetMaxY(self.time.frame) + Screen_height / 25  / 2.5, Screen_width - CGRectGetMaxX(self.fruitImageView.frame) - Screen_width / 37.5 * 3, Screen_height / 25)];
        _number.font = self.time.font;
    }
    return _number;
}

- (UILabel *)status
{
    if (_status == nil) {
        _status = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.fruitImageView.frame) + Screen_width / 37.5, CGRectGetMaxY(self.number.frame) + Screen_height / 25  / 2.5, Screen_width - CGRectGetMaxX(self.fruitImageView.frame) - Screen_width / 37.5 * 3, Screen_height / 25)];
        _status.font = self.time.font;
    }
    return _status;
}

- (void)getOrderCellData:(OrderItem *)item
{
    self.ddno = item.ddno;
    [self.contentView addSubview:self.background];
    
    [self.fruitImageView sd_setImageWithURL:nil placeholderImage:nil];
    [self.contentView addSubview:self.fruitImageView];
    
    self.time.text = [NSString stringWithFormat:@"下单时间：%@", item.ddtime];
    [self.contentView addSubview:self.time];
    self.number.text = [NSString stringWithFormat:@"订单编号：%@", item.ddno];
    [self.contentView addSubview:self.number];
    if ([item.havePrice integerValue] == 1) {
        self.status.text = [NSString stringWithFormat:@"订单状态：%@", @"已收货"];
    } else {
        self.status.text = [NSString stringWithFormat:@"订单状态：%@", @"待收货"];
        // 添加确认收货按钮
        UIButton * sureButton = ({
            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70*[FlexibleFrame ratios].width, 20*[FlexibleFrame ratios].height)];
            button.center = CGPointMake(Screen_width - 16 - button.bounds.size.width / 2, self.status.center.y);
            [button setTitle:@"确认收货" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(confirmOrder:) forControlEvents:UIControlEventTouchUpInside];
            button.layer.borderWidth = 1;
            button.layer.borderColor = RGBAColor(0, 200, 25, 0.8).CGColor;
            button.layer.cornerRadius = button.bounds.size.width / 8;
            button.layer.masksToBounds = YES;
            button.titleLabel.font = self.time.font;
            button;
        });
        [self.contentView addSubview:sureButton];
    }
    
    [self.contentView addSubview:self.status];
}

- (void)confirmOrder:(UIButton *)sender {
    
   [[Framework controllers].myOrderVC cellAtIndex:self.row confirmOrder:self.ddno];
}

- (void)setChecked:(BOOL)checked {
    
    if (checked)
    {
        self.checkImageView.image = ImageWithName(@"cell-selected.png");
        //self.backgroundView.backgroundColor = [UIColor colorWithRed:223.0/255.0 green:230.0/255.0 blue:250.0/255.0 alpha:1.0];
    }
    else
    {
        self.checkImageView.image = nil;
        //self.backgroundView.backgroundColor = [UIColor whiteColor];
    }
    _checked = checked;
}

- (void)setCheckImageViewCenter:(CGPoint)pt alpha:(CGFloat)alpha animated:(BOOL)animated
{
    if (animated)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.3];
        
        _checkImageView.center = pt;
        _checkImageView.alpha = alpha;
        
        [UIView commitAnimations];
    }
    else
    {
        _checkImageView.center = pt;
        _checkImageView.alpha = alpha;
    }
}


- (void)setEditing:(BOOL)editting animated:(BOOL)animated
{
    if (self.editing == editting)
    {
        return;
    }
    
    [super setEditing:editting animated:animated];
    
    if (editting)
    {
        
        if (_checkImageView == nil)
        {
            _checkImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
            if (Screen_height == 480) {
                [_checkImageView setFrame:CGRectMake(0, 0, 21.5, 21.5)];
            }
            _checkImageView.contentMode = UIViewContentModeScaleToFill;
            [self addSubview:_checkImageView];
        }
        
        [self setChecked:_checked];
        _checkImageView.center = CGPointMake(-CGRectGetWidth(_checkImageView.frame) * 0.5,
                                              CGRectGetHeight(self.bounds) * 0.5);
        _checkImageView.alpha = 0.0;
        if (Screen_height == 480) {
            [self setCheckImageViewCenter:CGPointMake(23.25, CGRectGetHeight(self.bounds) * 0.5)
                                    alpha:1.0 animated:animated];
        } else {
            [self setCheckImageViewCenter:CGPointMake(22.5, CGRectGetHeight(self.bounds) * 0.5)
                                alpha:1.0 animated:animated];
        }
    }
    else
    {
        _checked = NO;
        if (_checkImageView)
        {
            [self setCheckImageViewCenter:CGPointMake(-CGRectGetWidth(_checkImageView.frame) * 0.5, 
                                                      CGRectGetHeight(self.bounds) * 0.5)
                                    alpha:0.0 
                                 animated:animated];
        }
    }
}
@end
