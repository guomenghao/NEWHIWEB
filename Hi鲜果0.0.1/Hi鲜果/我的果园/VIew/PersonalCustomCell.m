//
//  PersonalCustomCell.m
//  Hi鲜果
//
//  Created by 李波 on 15/7/3.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "PersonalCustomCell.h"

@interface PersonalCustomCell ()<UITextFieldDelegate>

@end

@implementation PersonalCustomCell

- (UIImageView *)headImageView
{
    if (_headImageView == nil) {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(Screen_width - Screen_height / 5 + 10, 10, Screen_height / 5 - 20, Screen_height / 5 - 20)];
        [User loginUser].tempHeadImage = _headImageView;
    }
    return _headImageView;
}

- (UIImageView *)vipLevel
{
    if (_vipLevel == nil) {
        _vipLevel = [[UIImageView alloc] initWithFrame:CGRectMake(Screen_width - Screen_height / 10 / 2 - 10, Screen_height / 10 / 4, Screen_height / 10 / 2, Screen_height / 10 / 2)];
    }
    return _vipLevel;
}

- (UITextField *)userName
{
    if (_userName == nil) {
        _userName = [[UITextField alloc] initWithFrame:CGRectMake(Screen_width - Screen_width * 0.7 - 10, Screen_height * 0.1 / 4, Screen_width * 0.7, Screen_height * 0.1 / 2)];
        _userName.textAlignment = NSTextAlignmentRight;
        _userName.font = [UIFont systemFontOfSize:Screen_width / 22];
        _userName.delegate = self;
        _userName.autocorrectionType = UITextAutocorrectionTypeNo;
        _userName.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _userName.textColor = [UIColor lightGrayColor];
        [User loginUser].tempName = _userName;;
    }
    return _userName;
}

- (UILabel *)sex
{
    if (_sex == nil) {
        _sex = [[UILabel alloc] initWithFrame:CGRectMake(Screen_width - Screen_width * 0.7 - 10, Screen_height * 0.1 / 4, Screen_width * 0.7, Screen_height * 0.1 / 2)];
        _sex.textAlignment = NSTextAlignmentRight;
        _sex.font = [UIFont systemFontOfSize:Screen_width / 22];
        _sex.textColor = [UIColor lightGrayColor];
        [User loginUser].tempSex = _sex;
    }
    return _sex;
}

- (UILabel *)birthday
{
    if (_birthday == nil) {
        _birthday = [[UILabel alloc] initWithFrame:CGRectMake(Screen_width - Screen_width * 0.7 - 10, Screen_height * 0.1 / 4, Screen_width * 0.7, Screen_height * 0.1 / 2)];
        _birthday.textAlignment = NSTextAlignmentRight;
        _birthday.font = [UIFont systemFontOfSize:Screen_width / 22];
        [User loginUser].tempBirthday = _birthday;
    }
    return _birthday;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location > 11 ) {
        return NO;
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if (textField.text.length > 11 ) {
        textField.text = [textField.text substringToIndex:11];
    }
}


- (void)getHeadImageView
{
    NSString *headImage = [NSString stringWithFormat:@"T%@.png", @"1"];
    self.headImageView.image = ImageWithName(headImage);
    [self.contentView addSubview:self.headImageView];
}

- (void)getUserName
{
    [self.userName removeFromSuperview];
    self.userName.placeholder = @"请输入昵称";
    [self insertSubview:self.userName atIndex:0];
    
}

- (void)getVipLevel
{
    NSString *vip = [NSString stringWithFormat:@"V%@.png", @"5"];
    self.vipLevel.image = ImageWithName(vip);
    [self.contentView addSubview:self.vipLevel];
}

- (void)getSex
{
    self.sex.text = @"帅哥";
    [self.contentView addSubview:self.sex];
}

- (void)getBirthday
{
    self.birthday.text = @"1999-12-12";
    [self.contentView addSubview:self.birthday];
}


@end
