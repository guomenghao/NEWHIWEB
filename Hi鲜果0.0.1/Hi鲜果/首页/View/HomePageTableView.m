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

@interface HomePageTableView () <UITableViewDelegate,UITableViewDataSource>

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
    }
    return self;
}

/**
 *  cell行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 11;
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
        return Screen_height * 0.25;
    }
    if (indexPath.row == 2 || indexPath.row == 4) {
        return Screen_height / 25;
    }
    return 100;
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
    
    [GlobalMethod removeAllSubViews:cell.contentView];
    
    if (indexPath.row == 0) {
        [cell getCarouselCell];
    }
    if (indexPath.row == 1) {
        [cell getButtonViewCell];
    }
    if (indexPath.row == 2) {
        [cell getBoutiquetitle];
    }
    if (indexPath.row == 4) {
        [cell getTodaytitle];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

/**
 *  cell点击效果
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[[UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers firstObject] pushViewController:[[FruitDetailsController alloc] init] animated:YES];
}

/**
 *  cell将要出现的动画
 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //修改cell位移变换矩阵
    cell.transform = CGAffineTransformMakeTranslation(-100, -110);
    [UIView animateWithDuration:1 animations:^{
        //将cell的变换矩阵置为最初状态
        cell.transform = CGAffineTransformIdentity;
    }];
}

@end
