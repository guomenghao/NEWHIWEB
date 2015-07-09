//
//  SearchController.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/25.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "SearchController.h"
#import "SearchCustomCell.h"
#import "SearchView.h"


@interface SearchController ()<UISearchBarDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate> {
    BOOL _isSearch;
}


@property (nonatomic, strong) NSUserDefaults *userDeafaults;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIBarButtonItem *backItem;
@property (nonatomic, strong) UIBarButtonItem *cancelItem;
@property (nonatomic, strong) SearchView *searchView;
@end

@implementation SearchController

- (UIBarButtonItem *)backItem
{
    if (_backItem == nil) {
        _backItem = [[UIBarButtonItem alloc] initWithImage:ImageWithName(@"fanhui.png") style:UIBarButtonItemStylePlain target:self action:@selector(backSearch)];
    }
    return _backItem;
}

- (SearchView *)searchView
{
    if (_searchView == nil) {
        _searchView = [[SearchView alloc] init];
    }
    return _searchView;
}

- (UIBarButtonItem *)cancelItem
{
    if (_cancelItem == nil) {
        _cancelItem = [[UIBarButtonItem alloc] initWithImage:ImageWithName(@"tuichu.png") style:UIBarButtonItemStylePlain target:self action:@selector(backHomePage)];
    }
    return _cancelItem;
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray arrayWithArray:[self.userDeafaults objectForKey:@"searchHistory"]] mutableCopy];
    }
    return _dataSource;
}

- (UISearchBar *)searchBar
{
    if (_searchBar == nil) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.delegate = self;
        _searchBar.showsCancelButton = YES;
        _searchBar.tintColor = [UIColor grayColor];
    }
    return _searchBar;
}

- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
}

- (NSUserDefaults *)userDeafaults
{
    if (_userDeafaults == nil) {
        _userDeafaults = [NSUserDefaults standardUserDefaults];
    }
    return _userDeafaults;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height - 64 ) style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.controllerType = UIViewControllerHaveNavigation;
        [Framework controllers].searchVC = self;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)initializeDataSource
{
    
}

- (void)initializeUserInterface
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    
    self.navigationItem.titleView = self.searchBar;
    
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    int a = 0;
    for (int i = 0; i < (int)[searchBar.text length]; i ++) {
        NSString *string = [searchBar.text substringWithRange:NSMakeRange(i, 1)];
        if ([string isEqual:@" "]) {
            a ++;
        }
    }
    if (a == [searchBar.text length]) {
        searchBar.text = nil;
        return;
    }
    
    /**
     *  去掉前后空格
     */
    searchBar.text = [searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    /**
     *  网络请求
     */
    [self getNetWorkingString:searchBar.text success:^(id responseObject) {
        for (NSString *string in self.dataSource) {
            if ([string isEqual:searchBar.text]) {
                return;
            }
        }
        [self.dataSource insertObject:searchBar.text atIndex:0];
        [self.userDeafaults setObject:self.dataSource forKey:@"searchHistory"];
        [self.tableView reloadData];
    } fail:^(NSError *error) {
    }];

}

/**
 *  cell行高
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dataSource count] == 0) {
        return tableView.frame.size.height;
    }
    if (indexPath.row == [self.dataSource count]) {
        return Screen_height / 10;
    }
    return Screen_height / 13;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.dataSource count] == 0) {
        return 1;
    }
    return [self.dataSource count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"Cell";
    SearchCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[SearchCustomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    [GlobalMethod removeAllSubViews:cell.contentView];
    if ([self.dataSource count] > 0) {
        if (indexPath.row < [self.dataSource count]) {
            cell.textLabel.text = _dataSource[indexPath.row];
            cell.textLabel.textColor = [UIColor blackColor];
            [cell getSearchCell];
        }
        if (indexPath.row == [self.dataSource count]) {
            cell.textLabel.text = nil;
            [cell getsearchClearCell];
        }
    }
    if ([self.dataSource count] == 0) {
        cell.textLabel.text = nil;
        UILabel *nothing = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Screen_width, 30)];
        nothing.center = CGPointMake(Screen_width / 2, tableView.frame.size.height / 3 - 15);
        nothing.textAlignment = NSTextAlignmentCenter;
        nothing.font = [UIFont boldSystemFontOfSize:Screen_height / 35];
        nothing.textColor = [UIColor lightGrayColor];
        nothing.text = @"搜点什么吧";
        [cell.contentView addSubview:nothing];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self.dataSource count]) {
        return;
    }
    [self getNetWorkingString:self.dataSource[indexPath.row] success:^(id responseObject) {
        NSLog(@"%@", responseObject);
    } fail:^(NSError *error) {
        
    }];
}


- (void)beganSearch
{
    _isSearch = YES;
    [self.view addSubview:self.searchView];
    [UIView animateWithDuration:0.5 animations:^{
        self.view.center = CGPointMake(- Screen_width * 0.5, Screen_height / 2);
        self.navigationItem.rightBarButtonItem = self.cancelItem;
        self.navigationItem.leftBarButtonItem = self.backItem;
        [self.searchBar resignFirstResponder];
    } completion:^(BOOL finished) {
        self.view.center = CGPointMake(Screen_width * 0.5, Screen_height / 2);
        self.searchView.center = CGPointMake(Screen_width / 2, (Screen_height + 64) / 2);
    }];
}


- (void)backSearch
{
    _isSearch = NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.leftBarButtonItem = nil;
        self.searchView.center = CGPointMake(Screen_width * 1.5, (Screen_height + 64) / 2);
        self.view.center = CGPointMake(Screen_width * 0.5, Screen_height / 2);
    } completion:^(BOOL finished) {
        [self.searchView removeFromSuperview];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self.tabBarController.tabBar setHidden:YES];
}


- (void)backHomePage
{
    [UIView animateWithDuration:0.7 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [self.navigationController popViewControllerAnimated:NO];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:[Framework controllers].homePageVC.navigationController.view cache:NO];
    }];
}

- (void)getNetWorkingString:(NSString *)string success:(void (^)(id responseObject))succeedBlock fail:(void (^)(NSError *error))failBlock
{
    NSLog(@"搜索的水果为：%@", string);
    [self.searchView.dataSource removeAllObjects];
    if (!_isSearch) {
        [self beganSearch];
    }
    [GlobalMethod serviceWithMothedName:GetSearch_Url parmeter:@{@"keyboard" : string} success:^(id responseObject) {
        succeedBlock(@"搜索成功");
        if ([responseObject[@"err_msg"] isEqual:@"success"]) {
            self.searchView.dataSource = [responseObject[@"data"] mutableCopy];
            [self.searchView.tableView reloadData];
            NSLog(@"%@",self.searchView.dataSource);
        } else {
            self.searchView.dataSource = [NSMutableArray array];
            [self.searchView.tableView reloadData];
        }
    } fail:^(NSError *error) {
        failBlock(error);
    }];
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.searchBar resignFirstResponder];
}


@end
