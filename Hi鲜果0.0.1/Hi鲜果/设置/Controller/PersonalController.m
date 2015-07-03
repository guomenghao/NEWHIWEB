//
//  PersonalController.m
//  Hi鲜果
//
//  Created by rimi on 15/6/29.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "PersonalController.h"
#import "PersonalCustomCell.h"
#import "ChangeHeadImage.h"
#import "AddrAdminController.h"

@interface PersonalController () <UITableViewDelegate, UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,UIAlertViewDelegate> {
    BOOL _isTouch;
    BOOL _isChange;
    BOOL _isBirth;
    BOOL _isSec;
    BOOL _isName;
}
@property (strong, nonatomic) NSArray * dataSource;
@property (strong, nonatomic) UITableView * tableView;
@property (strong, nonatomic) UIDatePicker * birthPicker;
@property (strong, nonatomic) NSDateFormatter * dataFormatter;
@property (strong, nonatomic) UIPickerView * sexPicker;
@property (strong, nonatomic) ChangeHeadImage *changeHadeImage;

@end

@implementation PersonalController

- (ChangeHeadImage *)changeHadeImage
{
    if (_changeHadeImage == nil) {
        _changeHadeImage = [[ChangeHeadImage alloc] init];
    }
    return _changeHadeImage;
}

- (UIPickerView *)sexPicker
{
    if (_sexPicker == nil) {
        _sexPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, Screen_height, Screen_width, 180)];
        _sexPicker.backgroundColor = [UIColor colorWithWhite:0.900 alpha:1.000];
        _sexPicker.delegate = self;
        _sexPicker.dataSource = self;
    }
    return _sexPicker;
}

- (NSDateFormatter *)dataFormatter
{
    if (_dataFormatter == nil) {
        _dataFormatter = [[NSDateFormatter alloc] init];
        [_dataFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    return _dataFormatter;
}

- (UIDatePicker *)birthPicker
{
    if (_birthPicker == nil) {
        _birthPicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, Screen_height, Screen_width, 215)];
        _birthPicker.backgroundColor = [UIColor colorWithWhite:0.900 alpha:1.000];
    }
    return _birthPicker;
}

#pragma mark - 初始化方法
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"个人信息";
        [Framework controllers].personalVC = self;
    }
    return self;
 }

- (void)initializeDataSource {
    
    self.dataSource = @[@"头像", @"昵称", @"会员等级", @"性别", @"生日", @"地址管理"];
}

- (void)initializeUserInterface {
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(isBack)];
    self.navigationItem.leftBarButtonItem = backItem;
    
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(isSave)];
    self.navigationItem.rightBarButtonItem = saveItem;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.scrollEnabled = NO;
    [GlobalControl myControl].tableView = self.tableView;
    [self.view addSubview:self.tableView];
}

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
    [self.view addSubview:self.sexPicker];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.tabBarController.tabBar.hidden = YES;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
//返回当前列显示的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [@[@"帅哥", @"美女", @"保密"] count];
}

#pragma mark Picker Delegate Methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [@[@"帅哥", @"美女", @"保密"] objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [User loginUser].tempSex.text = @[@"帅哥", @"美女", @"保密"][row];
}

#pragma mark - <UITableViewDataSource/UITabelViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return Screen_height * 0.2;
    }
    return Screen_height * 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * identifier = @"personal";
    PersonalCustomCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[PersonalCustomCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.textLabel.font = [UIFont boldSystemFontOfSize:Screen_width / 22];
    [GlobalMethod removeAllSubViews:cell.contentView];
    if (indexPath.row == 0) {
        [cell getHeadImageView];
    }
    if (indexPath.row == 1) {
        [cell getUserName];
    }
    if (indexPath.row == 2) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell getVipLevel];
    }
    if (indexPath.row == 3) {
        [cell getSex];
    }
    if (indexPath.row == 4) {
        [cell getBirthday];
    }
    if (indexPath.row == 5) {
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    cell.textLabel.text = self.dataSource[indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        tableView.userInteractionEnabled = NO;
        _isTouch = YES;
        [self.view addSubview:self.changeHadeImage];
        [UIView animateWithDuration:0.7 animations:^{
            self.changeHadeImage.transform = CGAffineTransformIdentity;
            self.changeHadeImage.center = CGPointMake(Screen_width / 2, Screen_height / 2);
        } completion:^(BOOL finished) {
            _isTouch = NO;
        }];
    }
    if (indexPath.row == 1) {
        tableView.userInteractionEnabled = NO;
        [[User loginUser].tempName becomeFirstResponder];
    }
    if (indexPath.row == 3) {
        _isSec = YES;
        tableView.userInteractionEnabled = NO;
        [self sexPickerTop];
    }
    if (indexPath.row == 4) {
        _isBirth = YES;
        tableView.userInteractionEnabled = NO;
        NSDate *date = [self.dataFormatter dateFromString:[User loginUser].tempBirthday.text];
        self.birthPicker.date = date;
        self.birthPicker.datePickerMode = UIDatePickerModeDate;
        [self pickerTpo];
    }
    if (indexPath.row == 5) {
        [self.navigationController pushViewController:[[AddrAdminController alloc] init] animated:YES];
    }
    if (indexPath.row != 2) {
        _isChange = YES;
    }
}

- (void)sexPickerTop
{
    [self.view addSubview:self.sexPicker];
    [UIView animateWithDuration:0.25 animations:^{
        self.sexPicker.center = CGPointMake(Screen_width / 2, Screen_height - 180 / 2);
    }];
}

- (void)pickerTpo
{
    [self.view addSubview:self.birthPicker];
    [UIView animateWithDuration:0.25 animations:^{
        self.birthPicker.center = CGPointMake(Screen_width / 2, Screen_height - 215 / 2);
    }];
}

- (void)pickerDwon
{
    if (_isBirth) {
        [User loginUser].tempBirthday.text = [self.dataFormatter stringFromDate:self.birthPicker.date];
        _isBirth = NO;
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.birthPicker.center = CGPointMake(Screen_width / 2, Screen_height + 215 / 2);
        self.sexPicker.center = CGPointMake(Screen_width / 2, Screen_height + 180 / 2);
    } completion:^(BOOL finished) {
        [self.birthPicker removeFromSuperview];
        [self.sexPicker removeFromSuperview];
    }];
    [UIView animateWithDuration:0.7 animations:^{
        self.changeHadeImage.transform = CGAffineTransformMakeScale(0.01, 0.01);
        self.changeHadeImage.center = CGPointMake(Screen_width - (Screen_height / 5 + 10) / 2, 74 + (Screen_height / 5 - 20) / 2);
    } completion:^(BOOL finished) {
        self.tableView.userInteractionEnabled = YES;
        [self.changeHadeImage removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!_isTouch) {
        [[User loginUser].tempName resignFirstResponder];
        [self pickerDwon];
    }
}

- (void)isBack
{
    if (_isChange) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已修改过信息，确定返回吗" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alert show];
    } else {
        [self popBack];
    }
}

- (void)isSave
{
    /**
     *  保存临时信息到服务器
     */
    [self popBack];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self popBack];
            break;
        default:
            break;
    }
}

- (void)popBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
