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

@interface FruitCategoryTableView () <UITableViewDelegate,UITableViewDataSource>

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
    }
    return self;
}

/**
 *  cell行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

/**
 *  cell行高
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Screen_height / 7;;
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
    [cell getFruitCategoryCell];
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
    
    [cdVC getNetWork:[NSString stringWithFormat:@"%ld", (long)indexPath.row + 1]];
    
    [[Framework controllers].categoryVC.navigationController pushViewController:cdVC animated:YES];
}


@end
