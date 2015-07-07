//
//  HomePageCustomCell.h
//  Hi鲜果
//
//  Created by 李波 on 15/6/25.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HomePageCustomCell : UITableViewCell

/**
 *  推荐
 */
@property (nonatomic, strong) UILabel *headLine;


/**
 *  轮播图
 */
- (void)getCarouselCellData:(NSArray *)data;

/**
 *  菜单按钮
 */
- (void)getButtonViewCell;

/**
 *  精品推荐
 */
- (void)getBoutiquetitle;
- (void)boutiqueCellData:(NSDictionary *)data;

/**
 *  今日推荐
 */
- (void)getTodaytitle;
- (void)todayCellData:(NSDictionary *)data;

@end
