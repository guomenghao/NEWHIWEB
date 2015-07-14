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
#import "AddrSelectController.h"
#import "AddrSelectCell.h"
#import "InputCell.h"
#import "AutoDismissBox.h"
#define SectionNumber 8
#define ContentViewTagBase 4000
#define AMTime @"10:00~15:00"
#define PMTime @"15:00~18:00"
@interface SubmitOrderController ()
<UITableViewDelegate,
UITableViewDataSource,
UIActionSheetDelegate,
TotalPriceToolBarDelegate,
InputCellDelegate,
OpenSectionCellDelegate>
@property (strong, nonatomic) SubmitOrderTableView * tableView;
@property (strong, nonatomic) OpenHeaderView * headerView;
@property (strong, nonatomic) TotalPriceToolBar * toolBar;
@property (strong, nonatomic) NSMutableDictionary * dataSource;
@property (strong, nonatomic) NSMutableArray * texts;
@property (strong, nonatomic) NSMutableArray * detailTexts;
@property (assign, nonatomic) NSInteger currentSwitchSection;//当前开关所在分区
@property (strong, nonatomic) NSString * currentDispatchDate;//送货时间
@property (assign, nonatomic) NSInteger currentDiscountScore;//积分抵扣
@property (strong, nonatomic) NSString * currentInvoiceHead;//发票抬头
@property (strong, nonatomic) NSString * leaveMessage;//订单留言
- (void)sectionHeaderViewTapped:(UITapGestureRecognizer *)sender;
// 刷新地址
- (void)refreshAddress;
// 判断是否当天发货
- (BOOL)isTodayDispatch;
// 返回发货时间
- (NSArray *)dateArrays;
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
    }
    return self;
}

- (void)initializeDataSource {
    self.currentSwitchSection = -1;
    self.currentDiscountScore = 0;
    self.texts = [@[
                  @[@"选择收货地址"],
                  @[@"配送时间*"],
                  @[@"支付方式",@"积分抵扣"],
                  @[],
                  @[@"商品总价",@"配送费",@"积分抵扣"],
                  @[@"是否索要发票"],
                  @[]
                    ] mutableCopy];
    [GlobalMethod serviceWithMothedName:Settle_Url parmeter:nil success:^(id responseObject) {
        
        NSLog(@"立即结算返回数据：%@", responseObject);
        // 保存数据
        self.dataSource = responseObject;
        self.detailTexts = [@[
                             @[@""],
                             @[@"请选择"],
                             @[@"货到付款",@""],
                             @[],
                             [@[[NSString stringWithFormat:@"￥%.2f", [self.dataSource[@"buycar"][@"totalmoney"] floatValue]],
                               @"￥0.00",
                               [NSString stringWithFormat:@"￥%ld.00", (long)self.currentDiscountScore]] mutableCopy],
                             @[@""]
                             ] mutableCopy];
        [self.tableView reloadData];
        self.toolBar.totalPrice = [self.dataSource[@"buycar"][@"totalmoney"] floatValue];
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
    
    [self.tableView setFrame:CGRectMake(0, 64, Screen_width, Screen_height - 48 - 64)];
    self.tableView.contentOffset = CGPointMake(0, 0);
    [self refreshAddress];
    [super viewWillAppear:animated];
    self.navigationController.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    if ([User loginUser].isLogin == NO) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    self.navigationController.tabBarController.tabBar.hidden = NO;
    [super viewWillDisappear:animated];
}

#pragma mark - lazy getter
- (SubmitOrderTableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[SubmitOrderTableView alloc] initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height - 48 - 64) style:UITableViewStyleGrouped];
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
        _headerView = [[OpenHeaderView alloc] initWithFrame:CGRectMake(0, 0, Screen_width, 40*[FlexibleFrame ratios].height)];
        // 添加tap手势
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderViewTapped:)];
        [_headerView addGestureRecognizer:tap];
    }
    return _headerView;
}

