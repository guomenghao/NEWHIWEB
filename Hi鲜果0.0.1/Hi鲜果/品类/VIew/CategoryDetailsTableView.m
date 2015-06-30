//
//  CategoryDetailsTableView.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/29.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "CategoryDetailsTableView.h"
#import "CategoryDetailsCell.h"
#import "FruitDetailsController.h"

@interface CategoryDetailsTableView () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation CategoryDetailsTableView

- (instancetype)initWithView:(UIView *)view
{
    self = [self initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame), Screen_width, Screen_height - CGRectGetMaxY(view.frame) - 44)];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.delegate = self;
    self.dataSource = self;
    return self;
}

/**
 *  cell行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSourceArray count];
}

/**
 *  cell行高
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Screen_height / 5;;
}

/**
 *  cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"Cell";
    CategoryDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CategoryDetailsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    [GlobalMethod removeAllSubViews:cell.contentView];
    [cell getCategoryDetailsCelldata:_dataSourceArray[indexPath.row]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

/**
 *  cell点击效果
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FruitDetailsController *fdVC = [[FruitDetailsController alloc] init];
    [fdVC getNetWork:self.dataSourceArray[indexPath.row]];
    [[Framework controllers].categoryVC.navigationController pushViewController:fdVC animated:YES];
}

@end
