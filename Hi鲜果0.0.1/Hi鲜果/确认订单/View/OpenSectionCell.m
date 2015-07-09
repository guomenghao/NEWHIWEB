//
//  OpenSectionCell.m
//  Hi鲜果
//
//  Created by 吕玉梅 on 15/7/5.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "OpenSectionCell.h"

@interface OpenSectionCell () <UITextViewDelegate>
@property (strong, nonatomic) UITextView * textView;
@end


@implementation OpenSectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 初始化文本输入框
        [self.contentView addSubview:self.textView];
    }
    return self;
}

- (UITextView *)textView {
    
    if (_textView == nil) {
        _textView = ({
            UITextView * textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, Screen_width, 150)];
            textView.autocorrectionType = UITextAutocorrectionTypeNo;
            textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
            textView.font = MiddleFont;
            textView.delegate = self;
            textView;
        });
    }
    return _textView;
}

#pragma mark - <UITextViewDelegate>
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    textView.inputAccessoryView = nil;
    [textView resignFirstResponder];
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    if (_delegate && [_delegate respondsToSelector:@selector(openSectionCellLeaveMessage:)]) {
        [_delegate openSectionCellLeaveMessage:textView.text];
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    // 添加“完成”按钮
    UIButton * endButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 30*[FlexibleFrame ratios].height)];
        [button setTitle:@"完成" forState:UIControlStateNormal];
        button.titleLabel.textAlignment = NSTextAlignmentRight;
        [button addTarget:self action:@selector(endButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor colorWithRed:0 green:200/255.0 blue:25/255.0 alpha:0.8]forState:UIControlStateNormal];
        button;
    });
    textView.inputAccessoryView = endButton;
    [GlobalControl myControl].firstResponder = self;
    return YES;
}

#pragma mark - 结束编辑按钮点击
- (void)endButtonPressed:(UIButton *)sender {
    
    [self.textView resignFirstResponder];
}

@end
