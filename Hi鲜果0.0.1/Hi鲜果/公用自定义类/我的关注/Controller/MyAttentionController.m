//
//  MyAttentionController.m
//  Hi鲜果
//
//  Created by 李波 on 15/7/7.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "MyAttentionController.h"
#import "CategoryDetailsCell.h"
#import "MyAttentionCell.h"

@interface MyAttentionController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MyAttentionController
- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
}


- (instancetype)init
{ 
    self = [super init];
    if (self) {
        self.title = @"我的关注";
    }
    return self;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height - 64)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)initializeDataSource
{
    [GlobalMethod NotHaveAlertServiceWithMothedName:GetFavaList_Url parmeter:nil success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"err_msg"] isEqual:@"success"]) {
            self.dataSource = [responseObject[@"data"] mutableCopy];
            [self.tableView reloadData];
        }
    } fail:^(NSError *error) {
    }];
}


- (void)initializeUserInterface
{
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(changeTableViewState:)];
    self.navigationItem.rightBarButtonItem = editItem;
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
}

- (void)changeTableViewState:(UIBarButtonItem *)sender
{
    // 修改tableView的编辑状态
    BOOL isEditing = !_tableView.isEditing;
    [_tableView setEditing:isEditing animated:YES];
    
    // 修改barButtonItem标题
    sender.title = isEditing ? @"完成" : @"编辑";
}


/**
 *  cell行高
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dataSource count] == 0) {
        return tableView.frame.size.height;
    }
    return Screen_height / 5;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.dataSource count] == 0) {
        return NO;
    }
    return YES;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 判断当前是否是删除按钮
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // 先修改数据
        [GlobalMethod NotHaveAlertServiceWithMothedName:DelFavaFun_Url parmeter:@{@"favaid" : self.dataSource[indexPath.row][@"favaid"]} success:^(id responseObject) {
            NSLog(@"%@", responseObject);
            if ([responseObject[@"err_msg"] isEqual:@"success"]) {
                [self.dataSource removeObjectAtIndex:indexPath.row];
                
                // 再进行表视图的刷新:删除表视图中的一行
                if ([self.dataSource count] == 0) {
                    [self.tableView reloadData];
                    return;
                }
                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
        } fail:^(NSError *error) {
        }];
    }
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
    MyAttentionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MyAttentionCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    [GlobalMethod removeAllSubViews:cell.contentView];
    if ([self.dataSource count] > 0) {
        [cell getCategoryDetailsCelldata:self.dataSource[indexPath.row]];
    }
    
    if ([self.dataSource count] == 0) {
        cell.textLabel.text = nil;
        UILabel *nothing = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Screen_width, 30)];
        nothing.center = CGPointMake(Screen_width / 2, tableView.frame.size.height / 3 - 15);
        nothing.textAlignment = NSTextAlignmentCenter;
        nothing.font = [UIFont boldSystemFontOfSize:Screen_height / 35];
        nothing.textColor = [UIColor lightGrayColor];
        nothing.text = @"您还没有收藏哦";
        [cell.contentView addSubview:nothing];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FruitDetailsController *fdVC = [[FruitDetailsController alloc] init];
    [fdVC getNetWork:self.dataSource[indexPath.row]];
    [[Framework controllers].homePageVC.navigationController pushViewController:fdVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:NO];
    [self.tabBarController.tabBar setHidden:YES];
}
@end
