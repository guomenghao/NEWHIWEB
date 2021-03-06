//
//  FruitCategory.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/29.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "FruitCategoryTableView.h"
#import "FruitCategoryCell.h"
#import "CategoryDetailsController.h"
#import "CategoryModel.h"

@interface FruitCategoryTableView () <UITableViewDelegate,UITableViewDataSource> {
    NSArray *_dataSource;
    NSArray *_fruitId;
}

@end

@implementation FruitCategoryTableView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 64, Screen_width, Screen_height - 110);
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource = self;
        _fruitId = @[@"2", @"4", @"3"];
        _dataSource = @[@{@"fruitname" : @"全部蔬果",
                          @"title" : @"世界各地美味鲜果",
                          @"pic" : @"quanbu.png"}, @{@"fruitname" : @"国外蔬果",
                                           @"title" : @"不出门就能品尝到异域风情的鲜果",
                                           @"pic" : @"guowai.png"}, @{@"fruitname" : @"国内蔬果",
                                                            @"title" : @"为您挑选国内最新鲜蔬果",
                                                            @"pic" : @"guonei.png"}];
    }
    return self;
}

/**
 *  cell行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource count];
}

/**
 *  cell行高
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Screen_height / 7;
}

/**
 *  cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"Cell";
    FruitCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[FruitCategoryCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    [GlobalMethod removeAllSubViews:cell.contentView];
    [cell getFruitCategoryCellData:_dataSource[indexPath.row]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

/**
 *  cell点击效果
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryDetailsController *cdVC = [[CategoryDetailsController alloc] init];
    cdVC.title = _dataSource[indexPath.row][@"fruitname"];
    cdVC.classid = _fruitId[indexPath.row];
    [cdVC getNetWork:_fruitId[indexPath.row]];
    
    [[Framework controllers].categoryVC.navigationController pushViewController:cdVC animated:YES];
}


@end