- (TotalPriceToolBar *)toolBar {
    
    if (_toolBar == nil) {
        _toolBar = [[TotalPriceToolBar alloc] initWithFrame:CGRectMake(0, Screen_height - 48, Screen_width, 48) submitTitle:@"提交订单"];
        _toolBar.delegate = self;
        [self.view addSubview:_toolBar];
    }
    return _toolBar;
}

- (NSInteger)orderTotalPrice {
    
    return [self.dataSource[@"buycar"][@"totalmoney"] integerValue];
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

        if (self.address != nil) {
            NSString *addr = [NSString stringWithFormat:@"收货地址：%@", self.address[@"addressname"]];
            CGSize size = [GlobalMethod sizeWithString:addr font:MiddleFont maxWidth:250 *[FlexibleFrame ratios].width maxHeight:60 * [FlexibleFrame ratios].height];
            CGFloat height = 20 + 40*[FlexibleFrame ratios].height;
            return height + size.height;
        } else {
            return 80*[FlexibleFrame ratios].height;
        }

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
    static NSString * addrID = @"addressCell";
    static NSString * inputID = @"inputCell";

    NSInteger section = indexPath.section;
    
    // cart cell
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
    
    // open section cell
    if (section == 6 && indexPath.row == 0) {
        OpenSectionCell * cell = [tableView dequeueReusableCellWithIdentifier:openID];
        if (!cell) {
            cell = [[OpenSectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:openID];
            cell.delegate = self;
        }
        return cell;
    }
    
    // switch cell
    if ((section == 2 && indexPath.row == 1) || (section == 5 && indexPath.row == 0)) {
        
        SwitchCell * cell = [tableView dequeueReusableCellWithIdentifier:switchID];
        if (!cell) {
            cell = [[SwitchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:switchID];
        }
        cell.contentView.tag = ContentViewTagBase + section;//区分cell
        cell.textLabel.text = self.texts[section][indexPath.row];
        cell.textLabel.font = MiddleFont;
        cell.detailTextLabel.font = MiddleFont;
        return cell;
    }
    
    // address cell
    if (self.address != nil) {
        if (section == 0 && indexPath.row == 0) {
            AddrSelectCell * cell = [tableView dequeueReusableCellWithIdentifier:addrID];
            if (!cell) {
                cell = [[AddrSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addrID];
            }
            [cell setCellInfo:self.address];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
    }
    
    // input cell
    if ((section == 2 && indexPath.row == 2) || (section == 5 && indexPath.row == 1)) {//可用积分带输入框的cell
        InputCell * cell = [tableView dequeueReusableCellWithIdentifier:inputID];
        if (!cell) {
            cell = [[InputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:inputID]; 
        }
        cell.delegate = self;
        if (section == 5) {
            cell.type = InputCellTypeInvoice;
        } else {
            cell.type = InputCellTypeScore;
        }
        cell.textLabel.text = self.texts[section][indexPath.row];
        cell.textLabel.font = SmallFont;
        return cell;
    }
    
    // ordinary cell
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ordinaryID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ordinaryID];
    }
    cell.textLabel.text = self.texts[section][indexPath.row];
    cell.textLabel.font = MiddleFont;
    cell.detailTextLabel.text = self.detailTexts[section][indexPath.row];
    cell.detailTextLabel.font = MiddleFont;
    cell.detailTextLabel.textColor = [UIColor orangeColor];
    
    // 处理特殊格式
    if (section == 1 && indexPath.row == 0) {//配送时间
        NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc] initWithString:cell.textLabel.text];
        [attrString addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(cell.textLabel.text.length - 1, 1)];
        cell.textLabel.attributedText = attrString;
        if ([self.detailTexts[section][indexPath.row] isEqualToString:@"请选择"]) {
            cell.detailTextLabel.textColor = [UIColor grayColor];
        }
    }
    // 支付方式
    if (section == 2 && indexPath.row == 0) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 6) {
        self.headerView.title = @"订单留言";
        return self.headerView;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 0) {//地址选择
         [self.navigationController pushViewController:[[AddrSelectController alloc] init] animated:YES];
    } else if (indexPath.section == 1) {//配送时间
        NSArray * dates = [self dateArrays];
#pragma mark - 系统适配
        if ([GlobalMethod getIOSVersion] >= 8.0) {
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"请选择配送时间" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            for (int i = 0; i < 3; i ++) {
                UIAlertAction * dateAction = [UIAlertAction actionWithTitle:dates[i]
                                                                 style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction *action)
                                         {[self reloadDispatchDateWithString:dates[i]];}];
                [alertController addAction:dateAction];
            }
            UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                                  style:UIAlertActionStyleCancel
                                                                handler:^(UIAlertAction *action){}];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];
        } else {
            UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择配送时间" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:dates[0], dates[1], dates[2], nil];
            [actionSheet showInView:self.view];
        }
    }
}

