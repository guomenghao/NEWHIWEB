//
//  OpenHeaderView.m
//  Hi鲜果
//
//  Created by 吕玉梅 on 15/7/4.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "OpenHeaderView.h"

@interface OpenHeaderView ()
@property (strong, nonatomic) UILabel * titleLabel;
@property (strong, nonatomic) UIButton * openButton;
@property (strong, nonatomic) UIView * separateView;
@end

@implementation OpenHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.titleLabel];
        [self addSubview:self.openButton];
        [self addSubview:self.separateView];
    }
    return self;
}

#pragma mark - lazy getter
- (UIView *)separateView {
    
    if (_separateView == nil) {
        _separateView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-0.26, Screen_width, 0.25)];
        _separateView.backgroundColor = RGBAColor(0, 0, 0, 0.2);
    }
    return _separateView;
}

- (UILabel *)titleLabel {
    
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, self.bounds.size.width - 20 - 10, self.bounds.size.height)];
        _titleLabel.textColor = [UIColor lightGrayColor];
        _titleLabel.font = SmallFont;
    }
    return _titleLabel;
}

- (UIButton *)openButton {
    
    if (_openButton == nil) {
        _openButton = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width - 16 - 10 * [FlexibleFrame ratios].height, 0, 20*[FlexibleFrame ratios].height, 20*[FlexibleFrame ratios].height)];
        [_openButton setImage:ImageWithName(@"open.png") forState:UIControlStateNormal];
        _openButton.userInteractionEnabled = NO;
    }
    return _openButton;
}
#pragma mark - getter
- (NSInteger)numberOfRow {
    
    if (self.open == YES) {
        return 1;
    }
    return 0;
}

#pragma mark - setter
- (void)setTitle:(NSString *)title {
    
    _title = title;
    self.titleLabel.text = _title;
}

- (void)setOpen:(BOOL)open {
 
    _open = open;
    [self openSection];
}

#pragma mark - 按钮点击
- (void)openSection {

    [UIView animateWithDuration:0.25 animations:^{
        if (self.open == YES) {
            self.openButton.transform = CGAffineTransformMakeRotation(M_PI);
        } else {
            self.openButton.transform = CGAffineTransformIdentity;
        }
    }];
}

@end
