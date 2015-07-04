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
#define SectionNumber 8
static NSString * identifier = @"orderCell";
@interface SubmitOrderController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) SubmitOrderTableView * tableView;
@property (strong, nonatomic) NSMutableDictionary * dataSource;
@end

@implementation SubmitOrderController
#pragma mark - 初始化
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"提交订单";
        [Framework controllers].submitOrderVC = self;
    }
    return self;
}

- (void)initializeDataSource {
    
    [GlobalMethod serviceWithMothedName:Settle_Url parmeter:nil success:^(id responseObject) {
        
        NSLog(@"立即结算返回数据：%@", responseObject);
        // 保存数据
        self.dataSource = responseObject;
        [self.tableView reloadData];
        
    } fail:^(NSError *error) {
        
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
    self.navigationController.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.tabBarController.tabBar.hidden = NO;
}

#pragma mark - lazy getter
- (SubmitOrderTableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[SubmitOrderTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
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

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return SectionNumber;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 2) {
        return 2;
    } else if (section == 3) {
        return ((NSArray *)self.dataSource[@"buycar"][@"data"]).count;
    } else if (section == 4) {
        return 3;
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    if (section == 0) {
        return 150;
    } else if (section == 3) {
        return 100;
    } else if (section == 6 || section == 7) {
        return 150;
    } else {
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    if (section == 3) {
        CartCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            
            cell = [[CartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        if (self.dataSource.count > 0) {
            NSArray * info = self.dataSource[@"buycar"][@"data"];
            Fruit * fruit = [[Fruit alloc] initWithInfo:info[indexPath.row]];
            cell.fruit = fruit;
           // [cell.numberPicker removeFromSuperview];
        }
        return cell;
    }
    // 除section=3以外
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ordinary"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ordinary"];
    }
    switch (section) {
        case 0:
        {
            cell.textLabel.text = @"选择收货地址";
        }
            break;
        case 1:
        {   NSString * text = @"配送时间*";
            NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc] initWithString:text];
            [attrString addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(text.length - 1, 1)];
            cell.textLabel.attributedText = attrString;
            cell.detailTextLabel.text = @"请选择";
        }
            break;
        case 2:
        {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"支付方式";
                cell.detailTextLabel.text = @"支付宝";
            } else {
                cell.textLabel.text = @"积分抵扣";
            }
        }
            break;
        case 4:
        {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"商品总价";
                cell.detailTextLabel.text = @"￥999";
            } else if (indexPath.row == 1){
                cell.textLabel.text = @"运费";
                cell.detailTextLabel.text = @"￥0.00";
            } else {
                cell.textLabel.text = @"积分抵扣";
                cell.detailTextLabel.text = @"￥0.00";
            }
        }
            break;
        case 5:
            break;
        case 6:
            break;
        case 7:
            break;
        default:
            break;
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section == 6) {
        return @"订单留言";
    } else if (section == 7) {
        return @"贺卡";
    }
    return nil;
}
@end
