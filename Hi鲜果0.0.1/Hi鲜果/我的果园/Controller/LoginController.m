//
//  LoginController.m
//  Hi鲜果
//
//  Created by 吕玉梅 on 15/6/26.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "LoginController.h"
#define Margin 50*[FlexibleFrame ratios].height
#define MiddleFont ([UIFont systemFontOfSize:15*[FlexibleFrame ratios].height])
@interface LoginController () <UITextFieldDelegate>

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
    UITextField * accountField = ({
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
    [self.view addSubview:accountField];
    
    UILabel * accountLabel = ({
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(accountField.frame.origin.x, accountField.frame.origin.y - 30, 80, 30)];
        [label setFont:MiddleFont];
        label.textColor = [UIColor orangeColor];
        label.text = @"账号：";
        label;
    });
    [self.view addSubview:accountLabel];
    
    UILabel * passwordLabel = ({
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(accountField.frame.origin.x, CGRectGetMaxY(accountField.frame) + Margin, 80, 30)];
        [label setFont:MiddleFont];
        label.textColor = [UIColor orangeColor];
        label.text = @"密码：";
        label.textAlignment = NSTextAlignmentLeft;
        label;
    });
    [self.view addSubview:passwordLabel];
    
    UITextField * passwordField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(accountField.frame.origin.x, CGRectGetMaxY(passwordLabel.frame), accountField.bounds.size.width, 30 * [FlexibleFrame ratios].height)];
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
    [self.view addSubview:passwordField];
    
    // 登录和注册按钮
    UIButton * loginButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(accountField.frame.origin.x, CGRectGetMaxY(passwordField.frame) + Margin, accountField.bounds.size.width, 30 * [FlexibleFrame ratios].height)];
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
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(accountField.frame.origin.x, CGRectGetMaxY(loginButton.frame) + 10 * [FlexibleFrame ratios].height, accountField.bounds.size.width, 30 * [FlexibleFrame ratios].height)];
        [button setTitle:@"注 册" forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:MiddleFont];
        button.layer.cornerRadius = button.bounds.size.width / 32;
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self.view addSubview:registerButton];
}

- (void)buttonPressed:(UIButton *)sender {
    
    if ([sender.currentTitle isEqualToString:@"登 录"]) {
        
        NSLog(@"点击登录，登录成功");
        // 验证成功
        // 修改loginUser的登录标记
        [User loginUser].isLogin = YES;
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
@end
