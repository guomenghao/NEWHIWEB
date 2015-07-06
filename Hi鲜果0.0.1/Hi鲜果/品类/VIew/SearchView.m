//
//  SearchView.m
//  Hi鲜果
//
//  Created by 李波 on 15/7/2.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "SearchView.h"
#import "CategoryDetailsCell.h"
#import "FruitDetailsController.h"

@interface SearchView ()<UITableViewDataSource,UITableViewDelegate>

- (void)initializeUserInterface;

@end

@implementation SearchView

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(Screen_width, 64, Screen_width, Screen_height - 64);
        self.backgroundColor = [UIColor whiteColor];
        [self initializeUserInterface];
    }
    return self;
}


- (void)initializeUserInterface
{
    [self addSubview:self.tableView];
}

/**
 *  cell行高
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Screen_height / 5;;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"Cell";
    CategoryDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CategoryDetailsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    [GlobalMethod removeAllSubViews:cell.contentView];
    [cell getCategoryDetailsCelldata:self.dataSource[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FruitDetailsController *fdVC = [[FruitDetailsController alloc] init];
    [fdVC getNetWork:self.dataSource[indexPath.row]];
    [[Framework controllers].homePageVC.navigationController pushViewController:fdVC animated:YES];
}



@end
