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
#define NUMBERS @"0123456789"
@interface RegisterController () <UITextFieldDelegate>
@property (strong, nonatomic) UITextField * phoneField;
@property (strong, nonatomic) UIButton * sendCode;
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
    self.phoneField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 220*[FlexibleFrame ratios].width, 30 * [FlexibleFrame ratios].height)];
        textField.center = CGPointMake(self.view.bounds.size.width / 2, 230*[FlexibleFrame ratios].height);
        [textField setFont:MiddleFont];
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        textField.placeholder = @"请输入11位手机号";
        textField.backgroundColor = [UIColor whiteColor];
        textField.delegate = self;
        //发送验证码按钮
        self.sendCode = ({
            UIButton * sendCode = [UIButton buttonWithType:UIButtonTypeCustom];
            sendCode.frame = CGRectMake(0, 0, 80 * [FlexibleFrame ratios].width, 30);
            sendCode.titleLabel.font = MiddleFont;
            [sendCode setTitle:@"发送验证码" forState:UIControlStateNormal];
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
    
    UIImageView * phoneIcon = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.phoneField.frame) - self.phoneField.bounds.size.height - 5, self.phoneField.frame.origin.y, self.phoneField.bounds.size.height, self.self.phoneField.bounds.size.height)];
    phoneIcon.contentMode = UIViewContentModeScaleAspectFill;
    phoneIcon.image = ImageWithName(@"icon-phone.png");
    [self.view addSubview:phoneIcon];
    
    UIImageView * emailIcon = [[UIImageView alloc] initWithFrame:CGRectMake(phoneIcon.frame.origin.x, Margin + CGRectGetMaxY(phoneIcon.frame), phoneIcon.bounds.size.width, phoneIcon.bounds.size.height)];
    emailIcon.contentMode = UIViewContentModeScaleAspectFill;
    emailIcon.image = ImageWithName(@"icon-email.png");
    [self.view addSubview:emailIcon];
    
    UITextField * emailField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(self.phoneField.frame.origin.x, emailIcon.frame.origin.y, self.phoneField.bounds.size.width, self.phoneField.bounds.size.height)];
        [textField setFont:MiddleFont];
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        textField.keyboardType = UIKeyboardTypeASCIICapable;
        textField.secureTextEntry = YES;
        textField.placeholder = @"请输入完整邮箱";
        textField.backgroundColor = [UIColor whiteColor];
        textField.delegate = self;
        [textField setReturnKeyType:UIReturnKeyDone];
        textField;
    });
    [self.view addSubview:emailField];
    
    UIButton * registerButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(self.phoneField.frame.origin.x, CGRectGetMaxY(emailField.frame) + Margin, self.phoneField.bounds.size.width, 30 * [FlexibleFrame ratios].height)];
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
/**
 *  发送验证码按钮点击事件
 *
 *  @param sender 发送验证码按钮
 */
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //string == @""时为删除键
    NSLog(@"range.loc = %ld", range.location);
    NSLog(@"text.lenght = %ld", textField.text.length);
    if (textField == self.phoneField) {
        if (range.location == 10 && textField.text.length == 10) {
            [self setSendVerificationCodeButtonWithSelected:YES];
        } else if (range.location < 11) {
            [self setSendVerificationCodeButtonWithSelected:NO];
        }
        
        if (range.location == 11){
            return NO;
        }
        NSCharacterSet * cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
        NSString * filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest) {
            return NO;
        }
        return YES;
    }
    return YES;
}

@end