#pragma mark - <UIActionSheetDelegate>
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != 3) {
        [self reloadDispatchDateWithString:[actionSheet buttonTitleAtIndex:buttonIndex]];
    }
}

#pragma mark - 刷新收货时间
- (void)reloadDispatchDateWithString:(NSString *)dateString {
    
    self.currentDispatchDate = dateString;
    [self.detailTexts replaceObjectAtIndex:1
                                withObject:@[dateString]];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - <InputCellDelegate>监听内容修改
- (void)inputCellType:(InputCellType)type content:(NSString *)content {
    
    switch (type) {
        case InputCellTypeScore://积分
        {
            self.currentDiscountScore = [content integerValue];
            self.toolBar.totalPrice = [self.dataSource[@"buycar"][@"totalmoney"] integerValue] - self.currentDiscountScore;
            // 修改积分抵扣cell的内容
            self.detailTexts[4][2] = [NSString stringWithFormat:@"￥%ld.00", (long)self.currentDiscountScore];
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:2 inSection:4];
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
            break;
        case InputCellTypeInvoice://发票
            self.currentInvoiceHead = content;
            break;
        default:
            break;
    }
}

#pragma mark - <OpenSectionCellDelegate>监听留言内容
- (void)openSectionCellLeaveMessage:(NSString *)content {
    
    self.leaveMessage = content;
}

#pragma mark - <TotalPriceToolBarDelegate>监听提交订单按钮点击
- (void)shouldSubmitOrder {
    
    if (self.currentDispatchDate == nil || self.address == nil) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"配送时间和地址是必填的哦~" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    //可选填内容判断
    if (self.leaveMessage == nil) {
        self.leaveMessage = @"";
    }
    
    if (self.currentInvoiceHead == nil) {
        self.currentInvoiceHead = @"";
    }
    NSDictionary * params = @{
                              @"ddno":self.dataSource[@"ddno"],
                              @"username":self.address[@"truename"],
                              @"phone":self.address[@"phone"],
                              @"address":self.address[@"addressname"],
                              @"fptt":self.currentInvoiceHead,//发票抬头
                              @"fpname":self.leaveMessage,//订单留言
                              @"besttime":self.currentDispatchDate,//送货时间
                              @"userbuyfen":@(self.currentDiscountScore*100)//抵扣积分
                              };
    [GlobalMethod serviceWithMothedName:SubmitOrder_Url parmeter:params success:^(id responseObject) {
        [AutoDismissBox showBoxWithTitle:@"恭喜您" message:@"订单提交成功！"];
        // 如果使用了积分，需要刷新用户信息
        if (self.currentDiscountScore > 0) {
            [GlobalMethod getUserInfoSuccess:^(id responseObject) {}];
        }
        [self.navigationController popViewControllerAnimated:YES];
        if ([Framework controllers].shoppingCartVC) {
            [[Framework controllers].shoppingCartVC showNoDataView];
        }
    } fail:^(NSError *error) {}];
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

#pragma mark - 刷新地址
- (void)refreshAddress {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self.address = [[User loginUser] getDefaultAddress];
    });
    
    if ([[User loginUser].userAddressList isKindOfClass:[NSNull class]]) {//没有地址
        self.address = nil;
    } else if ([User loginUser].userAddressList.count == 1 //有一个地址，为默认地址
               || [[User loginUser].userAddressList indexOfObject:self.address] == NSNotFound){//地址被删除
        self.address = [[User loginUser] getDefaultAddress];//显示默认地址
    }
    
    [self.tableView reloadData];
}

