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

@interface HomePageCustomCell () {
    NSArray *_carouselData;
}

@property (nonatomic, strong) CarouselView *carouselView;
@property (nonatomic, strong) ButtonView *buttonView;
@property (nonatomic, strong) UIImageView *boutiImageView;
@property (nonatomic, strong) UIImageView *todayImageView;

@end

@implementation HomePageCustomCell

- (UIImageView *)boutiImageView
{
    if (_boutiImageView == nil) {
        _boutiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 2.5, Screen_width - 10, Screen_width / 3.37 - 5)];
        _boutiImageView.layer.borderWidth = 1;
        _boutiImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    return _boutiImageView;
}

- (UIImageView *)todayImageView
{
    if (_todayImageView == nil) {
        _todayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 2.5, Screen_width - 10, Screen_width / 3.37 - 5)];
        _todayImageView.layer.borderWidth = 1;
        _todayImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    return _todayImageView;
}

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
        _carouselView = [[CarouselView alloc] initWithData:_carouselData];
    }
    return _carouselView;
}

/**
 *  轮播图cell
 */
- (void)getCarouselCellData:(NSArray *)data
{
    _carouselData = data;
    [self.contentView addSubview:self.carouselView];
}

/**
 *  按钮cell
 */
- (void)getButtonViewCell
{
    [self.contentView addSubview:self.buttonView];
    
}

/**
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
- (void)boutiqueCellData:(NSDictionary *)data
{
    [self.boutiImageView sd_setImageWithURL:[NSURL URLWithString:data[@"titlepic"]]];
    [self.contentView addSubview:self.boutiImageView];
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
- (void)todayCellData:(NSDictionary *)data
{
    [self.todayImageView sd_setImageWithURL:[NSURL URLWithString:data[@"titlepic"]]];
    [self.contentView addSubview:self.todayImageView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
