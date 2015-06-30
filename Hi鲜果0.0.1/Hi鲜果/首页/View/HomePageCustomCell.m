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

@end

@implementation HomePageCustomCell

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

- (UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        //分页控件
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, Screen_width * 0.5, Screen_height * 0.27 / 5)];
        _pageControl.center = CGPointMake(Screen_width / 2, Screen_height * 0.27 * 0.9);
        _pageControl.numberOfPages = 3;
        _pageControl.userInteractionEnabled = NO;
        [GlobalControl myControl].pageControl = _pageControl;
    }
    return _pageControl;
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
    [self.contentView addSubview:self.pageControl];
}

/**
 *  按钮cell
 */
- (void)getButtonViewCell
{
    ButtonView *buttonView = [[ButtonView alloc] init];
    [self.contentView addSubview:buttonView];
    
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
