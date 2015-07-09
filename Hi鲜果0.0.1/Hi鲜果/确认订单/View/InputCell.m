//
//  InputCell.m
//  Hi鲜果
//
//  Created by rimi on 15/7/8.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "InputCell.h"
#define Tag_Base 5000
#define NUMBERS @"0123456789"
@interface InputCell ()
@property (strong, nonatomic) UILabel * leftLabel;
@property (strong, nonatomic) UILabel * rightLabel;
@property (strong, nonatomic) UITextField * textField;
@property (strong, nonatomic) NSString * discountString;
@property (strong, nonatomic) NSString * invoiceString;

@end

@implementation InputCell 

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.accessoryType = UITableViewCellAccessoryNone;
        [self.contentView addSubview:self.leftLabel];
        [self.contentView addSubview:self.rightLabel];
        [self.contentView addSubview:self.textField];
    }
    return self;
}

- (UILabel *)leftLabel {
    if (_leftLabel == nil) {
        // 文字说明
        _leftLabel = ({
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(Screen_width/2, 0, 30*[FlexibleFrame ratios].width, 20*[FlexibleFrame ratios].height)];
            label.center = CGPointMake(label.center.x, 20*[FlexibleFrame ratios].height);
            label.textAlignment = NSTextAlignmentLeft;
            label.font = SmallFont;
            label.text = @"使用";
            label.tag = Tag_Base;
            label;
        });
    }
    return _leftLabel;
}

- (UILabel *)rightLabel {
    if (_rightLabel == nil) {
       _rightLabel = ({
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(Screen_width-36*[FlexibleFrame ratios].width, self.leftLabel.frame.origin.y, 30*[FlexibleFrame ratios].width, 20*[FlexibleFrame ratios].height)];
            label.textAlignment = NSTextAlignmentRight;
            label.font = SmallFont;
            label.tag = Tag_Base + 1;
            label.text = @"积分";
            label;
        });
    }
    return _rightLabel;
}

- (UITextField *)textField {
    if (_textField == nil) {
        // 添加输入框
        _textField = ({
            UITextField * textField =[[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftLabel.frame), self.leftLabel.frame.origin.y, CGRectGetMinX(self.rightLabel.frame) - CGRectGetMaxX(self.leftLabel.frame), 20*[FlexibleFrame ratios].height)];
            textField.center = CGPointMake(textField.center.x, self.leftLabel.center.y);
            textField.font = SmallFont;
            textField.delegate = self;
            textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
            textField.autocorrectionType = UITextAutocorrectionTypeNo;
            textField.borderStyle = UITextBorderStyleRoundedRect;
            textField.textColor = [UIColor orangeColor];
            textField.tag = Tag_Base + 2;
            textField.returnKeyType = UIReturnKeyDone;
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            textField;
        });
    }
    return _textField;
}

- (void)setType:(InputCellType)type {
    
    _type = type;
    
    if (_type == InputCellTypeInvoice) {
        [self.leftLabel removeFromSuperview];
        [self.rightLabel removeFromSuperview];
        [self.textField setFrame:CGRectMake(Screen_width / 2, 10 * [FlexibleFrame ratios].height, Screen_width / 2 - 16 * [FlexibleFrame ratios].width, self.textField.bounds.size.height)];
        self.textField.keyboardType = UIKeyboardTypeDefault;
        self.textField.placeholder = @"请输入发票抬头";
        self.textField.text = self.invoiceString;
    } else {
        [self.contentView addSubview:self.leftLabel];
        [self.contentView addSubview:self.rightLabel];
        [self.textField setFrame:CGRectMake(CGRectGetMaxX(self.leftLabel.frame), self.leftLabel.frame.origin.y, CGRectGetMinX(self.rightLabel.frame) - CGRectGetMaxX(self.leftLabel.frame), 20*[FlexibleFrame ratios].height)];
        self.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        self.textField.placeholder = @"100的整数倍";
        self.textField.text = self.discountString;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (self.type == InputCellTypeScore && [self isNumber:string]) {
        NSString * allString = [textField.text stringByAppendingString:string];
        if ([allString intValue] > [[User loginUser].score intValue]) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"抵扣积分不能超过现有积分" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
            [alert show];
            return NO;
        }
        return YES;
    } else if (self.type == InputCellTypeInvoice){
        // 限制发票抬头的长度为20
        if (textField.text.length < 20) {
            return YES;
        } else {
            return NO;
        }
    }
    return NO;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    [GlobalControl myControl].firstResponder = self;
    if (self.type == InputCellTypeScore) {
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        if (![defaults objectForKey:@"isShowScoreRule"]) {
            NSString * msg = [NSString stringWithFormat:@"单次抵扣金额不能超过订单总额的50%@,100积分可抵扣1元，抵扣积分必须是100的整数倍", @"%"];
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"积分规则" message:msg delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
            [alertView show];
            [defaults setObject:@(YES) forKey:@"isShowScoreRule"];
        }
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (self.type == InputCellTypeScore) {
        // 修正抵扣积分
        if (textField.text.length > 2) {
            NSRange range = NSMakeRange(textField.text.length - 2, 2);
            NSString * text = [textField.text stringByReplacingCharactersInRange:range withString:@"00"];
            textField.text = text;
            // 判断是否超过订单总额的50%
            // 如果超过，则显示最高抵扣积分
            if ([textField.text intValue] / 100.0 >= [Framework controllers].submitOrderVC.orderTotalPrice * 0.5) {
                int value = [Framework controllers].submitOrderVC.orderTotalPrice * 0.5;
                textField.text = [NSString stringWithFormat:@"%d00", value];
                NSString * msg = [NSString stringWithFormat:@"积分抵扣不能超过订单金额的一半,本次最多使用积分：%@分", textField.text];
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
                [alertView show];
            }
            self.discountString = textField.text;//记录积分值，避免textfield被重用的内容出错
            // 减少总价
            if (_delegate && [_delegate respondsToSelector:@selector(inputCellType:content:)]) {
                [_delegate inputCellType:self.type content:[NSString stringWithFormat:@"%d", [textField.text intValue] / 100]];
            }
        }
        if (textField.text.length < 3 || [textField.text intValue] == 0) {
            textField.text = @"0";
        }
    } else {
        self.invoiceString = textField.text;
        if (_delegate && [_delegate respondsToSelector:@selector(inputCellType:content:)]) {
            [_delegate inputCellType:self.type content:textField.text];
        }
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    return YES;
}

- (BOOL)isNumber:(NSString *)string {
    
    //只能输入数字
    NSCharacterSet * cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString * filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if(!basicTest) {
        return NO;
    }
    return YES;
}

@end
