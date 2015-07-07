//
//  LoginController.m
//  Hi鲜果
//
//  Created by 吕玉梅 on 15/6/26.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "LoginController.h"
#import "GlobalMethod.h"
#define Margin 50*[FlexibleFrame ratios].height

@interface LoginController () <UITextFieldDelegate, UIAlertViewDelegate>
@property (strong, nonatomic) UITextField * accountField;
@property (strong, nonatomic) UITextField * passwordField;
@end

@implementation LoginController

- (void)dealloc {
    
    NSLog(@"%s", __FUNCTION__);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"登录";
        self.controllerType = UIViewControllerNavigationTransluct;
        [Framework controllers].loginVC = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /**设置背景图片*/
    self.view.layer.contents = (__bridge id)ImageWithName(@"bkImage.jpg").CGImage;
    /**添加控件*/
    self.accountField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 250 * [FlexibleFrame ratios].width, 30 * [FlexibleFrame ratios].height)];
        [textField setFont:MiddleFont];
        textField.center = CGPointMake(self.view.bounds.size.width / 2, 230 * [FlexibleFrame ratios].height);
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        textField.placeholder = @"请输入手机号";
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.delegate = self;
        [textField setReturnKeyType:UIReturnKeyDone];
        textField;
    });
    [self.view addSubview:self.accountField];
    
    UILabel * accountLabel = ({
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(self.accountField.frame.origin.x, self.accountField.frame.origin.y - 30, 80, 30)];
        [label setFont:MiddleFont];
        label.textColor = [UIColor orangeColor];
        label.text = @"手机号：";
        label;
    });
    [self.view addSubview:accountLabel];
    
    UILabel * passwordLabel = ({
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(self.accountField.frame.origin.x, CGRectGetMaxY(self.accountField.frame) + Margin, 80, 30)];
        [label setFont:MiddleFont];
        label.textColor = [UIColor orangeColor];
        label.text = @"密码：";
        label.textAlignment = NSTextAlignmentLeft;
        label;
    });
    [self.view addSubview:passwordLabel];
    
    self.passwordField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(self.accountField.frame.origin.x, CGRectGetMaxY(passwordLabel.frame), self.accountField.bounds.size.width, 30 * [FlexibleFrame ratios].height)];
        [textField setFont:MiddleFont];
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        textField.keyboardType = UIKeyboardTypeASCIICapable;
        textField.secureTextEntry = YES;
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.delegate = self;
        [textField setReturnKeyType:UIReturnKeyDone];
        textField;
    });
    [self.view addSubview:self.passwordField];
    
    // 登录和注册按钮
    UIButton * loginButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(self.accountField.frame.origin.x, CGRectGetMaxY(self.passwordField.frame) + Margin, self.accountField.bounds.size.width, 30 * [FlexibleFrame ratios].height)];
        [button setTitle:@"登 录" forState:UIControlStateNormal];
        [button setBackgroundColor:BtnBkColor];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:MiddleFont];
        button.layer.cornerRadius = button.bounds.size.width / 32;
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self.view addSubview:loginButton];
    
    UIButton * registerButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(self.accountField.frame.origin.x, CGRectGetMaxY(loginButton.frame) + 10 * [FlexibleFrame ratios].height, self.accountField.bounds.size.width, 30 * [FlexibleFrame ratios].height)];
        [button setTitle:@"注 册" forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:MiddleFont];
        button.layer.cornerRadius = button.bounds.size.width / 32;
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self.view addSubview:registerButton];
    
    // test
    self.accountField.text = @"17608005879";
    self.passwordField.text = @"123456";
}

- (void)buttonPressed:(UIButton *)sender {
    
    if ([sender.currentTitle isEqualToString:@"登 录"]) {
        [sender setEnabled:NO];//禁用按钮
        UIActivityIndicatorView * indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        indicator.center = CGPointMake(self.view.center.x, self.view.center.y);
        [indicator startAnimating];
        
        [GlobalMethod NotHaveAlertServiceWithMothedName:Login_Url
                                   parmeter:@{@"username":self.accountField.text,
                                              @"password":self.passwordField.text}
                                    success:^(id responseObject) {
                                        NSLog(@"%@", responseObject);
                                        [indicator stopAnimating];
                                        [indicator removeFromSuperview];
                                        NSString * msg = responseObject[@"err_msg"];
                                        if ([msg isEqualToString:@"success"]) {
                                            NSLog(@"===>登录成功：返回%@", responseObject);
                                            [GlobalMethod getUserInfoSuccess:^(id responseObject) {
                                            }];
                                        } else {
                                            [sender setEnabled:YES];
                                        }
                                        
                                        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:responseObject[@"info"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                                        [alert show];
                                    }
                                       fail:^(NSError *error) {
                                           [sender setEnabled:YES];//取消禁用按钮
                                           NSLog(@"error：%@", [error localizedDescription]);
                                       }];
        
    } else if ([sender.currentTitle isEqualToString:@"注 册"]) {
        
        [self.navigationController pushViewController:[[RegisterController alloc] init] animated:YES];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];
}

#pragma mark - <UITextFieldDelegate>
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    if (textField == self.accountField
        && textField.text.length > 0 && ![GlobalMethod validateMobile:self.accountField.text]) {
        [self showInvalideAnimationViewWithTips:@"您输入的手机号有误"];
    }
    return YES;
}

//输入不合法时弹出提示框
- (void)showInvalideAnimationViewWithTips:(NSString *)tips {
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"错误提示" message:tips delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    [alert show];
}

#pragma mark - <UIAlertViewDelegate>
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
//        if ([self.navigationController.viewControllers[self.navigationController.viewControllers.count - 2] isKindOfClass:[FruitDetailsController class]]) {
//            [self.navigationController popViewControllerAnimated:NO];
//            [[Framework controllers].fruitDetailVC.navigationController pushViewController:[[SubmitOrderController alloc]init] animated:YES];
//            return;
//        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end
