//
//  HomePageTableView.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/25.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "HomePageTableView.h"
#import "HomePageCustomCell.h"
#import "FruitDetailsController.h"

@interface HomePageTableView () <UITableViewDelegate,UITableViewDataSource> {
    NSArray *_carouslData;
    NSArray *_boutiData;
    NSArray *_todayData;
}

@end

@implementation HomePageTableView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 64, Screen_width, Screen_height - 110);
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor clearColor];
        
        
        [GlobalMethod NotHaveAlertServiceWithMothedName:GetNewsList_Url parmeter:@{@"classid" : @"1"} success:^(id responseObject) {
            if ([responseObject[@"err_msg"] isEqual:@"success"]) {
                _carouslData = responseObject[@"data"];
                [self reloadData];
            }
        } fail:^(NSError *error) {
        }];
        [GlobalMethod NotHaveAlertServiceWithMothedName:GetNewsList_Url parmeter:@{@"classid" : @"6"} success:^(id responseObject) {
            if ([responseObject[@"err_msg"] isEqual:@"success"]) {
                _boutiData = responseObject[@"data"];
                [self reloadData];
            }
        } fail:^(NSError *error) {
        }];
        [GlobalMethod NotHaveAlertServiceWithMothedName:GetNewsList_Url parmeter:@{@"classid" : @"2", @"query" : @"isgood"} success:^(id responseObject) {
            if ([responseObject[@"err_msg"] isEqual:@"success"]) {
                _todayData = responseObject[@"data"];
                [self reloadData];
            }
        } fail:^(NSError *error) {
        }];
    }
    return self;
}

/**
 *  cell行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5 + [_todayData count];
}

/**
 *  cell行高
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return Screen_height * 0.27;
    }
    if (indexPath.row == 1) {
        return Screen_height * 0.16;
    }
    if (indexPath.row == 2 || indexPath.row == 4) {
        return Screen_height / 25;
    }
    return Screen_width / 3.37;
}

/**
 *  cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"Cell";
    HomePageCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    
    if (!cell) {
        cell = [[HomePageCustomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.textLabel.text = @"";
    cell.textLabel.textColor = [UIColor orangeColor];
    [GlobalMethod removeAllSubViews:cell.contentView];
    if (indexPath.row == 0) {
        if (_carouslData == nil) {
        } else {
            [cell getCarouselCellData:_carouslData];
            [GlobalControl myControl].cell = cell;
        }
    }
    if (indexPath.row == 1) {
        [cell getButtonViewCell];
    }
    if (indexPath.row == 3) {
        if (_boutiData == nil) {
        } else {
            [cell boutiqueCellData:[_boutiData firstObject]];
        }
    }
    if (indexPath.row > 4) {
        if (_todayData == nil) {
        } else {
            [cell todayCellData:_todayData[indexPath.row - 5]];
        }
    }
    if (indexPath.row == 4) {
        cell.textLabel.text = @"今日推荐";
    }
    if (indexPath.row == 2) {
        cell.textLabel.text = @"精品推荐";
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

/**
 *  cell点击效果
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 4 || indexPath.row == 2) {
        return;
    }
    FruitDetailsController *fdVC = [[FruitDetailsController alloc] init];
    if (indexPath.row == 3) {
        [fdVC getNetWork:[_boutiData firstObject]];
    }
    if (indexPath.row > 4) {
        [fdVC getNetWork:_todayData[indexPath.row - 5]];
    }
    [[Framework controllers].homePageVC.navigationController pushViewController:fdVC animated:YES];
}

/**
 *  cell将要出现的动画
 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > 4) {
        //修改cell位移变换矩阵
        cell.transform = CGAffineTransformMakeScale(1.07, 1.07);
        [UIView animateWithDuration:1.5 animations:^{
            //将cell的变换矩阵置为最初状态
            cell.transform = CGAffineTransformIdentity;
        }];
    }
}




- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < 0 && scrollView.contentOffset.y > -Screen_height / 4) {
        [GlobalControl myControl].cell.transform = CGAffineTransformMakeScale(-scrollView.contentOffset.y / 100 + 1, -scrollView.contentOffset.y / 100 + 1);
        [GlobalControl myControl].cell.center = CGPointMake(Screen_width / 2, Screen_height * 0.27 / 2 + scrollView.contentOffset.y * (Screen_width / 800 / (Screen_width / Screen_height)));
    }
    if (- scrollView.contentOffset.y > Screen_height / 4) {
        scrollView.contentOffset = CGPointMake(0,  - Screen_height / 4);
    }
    if (scrollView.contentOffset.y > 0) {
        [GlobalControl myControl].cell.transform = CGAffineTransformIdentity;
    }
}


@end
