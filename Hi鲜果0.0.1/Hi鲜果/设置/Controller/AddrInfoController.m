//
//  AddrInfoController.m
//  Hi鲜果
//
//  Created by 李波 on 15/7/5.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "AddrInfoController.h"

@interface AddrInfoController ()<UITextFieldDelegate,UIAlertViewDelegate> {
    BOOL _isChange;
}

@property (nonatomic, strong) UITextField *name;
@property (nonatomic, strong) UITextField *phone;
@property (nonatomic, strong) UITextField *addr;

@end

@implementation AddrInfoController

- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
}

- (instancetype)initWithData:(NSMutableDictionary *)data isAmend:(BOOL)amend index:(int)index
{
    self = [self init];
    self.isAmend = amend;
    self.data = data;
    self.title = @"新增地址";
    if (amend) {
        self.index = index;
        self.title = @"编辑地址";
    }
    self.view.backgroundColor = [UIColor whiteColor];
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
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:ImageWithName(@"fanhui.png") style:UIBarButtonItemStylePlain target:self action:@selector(isBack)];
    self.navigationItem.leftBarButtonItem = backItem;
    
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithImage:ImageWithName(@"gougou.png") style:UIBarButtonItemStylePlain target:self action:@selector(saveAddrs)];
    self.navigationItem.rightBarButtonItem = save;
    
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(Screen_height / 30, Screen_height / 30 + 64, Screen_width - Screen_height / 30 * 2, Screen_height / 30)];
    nameLabel.text = @"姓名：";
    nameLabel.font = FontWithWidth(20);
    [self.view addSubview:nameLabel];
    
    self.name = [[UITextField alloc] initWithFrame:CGRectMake(Screen_height / 30, CGRectGetMaxY(nameLabel.frame) + Screen_height / 30 / 2, Screen_width - Screen_height / 30 * 2, Screen_height / 23)];
    self.name.text = self.isAmend ? self.data[@"truename"] : nil;
    self.name.font = FontWithWidth(22);
    self.name.tag = 301;
    self.name.delegate = self;
    [self.view addSubview:self.name];
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(Screen_height / 30, CGRectGetMaxY(self.name.frame) + Screen_height / 30 / 2, Screen_width - Screen_height / 30 * 2, Screen_height / 30)];
    phoneLabel.text = @"电话：";
    phoneLabel.font = FontWithWidth(20);

    [self.view addSubview:phoneLabel];
    
    self.phone = [[UITextField alloc] initWithFrame:CGRectMake(Screen_height / 30, CGRectGetMaxY(phoneLabel.frame) + Screen_height / 30 / 2, Screen_width - Screen_height / 30 * 2, Screen_height / 23)];
    self.phone.text = self.isAmend ? self.data[@"phone"] : nil;
    self.phone.font = FontWithWidth(22);
    self.phone.tag = 302;
    self.phone.delegate = self;
    self.phone.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.phone];
    
    UILabel *addrLabel = [[UILabel alloc] initWithFrame:CGRectMake(Screen_height / 30, CGRectGetMaxY(self.phone.frame) + Screen_height / 30 / 2, Screen_width - Screen_height / 30 * 2, Screen_height / 30)];
    addrLabel.text = @"地址：";
    addrLabel.font = FontWithWidth(20);
    [self.view addSubview:addrLabel];
    
    self.addr = [[UITextField alloc] initWithFrame:CGRectMake(Screen_height / 30, CGRectGetMaxY(addrLabel.frame) + Screen_height / 30 / 2, Screen_width - Screen_height / 30 * 2, Screen_height / 23)];
    self.addr.text = self.isAmend ? self.data[@"addressname"] : nil;
    self.addr.font = FontWithWidth(22);
    self.addr.tag = 303;
    self.addr.delegate = self;
    [self.view addSubview:self.addr];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 8, Screen_height / 23)];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 8, Screen_height / 23)];
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 8, Screen_height / 23)];
    self.name.layer.borderWidth = 0.5;
    self.name.leftViewMode = UITextFieldViewModeAlways;
    self.name.leftView = label1;
    self.phone.layer.borderWidth = 0.5;
    self.phone.leftViewMode = UITextFieldViewModeAlways;
    self.phone.leftView = label2;
    self.addr.layer.borderWidth = 0.5;
    self.addr.leftViewMode = UITextFieldViewModeAlways;
    self.addr.leftView = label3;
    
    if (self.isAmend) {
        UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteButton.frame = CGRectMake(Screen_width / 3, CGRectGetMaxY(self.addr.frame) + Screen_height / 30, Screen_width / 3, Screen_height / 20);
        deleteButton.layer.borderColor = [UIColor orangeColor].CGColor;
        deleteButton.layer.borderWidth = Screen_height / 400;
        deleteButton.layer.cornerRadius = Screen_height / 40;
        [deleteButton setTitle:@"删除地址" forState:UIControlStateNormal];
        [deleteButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        deleteButton.titleLabel.font = FontWithWidth(22);
        [deleteButton addTarget:self action:@selector(deleteAddr) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:deleteButton];
        
        // 添加“设为默认地址”按钮
        UIButton *defaultButton = [UIButton buttonWithType:UIButtonTypeCustom];
        defaultButton.frame = CGRectMake(Screen_width / 3, CGRectGetMaxY(deleteButton.frame) + Screen_height / 30, Screen_width / 3, Screen_height / 20);
        defaultButton.layer.borderColor = [UIColor orangeColor].CGColor;
        defaultButton.layer.borderWidth = Screen_height / 400;
        defaultButton.layer.cornerRadius = Screen_height / 40;
        [defaultButton setTitle:@"设为默认地址" forState:UIControlStateNormal];
        [defaultButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        defaultButton.titleLabel.font = FontWithWidth(22);
        [defaultButton addTarget:self action:@selector(defaultAddr) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:defaultButton];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 301) {
        if (range.location > 9 ) {
            return NO;
        }
    }
    if (textField.tag == 302) {
        if (range.location > 10 ) {
            return NO;
        }
    }
    if (textField.tag == 303) {
        if (range.location > 39 ) {
            return NO;
        }
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _isChange = YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if (textField.tag == 301) {
        if (textField.text.length > 10 ) {
            textField.text = [textField.text substringToIndex:10];
        }
    }
    if (textField.tag == 303) {
        if (textField.text.length > 40 ) {
            textField.text = [textField.text substringToIndex:40];
        }
    }
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (void)saveAddrs
{
    [self.view endEditing:YES];
    if ([GlobalMethod validateMobile:self.phone.text] && self.name.text.length > 0 && self.addr.text.length > 0) {
        
        NSMutableDictionary *data = [@{@"truename" : self.name.text,
                               @"phone" : self.phone.text,
                               @"addressname" : self.addr.text,
                               @"userid" : [User loginUser].userid} mutableCopy];
        /**
         *  不同的方式保存到临时信息
         */
        if (self.isAmend) {
            [data setObject:self.data[@"addressid"] forKey:@"addressid"];
            [User loginUser].tempAddrs[self.index] = data;
            [GlobalMethod serviceWithMothedName:EditAddress_Url parmeter:data success:^(id responseObject) {
                if ([responseObject[@"err_msg"] isEqual:@"success"]) {
                    [GlobalMethod getUserInfoSuccess:^(id responseObject) {
                        [self reloadAddrs];
                        [self popBack];
                    }];
                }
            } fail:^(NSError *error) {
                
            }];
        } else {
            [GlobalMethod serviceWithMothedName:AddAddress_Url parmeter:data success:^(id responseObject) {
                if ([responseObject[@"err_msg"] isEqual:@"success"]) {
                    [GlobalMethod getUserInfoSuccess:^(id responseObject) {
                        [self reloadAddrs]; 
                        NSLog(@"%@",responseObject);
                        [self popBack];
                    }];
                }
            } fail:^(NSError *error) {
                
            }];
        }
    } else {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的电话号码，且姓名地址不能为空" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
        [self.view endEditing:YES];
        [alert show];
    }
    
}

- (void)isBack
{
    [self.view endEditing:YES];
    if (self.isAmend) {
        if (_isChange) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已修改过信息，确定返回吗" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            alert.tag = 310;
            [alert show];
        } else {
            [self popBack];
        }
    } else {
        [self popBack];
    }
}

- (void)popBack
{
    [[Framework controllers].addrAdminVC.tableView reloadData];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 310) {
        if (buttonIndex == 0) {
            [self performSelector:@selector(popBack) withObject:nil afterDelay:0.25];
        }
    }
    if (alertView.tag == 311) {
        if (buttonIndex == 0) {
            [self performSelector:@selector(deleteAddrs) withObject:nil afterDelay:0.25];
        }
    }
}

- (void)deleteAddr
{
    [self.view endEditing:YES];
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定删除此地址吗" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alert.tag = 311;
    [alert show];
}

- (void)defaultAddr {
    
    [self.view endEditing:YES];
    if ([GlobalMethod validateMobile:self.phone.text] && self.name.text.length > 0 && self.addr.text.length > 0) {
        NSMutableDictionary *data = [@{@"truename" : self.name.text,
                                       @"phone" : self.phone.text,
                                       @"addressname" : self.addr.text,
                                       @"userid" : [User loginUser].userid,
                                       @"isdefault" : @"0"} mutableCopy];
        /**
         *  不同的方式保存到临时信息
         */
        if (self.isAmend) {
            [data setObject:self.data[@"addressid"] forKey:@"addressid"];
            [User loginUser].tempAddrs[self.index] = data;
            [GlobalMethod serviceWithMothedName:EditAddress_Url parmeter:data success:^(id responseObject) {
                if ([responseObject[@"err_msg"] isEqual:@"success"]) {
                    NSLog(@"编辑地址成功，返回：%@", responseObject);
                    [GlobalMethod getUserInfoSuccess:^(id responseObject) {

                    }];
                }
            } fail:^(NSError *error) {
                
            }];
        }
    } else {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的电话号码，且姓名地址不能为空" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
        [self.view endEditing:YES];
        [alert show];
    }
}

- (void)deleteAddrs
{
    /**
     *  删除临时数据中地址
     */
    NSLog(@"%@", self.data[@"addressid"]);
    [GlobalMethod serviceWithMothedName:DelAddress_Url parmeter:@{@"addressid" : self.data[@"addressid"]} success:^(id responseObject) {
        if ([responseObject[@"err_msg"] isEqual:@"success"]) {
            [GlobalMethod getUserInfoSuccess:^(id responseObject) {
                [self reloadAddrs];
                [self popBack];
            }];
        }
    } fail:^(NSError *error) {
        
    }];
}

- (void)reloadAddrs
{
    if ([[User loginUser].userAddressList isEqual:[NSNull null]]) {
        [Framework controllers].addrAdminVC.dataSource = [NSMutableArray array];
    } else {
        [Framework controllers].addrAdminVC.dataSource = [[User loginUser].userAddressList mutableCopy];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.tabBarController.tabBar.hidden = YES;
}

@end
