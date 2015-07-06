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

- (NSString *)text {
    
    return self.textView.text;
}

#pragma mark - <UITextViewDelegate>
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    [textView resignFirstResponder];
    return YES;
}

@end
