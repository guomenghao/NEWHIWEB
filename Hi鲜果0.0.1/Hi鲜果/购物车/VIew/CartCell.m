//
//  CartCell.m
//  Hi鲜果
//
//  Created by 吕玉梅 on 15/6/29.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "CartCell.h"
#import "FruitNumberPicker.h"
#import "UIImageView+WebCache.h"
#import "FruitNumberPicker.h"
#define TopMargin 10
#define XMargin 10
@interface CartCell ()
/**左边图片*/
@property (strong, nonatomic) UIImageView * picView;
/**顶部标题*/
@property (strong, nonatomic) UILabel * titleLabel;
/**规格*/
@property (strong, nonatomic) UILabel * unitLabel;
/**打折后价格*/
@property (strong, nonatomic) UILabel * priceLabel;
/**数量加减选择(购物车中使用)*/
@property (strong, nonatomic) FruitNumberPicker * numberPicker;
/**只显示数量(提交订单中使用)*/
@property (strong, nonatomic) UILabel * numberLabel;
/**拿到数据模型以后更新界面*/
- (void)updateUI;
/**label高度适应文字*/
- (void)adjustLabelFrame;
@end

@implementation CartCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.fruit = [[Fruit alloc] init];
        [self.contentView addSubview:self.picView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.unitLable];
        [self.contentView addSubview:self.priceLabel];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setType:(CartCellType)type {
    
    _type = type;
    if (_type == CartCellTypeCart) {
        [self.numberLabel removeFromSuperview];
        [self.contentView addSubview:self.numberPicker];
    } else {
        [self.numberPicker removeFromSuperview];
        [self.contentView addSubview:self.numberLabel];
    }
}

- (UIImageView *)picView {
    
    if (_picView == nil) {
        _picView = [[UIImageView alloc] initWithiPhone5Frame:CGRectMake(XMargin, TopMargin, 80 *[FlexibleFrame ratios].width, 80 * [FlexibleFrame ratios].height)];
        _picView.contentMode = UIViewContentModeScaleAspectFill;
        _picView.clipsToBounds = YES;
    }
    return _picView;
}

- (UILabel *)titleLabel {
    
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.picView.frame) + XMargin * [FlexibleFrame ratios].width, self.picView.frame.origin.y, 150* [FlexibleFrame ratios].width, 20 * [FlexibleFrame ratios].height)];
        _titleLabel.font = MiddleFont;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)unitLable {
    
    if (_unitLabel == nil) {
        _unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.frame.origin.x, CGRectGetMaxY(self.titleLabel.frame), 50 * [FlexibleFrame ratios].width, 20 * [FlexibleFrame ratios].height)];
        _unitLabel.font = SmallFont;
        _unitLabel.textColor = [UIColor grayColor];
    }
    return _unitLabel;
}

- (UILabel *)priceLabel {
    
    if (_priceLabel == nil) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.frame.origin.x, CGRectGetMaxY(self.unitLabel.frame), 100 * [FlexibleFrame ratios].width, 20 * [FlexibleFrame ratios].height)];
        _priceLabel.font = LargeFont;
        _priceLabel.textColor = [UIColor orangeColor];
    }
    return _priceLabel;
}

- (FruitNumberPicker *)numberPicker {
    
    if (_numberPicker == nil) {
        _numberPicker = [[FruitNumberPicker alloc] initWithPoint:CGPointMake(0.7 * Screen_width - XMargin, self.priceLabel.frame.origin.y)];
        _numberPicker.center = CGPointMake(_numberPicker.center.x, self.priceLabel.center.y);
    }
    return _numberPicker;
}

- (UILabel *)numberLabel {
    
    if (_numberLabel == nil) {
        _numberLabel = ({
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(Screen_width - 80 - XMargin, 0, 50, 30)];
            label.font = MiddleFont;
            label.textColor = [UIColor lightGrayColor];
            label;
        });
    }
    return _numberLabel;
}

- (void)setFruit:(Fruit *)fruit {
    
    _fruit = fruit;
    [self updateUI];
}

- (void)updateUI {

    NSURL * url = [NSURL URLWithString:[Base_Url stringByAppendingPathComponent:self.fruit.pic]];
    [self.picView sd_setImageWithURL:url
                           completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {}];
    self.titleLabel.text = self.fruit.name;
    self.unitLable.text = self.fruit.unit;
    if (self.type == CartCellTypeCart) {
        self.numberPicker.fruitNum.text = [self.fruit.number stringValue];
        self.numberPicker.fruitsNum = [self.fruit.number integerValue];
    } else {
        self.numberLabel.text = [NSString stringWithFormat:@"X%@", self.fruit.number];
    }
    
    if (self.fruit.info) {
        self.numberPicker.classInfo = @{@"classid":self.fruit.classid,
                                        @"id":self.fruit.ID};
    }
    
    [self adjustLabelFrame];
    // 现价富文本属性
//    NSDictionary * attrs1 = @{
//                             NSFontAttributeName:LargeFont,
//                             NSForegroundColorAttributeName:[UIColor orangeColor]
//                             };
    NSMutableAttributedString * attrString = nil;
    if (self.fruit.discountPrice.length > 0) {//有打折信息
        attrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@", self.fruit.discountPrice]];
        
    } else {//没有打折信息时
        attrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@", self.fruit.originalPrice]];
    }
    [attrString addAttribute:NSFontAttributeName value:SmallFont range:NSMakeRange(0, 1)];
//    [attrString addAttributes:attrs1 range:NSMakeRange(1, self.fruit.originalPrice.length)];
    self.priceLabel.attributedText = attrString;
}

- (void)adjustLabelFrame {
    
    // 计算实际大小
    CGSize size = [GlobalMethod sizeWithString:self.fruit.name font:MiddleFont maxWidth:220 *[FlexibleFrame ratios].width maxHeight:40*[FlexibleFrame ratios].height];
    [self.picView setFrame:CGRectMake(XMargin, TopMargin, 80 *[FlexibleFrame ratios].width, 80 * [FlexibleFrame ratios].height)];
    [self.titleLabel setFrame:CGRectMake(CGRectGetMaxX(self.picView.frame) + XMargin * [FlexibleFrame ratios].width, self.picView.frame.origin.y, size.width, size.height)];
    [self.unitLabel setFrame:CGRectMake(self.titleLabel.frame.origin.x, CGRectGetMaxY(self.titleLabel.frame), 50 * [FlexibleFrame ratios].width, 20 * [FlexibleFrame ratios].height)];
    [self.priceLabel setFrame:CGRectMake(self.titleLabel.frame.origin.x, CGRectGetMaxY(self.picView.frame) - 20 * [FlexibleFrame ratios].height, 100 * [FlexibleFrame ratios].width, 20 * [FlexibleFrame ratios].height)];
    if (self.type == CartCellTypeCart) {
        self.numberPicker.center = CGPointMake(self.numberPicker.center.x, self.priceLabel.center.y);
    } else {
        self.numberLabel.center = CGPointMake(self.numberLabel.center.x, self.picView.center.y);
    }
}

@end
