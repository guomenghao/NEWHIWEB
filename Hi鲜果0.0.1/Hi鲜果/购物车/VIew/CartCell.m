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
#define Margin 30
@interface CartCell ()
/**左边图片*/
@property (strong, nonatomic) UIImageView * picView;
/**顶部标题*/
@property (strong, nonatomic) UILabel * titleLabel;
/**规格*/
@property (strong, nonatomic) UILabel * unitLable;
/**原价价格*/
@property (strong, nonatomic) UILabel * originalPriceLabel;
/**打折后价格*/
@property (strong, nonatomic) UILabel * discountPriceLabel;
/**数量加减选择*/
@property (strong, nonatomic) FruitNumberPicker * numberPicker;
/**拿到数据模型以后更新界面*/
- (void)updateUI;
@end

@implementation CartCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.picView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.unitLable];
        [self.contentView addSubview:self.discountPriceLabel];
    }
    return self;
}

- (UIImageView *)picView {
    
    if (_picView == nil) {
        _picView = [[UIImageView alloc] initWithiPhone5Frame:CGRectMake(16, 23, 120, 120)];
    }
    return _picView;
}

- (UILabel *)titleLabel {
    
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.picView.frame) + Margin * [FlexibleFrame ratios].width, self.picView.frame.origin.y, 80 * [FlexibleFrame ratios].width, 15 * [FlexibleFrame ratios].height)];
        _titleLabel.font = [UIFont systemFontOfSize:15 * [FlexibleFrame ratios].height];
    }
    return _titleLabel;
}

- (UILabel *)unitLable {
    
    if (_unitLable == nil) {
        _unitLable = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.frame.origin.x, CGRectGetMaxY(self.titleLabel.frame) + Margin * [FlexibleFrame ratios].height, 80 * [FlexibleFrame ratios].width, 15 * [FlexibleFrame ratios].height)];
        _unitLable.font = [UIFont systemFontOfSize:15 * [FlexibleFrame ratios].height];
    }
    return _unitLable;
}

- (UILabel *)discountPriceLabel {
    
    if (_discountPriceLabel == nil) {
        _discountPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.frame.origin.x, CGRectGetMaxY(self.unitLable.frame) + Margin * [FlexibleFrame ratios].height, 80 * [FlexibleFrame ratios].width, 20 * [FlexibleFrame ratios].height)];
        _discountPriceLabel.textColor = [UIColor orangeColor];
    }
    return _discountPriceLabel;
}

- (void)setFruit:(Fruit *)fruit {
    
    _fruit = fruit;
    [self updateUI];
}

- (void)updateUI {

    NSURL * url = [NSURL URLWithString:[Base_Url stringByAppendingPathComponent:self.fruit.pic]];
    [self.picView sd_setImageWithURL:url
                    placeholderImage:ImageWithName(@"placeholder.jpg")
                           completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                           }];
    self.titleLabel.text = self.fruit.name;
    self.unitLable.text = self.fruit.unit;
    self.discountPriceLabel.text = self.fruit.discountPrice;
}

@end
