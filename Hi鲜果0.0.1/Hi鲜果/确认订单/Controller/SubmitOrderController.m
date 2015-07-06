//
//  SubmitOrderController.m
//  Hi鲜果
//
//  Created by rimi on 15/7/3.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "SubmitOrderController.h"
#import "SubmitOrderTableView.h"
#import "CartCell.h"
#import "OpenHeaderView.h"
#import "OpenSectionCell.h"
#import "TotalPriceToolBar.h"
#import "SwitchCell.h"
#define SectionNumber 8

@interface SubmitOrderController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) SubmitOrderTableView * tableView;
@property (strong, nonatomic) OpenHeaderView * headerView;
@property (strong, nonatomic) TotalPriceToolBar * toolBar;
@property (strong, nonatomic) NSMutableDictionary * dataSource;
@property (strong, nonatomic) NSArray * texts;
@property (strong, nonatomic) NSArray * detailTexts;
- (void)sectionHeaderViewTapped:(UITapGestureRecognizer *)sender;
@end

@implementation SubmitOrderController
#pragma mark - 初始化
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"提交订单";
        self.controllerType = UIViewControllerHaveNavigation;
        [Framework controllers].submitOrderVC = self;
        [self registerKeyBoardNotification];
    }
    return self;
}

- (void)initializeDataSource {
    
    self.texts = @[
                  @[@"选择收货地址"],
                  @[@"配送时间*"],
                  @[@"支付方式",@"积分抵扣"],
                  @[],
                  @[@"商品总价",@"运费",@"积分抵扣"],
                  @[@"是否索要发票"],
                  @[]
                    ];
    [GlobalMethod serviceWithMothedName:Settle_Url parmeter:nil success:^(id responseObject) {
        
        NSLog(@"立即结算返回数据：%@", responseObject);
        // 保存数据
        self.dataSource = responseObject;
        self.detailTexts = @[
                             @[@""],
                             @[@"请选择"],
                             @[@"支付宝",@""],
                             @[],
                             @[[NSString stringWithFormat:@"￥%@", self.dataSource[@"buycar"][@"totalmoney"]],
                               @"￥0.00",
                               @"￥0.00"],
                             @[@""]
                             ];
        [self.tableView reloadData];
        self.toolBar.totalPrice = [self.dataSource[@"buycar"][@"totalmoney"] integerValue];
    } fail:^(NSError *error) {
    
        NSLog(@"error:%@", [error localizedDescription]);
    }];
}

- (void)initializeUserInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationItem setHidesBackButton:NO];
    //[self.navigationController.navigationBar setHidden:NO];
    self.navigationController.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.tabBarController.tabBar.hidden = NO;
}

#pragma mark - lazy getter
- (SubmitOrderTableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[SubmitOrderTableView alloc] initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height - 64 - 48) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableDictionary *)dataSource {
    
    if (_dataSource == nil) {
        _dataSource = [[NSMutableDictionary alloc] init];
    }
    return _dataSource;
}

- (OpenHeaderView *)headerView {
    
    if (_headerView == nil) {
        _headerView = [[OpenHeaderView alloc] initWithFrame:CGRectMake(0, 0, Screen_width, 20*[FlexibleFrame ratios].height)];
        // 添加tap手势
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderViewTapped:)];
        [_headerView addGestureRecognizer:tap];
    }
    return _headerView;
}

- (TotalPriceToolBar *)toolBar {
    
    if (_toolBar == nil) {
        _toolBar = [[TotalPriceToolBar alloc] initWithFrame:CGRectMake(0, Screen_height - 48, Screen_width, 48) submitTitle:@"提交订单"];
        [self.view addSubview:_toolBar];
    }
    return _toolBar;
}

