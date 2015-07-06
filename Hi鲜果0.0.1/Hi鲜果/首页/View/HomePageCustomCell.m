//
//  HomePageCustomCell.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/25.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "HomePageCustomCell.h"
#import "ButtonView.h"
#import "CarouselView.h"
#import "GlobalControl.h"

@interface HomePageCustomCell ()

@property (nonatomic, strong) CarouselView *carouselView;
@property (nonatomic, strong) ButtonView *buttonView;

@end

@implementation HomePageCustomCell

- (ButtonView *)buttonView
{
    if (_buttonView == nil) {
        _buttonView = [[ButtonView alloc] init];
    }
    return _buttonView;
}

/**
 *  头条，懒加载
 */
- (UILabel *)headLine
{
    if (_headLine == nil) {
        _headLine = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, Screen_width - 10, Screen_height / 25)];
        _headLine.font = [UIFont systemFontOfSize:Screen_height / 40];
    }
    return _headLine;
}

- (CarouselView *)carouselView
{
    if (_carouselView == nil) {
        _carouselView = [[CarouselView alloc] init];
    }
    return _carouselView;
}

/**
 *  轮播图cell
 */
- (void)getCarouselCell
{
    [self.contentView addSubview:self.carouselView];
}

/**
 *  按钮cell
 */
- (void)getButtonViewCell
{
    [self.contentView addSubview:self.buttonView];
    
}

/**44
 *  精品推荐title
 */
- (void)getBoutiquetitle
{
    self.headLine.text = @"精品推荐";
    [self.contentView addSubview:self.headLine];
}

/**
 *  精品推荐cell
 */
- (void)boutiqueCell
{
    
}

/**
 *  今日title
 */
- (void)getTodaytitle
{
    self.headLine.text = @"今日推荐";
    [self.contentView addSubview:self.headLine];
}

/**
 *  今日cell
 */
- (void)todayCell
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
