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
        [GlobalMethod NotHaveAlertServiceWithMothedName:GetNewsList_Url parmeter:@{@"classid" : @"3,4"} success:^(id responseObject) {
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
        return Screen_height * 0.25 + 5;
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
        cell.transform = CGAffineTransformMakeScale(1.05, 1.05);
        [UIView animateWithDuration:0.7 animations:^{
            //将cell的变换矩阵置为最初状态
            cell.transform = CGAffineTransformIdentity;
        }];
    }
}

@end