- (BOOL)isTodayDispatch {
    
    NSDate * currentDate = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH"];
    NSString * strHour = [dateFormatter stringFromDate:currentDate];
    // 判断当前时间
    if ([strHour intValue] >= 15) {
        return NO;
    }
    return YES;
}

- (NSArray *)dateArrays {
    
    BOOL isTodayDispatch = [self isTodayDispatch];
    NSMutableArray * dates = [[NSMutableArray alloc] init];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM月dd日"];
    NSDate * today = [NSDate date];
    NSDate * tomorrow = [NSDate dateWithTimeIntervalSinceNow:3600.0*24];
    NSDate * afterTomorrow = [NSDate dateWithTimeIntervalSinceNow:3600.0*24*2];
    NSString * todayString = [dateFormatter stringFromDate:today];
    NSString * tomorrowString = [dateFormatter stringFromDate:tomorrow];
    NSString * afterTomorrowString = [dateFormatter stringFromDate:afterTomorrow];
    if (isTodayDispatch == YES) {
        //符合今天发货
        [dates addObject:[todayString stringByAppendingString:PMTime]];
        [dates addObject:[tomorrowString stringByAppendingString:AMTime]];
        [dates addObject:[tomorrowString stringByAppendingString:PMTime]];
    } else {
        //不能今天发货
        [dates addObject:[tomorrowString stringByAppendingString:AMTime]];
        [dates addObject:[tomorrowString stringByAppendingString:PMTime]];
        [dates addObject:[afterTomorrowString stringByAppendingString:AMTime]];
    }
    return dates;
}

#pragma mark - switch action event
- (void)switchValueChanged:(UISwitch *)sender {

    NSInteger index = sender.superview.tag - ContentViewTagBase;
    self.currentSwitchSection = index;
    if (sender.on == YES) {
        if (index == 2) {//积分抵扣
            // 修改数据源
            [self.texts replaceObjectAtIndex:index withObject:@[@"支付方式",@"积分抵扣", [NSString stringWithFormat:@"可用积分:%@(100=1元)", [User loginUser].score]]];
            [self.detailTexts replaceObjectAtIndex:index withObject:@[@"货到付款",@"", @""]];
            [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:index]] withRowAnimation:UITableViewRowAnimationAutomatic];
        } else if (index == 5) {//发票
            [self.texts replaceObjectAtIndex:index withObject:@[@"是否索要发票", @"请输入发票抬头"]];
            [self.detailTexts replaceObjectAtIndex:index withObject:@[@"",@""]];
            [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:index]] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    } else {
        if (index == 2) {//积分抵扣
            // 修改数据源
            [self.texts replaceObjectAtIndex:index withObject:@[@"支付方式",@"积分抵扣"]];
            [self.detailTexts replaceObjectAtIndex:index withObject:@[@"货到付款",@""]];
            [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:index]] withRowAnimation:UITableViewRowAnimationAutomatic];
        } else if (index == 5) {//发票
            [self.texts replaceObjectAtIndex:index withObject:@[@"是否索要发票"]];
            [self.detailTexts replaceObjectAtIndex:index withObject:@[@""]];
            [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:index]] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
}

@end
