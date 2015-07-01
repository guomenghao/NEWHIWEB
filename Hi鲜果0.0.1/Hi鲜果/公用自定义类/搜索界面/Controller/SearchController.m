//
//  SearchController.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/25.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "SearchController.h"

@interface SearchController ()<UISearchBarDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSUserDefaults *userDeafaults;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UISearchBar *searchBar;
@end

@implementation SearchController

- (UISearchBar *)searchBar
{
    if (_searchBar == nil) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.delegate = self;
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(Screen_height / 33.35, Screen_height / 13 + 64, Screen_width - Screen_height / 33.35 * 2, Screen_height - Screen_height / 13 - 64 - Screen_height / 33.35) style:UITableViewStylePlain];
        _tableView.layer.cornerRadius = 8;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor lightGrayColor];
        
    }
    return _tableView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.controllerType = UIViewControllerHaveNavigation;
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
    self.dataSource = [[self.userDeafaults objectForKey:@"searchHistory"] mutableCopy];
}

- (void)initializeUserInterface
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"222" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem = backItem;
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(backHomePage)];
    self.navigationItem.rightBarButtonItem = cancelItem;
    
    self.navigationItem.titleView = self.searchBar;
    
    
    UILabel *labelHistory = [[UILabel alloc] initWithFrame:CGRectMake(Screen_height / 30, Screen_height / 50 + 64, Screen_height / 4.5, Screen_height / 23)];
    [labelHistory setText:@"搜索历史"];
    [labelHistory setFont:[UIFont systemFontOfSize:22]];
    [labelHistory setTextColor:[UIColor lightGrayColor]];
    labelHistory.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labelHistory];
    
    UIButton *buttonClear = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonClear setFrame:CGRectMake(Screen_width - Screen_height / 4.5 - Screen_height / 30, Screen_height / 50 + 64, Screen_height / 4.5, Screen_height / 23)];
    [buttonClear setBackgroundColor:[UIColor clearColor]];
    [buttonClear.titleLabel setFont:[UIFont systemFontOfSize:22]];
    [buttonClear setTitle:@"清除历史" forState:UIControlStateNormal];
    [buttonClear setTitleColor:[UIColor colorWithWhite:0.400 alpha:1.000] forState:UIControlStateNormal];
    [buttonClear setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [buttonClear addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonClear];
    
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"333");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)clear
{
    NSLog(@"%@", self.searchBar.text);
}

- (void)backHomePage
{
    [UIView animateWithDuration:0.7 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [self.navigationController popViewControllerAnimated:NO];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:[Framework controllers].homePageVC.navigationController.view cache:NO];
    }];
}

@end
