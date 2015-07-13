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
    if ([self.dataSource count] == 0) {
        return self.frame.size.height;
    }
    return Screen_height / 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.dataSource count] == 0) {
        return 1;
    }
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
    if ([self.dataSource count] == 0) {
        UILabel *nothing = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Screen_width, 30)];
        nothing.center = CGPointMake(Screen_width / 2, self.frame.size.height / 3 - 15);
        nothing.textAlignment = NSTextAlignmentCenter;
        nothing.font = [UIFont boldSystemFontOfSize:Screen_height / 35];
        nothing.textColor = [UIColor lightGrayColor];
        nothing.text = @"什么都没搜到";
        [cell.contentView addSubview:nothing];
    } else {
        [cell getCategoryDetailsCelldata:self.dataSource[indexPath.row]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dataSource count] == 0) {
        return;
    }
    FruitDetailsController *fdVC = [[FruitDetailsController alloc] init];
    [fdVC getNetWork:self.dataSource[indexPath.row]];
    [[Framework controllers].homePageVC.navigationController pushViewController:fdVC animated:YES];
}



@end
