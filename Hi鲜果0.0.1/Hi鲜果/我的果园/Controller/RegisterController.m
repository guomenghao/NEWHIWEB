//
//  RegisterController.m
//  Hi鲜果
//
//  Created by rimi on 15/6/30.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "RegisterController.h"
#import "GlobalMethod.h"
#define Margin 40*[FlexibleFrame ratios].height
#define MiddleFont ([UIFont systemFontOfSize:15*[FlexibleFrame ratios].height])
#define NUMBERS @"0123456789"
#define TextFieldTagBase 110
@interface RegisterController () <UITextFieldDelegate>
/**手机号有效性*/
@property (assign, nonatomic) BOOL phoneValide;
/**验证码有效性*/
@property (assign, nonatomic) BOOL verifyValide;
/**邮箱有效性*/
@property (assign, nonatomic) BOOL emailValide;
/**密码有效性*/
@property (assign, nonatomic) BOOL passwordValide;
@property (strong, nonatomic) UITextField * phoneField;
@property (strong, nonatomic) UITextField * emailField;
@property (strong, nonatomic) UIButton * registerButton;
@property (strong, nonatomic) UIButton * sendCode;
@property (strong, nonatomic) NSString * password;

/**输入不合法时提示框*/
- (void)showInvalideAnimationViewWithTips:(NSString *)tips;

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
        self.view.backgroundColor = RGBAColor(231, 236, 238, 1);
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
    //self.view.layer.contents = (__bridge id)ImageWithName(@"bkImage.jpg").CGImage;
    /**添加控件*/
    self.phoneField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 250*[FlexibleFrame ratios].width, 30 * [FlexibleFrame ratios].height)];
        textField.center = CGPointMake(self.view.bounds.size.width / 2, 100*[FlexibleFrame ratios].height);
        [textField setFont:MiddleFont];
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        textField.placeholder = @"请输入11位手机号";
        textField.backgroundColor = [UIColor whiteColor];
        textField.delegate = self;
        textField.tag = TextFieldTagBase;
        //发送验证码按钮
        self.sendCode = ({
            UIButton * sendCode = [UIButton buttonWithType:UIButtonTypeCustom];
            sendCode.frame = CGRectMake(0, 0, 80 * [FlexibleFrame ratios].width, textField.bounds.size.height);
            sendCode.titleLabel.font = MiddleFont;
            [sendCode setTitle:@"获取验证码" forState:UIControlStateNormal];
            [sendCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [sendCode addTarget:self action:@selector(sendVerificationCode:) forControlEvents:UIControlEventTouchUpInside ];
            sendCode;
        });
        [self setSendVerificationCodeButtonWithSelected:NO];
        textField.rightView = self.sendCode;
        textField.rightViewMode = UITextFieldViewModeAlways;
        [textField setReturnKeyType:UIReturnKeyDone];
        textField;
    });
    [self.view addSubview:self.phoneField];
    
    UIImageView * phoneIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    phoneIcon.contentMode = UIViewContentModeScaleAspectFill;
    phoneIcon.image = ImageWithName(@"icon-phone.png");
    self.phoneField.leftView = phoneIcon;
    self.phoneField.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView * verifyIcon = [[UIImageView alloc] initWithFrame:CGRectMake(phoneIcon.frame.origin.x, Margin + CGRectGetMaxY(phoneIcon.frame), phoneIcon.bounds.size.width, phoneIcon.bounds.size.height)];
    verifyIcon.contentMode = UIViewContentModeScaleAspectFill;
    verifyIcon.image = ImageWithName(@"icon-verify.png");
    
    UIImageView * emailIcon = [[UIImageView alloc] initWithFrame:CGRectMake(phoneIcon.frame.origin.x, Margin + CGRectGetMaxY(verifyIcon.frame), phoneIcon.bounds.size.width, phoneIcon.bounds.size.height)];
    emailIcon.contentMode = UIViewContentModeScaleAspectFill;
    emailIcon.image = ImageWithName(@"icon-email.png");
    
    UIImageView * passIcon = [[UIImageView alloc] initWithFrame:CGRectMake(phoneIcon.frame.origin.x, Margin + CGRectGetMaxY(emailIcon.frame), phoneIcon.bounds.size.width, phoneIcon.bounds.size.height)];
    passIcon.contentMode = UIViewContentModeScaleAspectFill;
    passIcon.image = ImageWithName(@"icon-password.png");
    
    UIImageView * pass2Icon = [[UIImageView alloc] initWithFrame:CGRectMake(phoneIcon.frame.origin.x, Margin + CGRectGetMaxY(passIcon.frame), phoneIcon.bounds.size.width, phoneIcon.bounds.size.height)];
    pass2Icon.contentMode = UIViewContentModeScaleAspectFill;
    pass2Icon.image = ImageWithName(@"icon-password2.png");
    
    UITextField * verifyField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(self.phoneField.frame.origin.x, CGRectGetMaxY(self.phoneField.frame) + Margin, self.phoneField.bounds.size.width, self.phoneField.bounds.size.height)];
        [textField setFont:MiddleFont];
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        textField.keyboardType = UIKeyboardTypeASCIICapable;
        textField.placeholder = @"请输入您收到的验证码";
        textField.backgroundColor = [UIColor whiteColor];
        textField.delegate = self;
        textField.tag = TextFieldTagBase + 1;
        [textField setReturnKeyType:UIReturnKeyDone];
        textField.leftView = verifyIcon;
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField;
    });
    [self.view addSubview:verifyField];
    
    self.emailField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(self.phoneField.frame.origin.x, CGRectGetMaxY(verifyField.frame) + Margin, self.phoneField.bounds.size.width, self.phoneField.bounds.size.height)];
        [textField setFont:MiddleFont];
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        textField.keyboardType = UIKeyboardTypeASCIICapable;
        textField.placeholder = @"请输入邮箱(可选)";
        textField.tag = TextFieldTagBase + 2;
        textField.backgroundColor = [UIColor whiteColor];
        textField.delegate = self;
        [textField setReturnKeyType:UIReturnKeyDone];
        textField.leftView = emailIcon;
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField;
    });
    [self.view addSubview:self.emailField];
    
    UITextField * passwordField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(self.phoneField.frame.origin.x, CGRectGetMaxY(self.emailField.frame) + Margin, self.phoneField.bounds.size.width, self.phoneField.bounds.size.height)];
        [textField setFont:MiddleFont];
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        textField.keyboardType = UIKeyboardTypeASCIICapable;
        textField.secureTextEntry = YES;
        textField.placeholder = @"请输入您的密码";
        textField.tag = TextFieldTagBase + 3;
        textField.backgroundColor = [UIColor whiteColor];
        textField.delegate = self;
        textField.leftView = passIcon;
        textField.leftViewMode = UITextFieldViewModeAlways;
        [textField setReturnKeyType:UIReturnKeyDone];
        textField;
    });
    [self.view addSubview:passwordField];
    
    UITextField * repeatField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(self.phoneField.frame.origin.x, CGRectGetMaxY(passwordField.frame) + Margin, self.phoneField.bounds.size.width, self.phoneField.bounds.size.height)];
        [textField setFont:MiddleFont];
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        textField.keyboardType = UIKeyboardTypeASCIICapable;
        textField.secureTextEntry = YES;
        textField.placeholder = @"请再次输入您的密码";
        textField.tag = TextFieldTagBase + 4;
        textField.backgroundColor = [UIColor whiteColor];
        textField.delegate = self;
        [textField setReturnKeyType:UIReturnKeyDone];
        textField.leftView = pass2Icon;
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField;
    });
    [self.view addSubview:repeatField];
    
    self.registerButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(self.phoneField.frame.origin.x, CGRectGetMaxY(repeatField.frame) + Margin * 2, self.phoneField.bounds.size.width, 30 * [FlexibleFrame ratios].height)];
        [button setTitle:@"注 册" forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:MiddleFont];
        [button addTarget:self action:@selector(registerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self.view addSubview:self.registerButton];
}