#pragma mark - notification
- (void)registerKeyBoardNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyBoardNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)handleKeyBoardNotification:(NSNotification *)notification {
    
    // 得到键盘的frame，从而改变view的center
    NSDictionary * dic = notification.userInfo;
    CGRect beginRect = [dic[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endRect = [dic[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat beginY = beginRect.origin.y;
    CGFloat endY = endRect.origin.y;
    CGFloat centerYChanged = endY - beginY;
    CGFloat duration = [dic[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration animations:^{
        self.tableView.center = CGPointMake(self.view.center.x, self.tableView.center.y + centerYChanged);
    }];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.texts.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 3) {
        return ((NSArray *)self.dataSource[@"buycar"][@"data"]).count;
    }
    if (section == 6) {
        return self.headerView.numberOfRow;
    }
    return ((NSArray *)self.texts[section]).count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    if (section == 0) {
        return 150*[FlexibleFrame ratios].height;
    } else if (section == 3) {
        NSDictionary * info = self.dataSource[@"buycar"][@"data"][indexPath.row];
        NSString * title = info[@"title"];
        CGSize size = [GlobalMethod sizeWithString:title font:MiddleFont maxWidth:220 *[FlexibleFrame ratios].width maxHeight:40 * [FlexibleFrame ratios].height];
        CGFloat height = (size.height + 20 + 40 * [FlexibleFrame ratios].height) > 100 * [FlexibleFrame ratios].height ? (size.height + 20 * 3) : 100 * [FlexibleFrame ratios].height;
        return height;
    } else if (section == 6) {
        return 150*[FlexibleFrame ratios].height;
    } else {
        return 40*[FlexibleFrame ratios].height;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * ID = @"orderCell";
    static NSString * ordinaryID = @"ordinaryCell";
    static NSString * openID = @"openCell";
    static NSString * switchID = @"switchCell";
    
    NSInteger section = indexPath.section;
    
    if (section == 3) {
        CartCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            
            cell = [[CartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.type = CartCellTypeSubmit;
        if (self.dataSource.count > 0) {
            NSArray * info = self.dataSource[@"buycar"][@"data"];
            Fruit * fruit = [[Fruit alloc] initWithInfo:info[indexPath.row]];
            cell.fruit = fruit;
        }
        return cell;
    }
    
    if (section == 6) {
        // section = 6
        OpenSectionCell * cell = [tableView dequeueReusableCellWithIdentifier:openID];
        if (!cell) {
            cell = [[OpenSectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:openID];
        }
        return cell;
    }
    
    if ((section == 2 && indexPath.row == 1) || section == 5) {
        
        SwitchCell * cell = [tableView dequeueReusableCellWithIdentifier:switchID];
        if (!cell) {
            cell = [[SwitchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:switchID];
        }
        cell.textLabel.text = self.texts[section][indexPath.row];
        cell.textLabel.font = MiddleFont;
        cell.detailTextLabel.font = MiddleFont;
        return cell;
    }
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ordinaryID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ordinaryID];
    }
    cell.textLabel.text = self.texts[section][indexPath.row];
    cell.detailTextLabel.text = self.detailTexts[section][indexPath.row];
    cell.textLabel.font = MiddleFont;
    cell.detailTextLabel.font = MiddleFont;
    // 处理特殊格式
    if (section == 1 && indexPath.row == 0) {//配送时间
        NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc] initWithString:cell.textLabel.text];
        [attrString addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(cell.textLabel.text.length - 1, 1)];
        cell.textLabel.attributedText = attrString;
    } else if (section == 4) {
        cell.detailTextLabel.textColor = [UIColor orangeColor];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 20*[FlexibleFrame ratios].height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 6) {
        self.headerView.title = @"订单留言";
        return self.headerView;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"111");
    if (indexPath.section == 0 && indexPath.row == 0) {
        NSLog(@"agg");
         [self.navigationController pushViewController:[[AddrAdminController alloc] init] animated:YES];
    }
}

#pragma mark - 返回按钮点击
- (void)backItemPressed:(UIBarButtonItem *)backItem {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - section header view tapped
- (void)sectionHeaderViewTapped:(UITapGestureRecognizer *)sender {
    
    self.headerView.open = !self.headerView.open;
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:6];
    if (self.headerView.open == YES) {
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    } else {
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

@end
