//
//  FruitDetailsTableView.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/26.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "FruitDetailsTableView.h"
#import "FruitDetailsCustomCell.h"

@interface FruitDetailsTableView () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation FruitDetailsTableView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, Screen_width, Screen_height);
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
    return 7;
}

/**
 *  cell行高
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return Screen_height * 0.4;
    }
    if (indexPath.row == 1) {
        return Screen_height * 0.15;
    }
    if (indexPath.row == 2) {
        return Screen_height / 20;
    }
    if (indexPath.row == 3) {
        return Screen_height / 10;
    }
    return 100;
}

/**
 *  cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"Cell";
    FruitDetailsCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[FruitDetailsCustomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    [GlobalMethod removeAllSubViews:cell.contentView];
    
    if (indexPath.row == 0) {
        [cell getScrollViewCell];
    }
    if (indexPath.row == 1) {
        [cell getFruitInfoCell];
    }
    if (indexPath.row == 2) {
        [cell getUnitCell];
    }
    if (indexPath.row == 3) {
        [cell getEvaluateCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

/**
 *  cell点击效果
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

/**
 *  cell将要出现的动画
 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
}


@end
