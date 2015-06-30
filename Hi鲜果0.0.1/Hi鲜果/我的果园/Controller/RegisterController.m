//
//  RegisterController.m
//  Hi鲜果
//
//  Created by rimi on 15/6/30.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "RegisterController.h"
#define Margin 50*[FlexibleFrame ratios].height
#define MiddleFont ([UIFont systemFontOfSize:15*[FlexibleFrame ratios].height])
@interface RegisterController () <UITextFieldDelegate>

@end

@implementation RegisterController

- (void)dealloc {
    
    NSLog(@"%s", __FUNCTION__);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"注册";
        self.controllerType = UIViewControllerNavigationTransluct;
        [Framework controllers].registerVC = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)initializeDataSource {
    
    
}

- (void)initializeUserInterface {
    
    /**设置背景图片*/
    self.view.layer.contents = (__bridge id)ImageWithName(@"bkImage.jpg").CGImage;
    /**添加控件*/
    UITextField * phoneField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 222 * [FlexibleFrame ratios].width, 30 * [FlexibleFrame ratios].height)];
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
    [self.view addSubview:phoneField];
    
    UILabel * accountLabel = ({
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(phoneField.frame.origin.x, phoneField.frame.origin.y - 30, 80, 30)];
        [label setFont:MiddleFont];
        label.textColor = [UIColor orangeColor];
        label.text = @"请输入邮箱：";
        label;
    });
    [self.view addSubview:accountLabel];
    
    UILabel * passwordLabel = ({
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(phoneField.frame.origin.x, CGRectGetMaxY(phoneField.frame) + Margin, 80, 30)];
        [label setFont:MiddleFont];
        label.textColor = [UIColor orangeColor];
        label.text = @"密码：";
        label.textAlignment = NSTextAlignmentLeft;
        label;
    });
    [self.view addSubview:passwordLabel];
    
    UITextField * passwordField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(phoneField.frame.origin.x, CGRectGetMaxY(passwordLabel.frame), phoneField.bounds.size.width, 30 * [FlexibleFrame ratios].height)];
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
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(phoneField.frame.origin.x, CGRectGetMaxY(passwordField.frame) + Margin, phoneField.bounds.size.width, 30 * [FlexibleFrame ratios].height)];
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
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(phoneField.frame.origin.x, CGRectGetMaxY(loginButton.frame) + 10 * [FlexibleFrame ratios].height, phoneField.bounds.size.width, 30 * [FlexibleFrame ratios].height)];
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
        

    } else if ([sender.currentTitle isEqualToString:@"注 册"]) {
        
       
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