- (void)sendVerificationCode:(UIButton *)sender {
    
    if (sender.selected == YES) {
        NSLog(@"发送验证码");
        [self setSendVerificationCodeButtonWithSelected:YES];
    }
}

- (void)setSendVerificationCodeButtonWithSelected:(BOOL)selected {
    
    self.sendCode.selected = selected;
    if (self.sendCode.selected == NO) {
        [self.sendCode setBackgroundColor:[UIColor grayColor]];
    } else {
        [self.sendCode setBackgroundColor:[UIColor orangeColor]];
    }
}
#pragma mark - 注册按钮点击
- (void)registerButtonPressed:(UIButton *)sender {
    
    if (self.phoneValide && self.verifyValide && (self.emailValide || self.emailField.text.length == 0)&& self.passwordValide) {
        [GlobalMethod serviceWithMothedName:Register_Url
                                   parmeter:@{@"username":self.phoneField.text,
                                              @"password":self.password,
                                              @"email":self.emailField.text,
                                              @"groupid":@"1"}
                                    success:^(id responseObject) {
                                        
                                        NSLog(@"注册成功：%@", responseObject);
                                    }
                                       fail:^(NSError *error) {
                                           NSLog(@"%@", [error localizedDescription]);
                                       }];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

#pragma mark - <UITextFieldDelegate>
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    if (self.phoneValide && self.verifyValide && (self.emailValide || self.emailField.text.length == 0)&& self.passwordValide) {
        [self.registerButton setBackgroundColor:[UIColor orangeColor]];
        [self.registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSInteger index = textField.tag - TextFieldTagBase;
    
    if (index == 0) {//手机号
        if (range.location == 10 && textField.text.length == 10) {
            //是否合法
            NSString * phone = [textField.text stringByAppendingString:string];
            if ([GlobalMethod validateMobile:phone]) {
                self.phoneValide = YES;
                [self setSendVerificationCodeButtonWithSelected:YES];
            } else {
                self.phoneValide = NO;
            }
        } else if (range.location < 11) {
            [self setSendVerificationCodeButtonWithSelected:NO];
        }
        
        if (range.location == 11){
            return NO;
        }
        //只能输入数字
        NSCharacterSet * cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
        NSString * filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest) {
            return NO;
        }
        return YES;

    } else if (index == 1) {//验证码
        
        if (range.location == 6) {
            return NO;
        }
    } else if (index == 3 || index == 4) {
        
        if (range.location == 16) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    NSInteger index = textField.tag - TextFieldTagBase;
    switch (index) {
        case 0://11位手机号
            break;
        case 1://验证码
            if (self.phoneValide == NO) {
                [self showInvalideAnimationViewWithTips:@"您还没有输入手机号码"];
                return NO;
            }
            break;
        case 2://邮箱
            
            break;
        case 3://密码
            break;
        case 4://确认密码
            break;
        default:
            break;
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {

    NSInteger index = textField.tag - TextFieldTagBase;
    switch (index) {
        case 0://11位手机号
            if (![GlobalMethod validateMobile:textField.text] && textField.text.length > 0) {
                self.phoneValide = NO;
                [self showInvalideAnimationViewWithTips:@"您输入的手机号码有误"];
            } else {
                self.phoneValide = YES;
            }
            break;
        case 1://验证码
        {
            UIImageView * rightIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
            
            textField.rightView = rightIcon;
            textField.rightViewMode = UITextFieldViewModeUnlessEditing;
            if (textField.text.length == 6 && [textField.text isEqualToString:@"123456"]) {
                rightIcon.image = ImageWithName(@"icon-verify-right.png");
                self.verifyValide = YES;
            } else {
                self.verifyValide = NO;
                [self showInvalideAnimationViewWithTips:@"验证码错误"];
                rightIcon.image = ImageWithName(@"icon-verify-wrong.png");
            }
        }
            break;
        case 2://邮箱
        {
            if (![GlobalMethod validateEmail:textField.text] && textField.text.length > 0) {
                [self showInvalideAnimationViewWithTips:@"您输入的邮箱有误"];
                textField.text = @"";
                self.emailValide = NO;
            } else {
                self.emailValide = YES;
            }

        }
            break;
        case 3://密码
        {
            if (textField.text.length < 6) {
                [self showInvalideAnimationViewWithTips:@"密码至少为6位"];
            } else {
                self.password = textField.text;
            }
        }
            break;
        case 4://确认密码
        {
            if (![textField.text isEqualToString:self.password]) {
                textField.text = @"";
                self.passwordValide = NO;
                [self showInvalideAnimationViewWithTips:@"两次输入的密码不一致，请重新输入"];
            } else {
                self.passwordValide = YES;
            }
        }
            break;
        default:
            break;
    }
    return YES;
}
//输入不合法时弹出提示框
- (void)showInvalideAnimationViewWithTips:(NSString *)tips {
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"错误提示" message:tips delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    [alert show];
}

@end
