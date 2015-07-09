//
//  SubmitOrderTableView.m
//  Hi鲜果
//
//  Created by rimi on 15/7/3.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "SubmitOrderTableView.h"
#import "CartCell.h"
#import "OpenSectionCell.h"
#import "SwitchCell.h"
#import "InputCell.h"
static NSString * ID = @"orderCell";
static NSString * openID = @"openCell";
static NSString * switchID = @"switchCell";
static NSString * inputID = @"inputCell";
@implementation SubmitOrderTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self initializeUserInterface];
    }
    return self;
}

- (void)initializeUserInterface {
    
    self.backgroundColor = RGBAColor(0, 0, 0, 0.02);
    self.tableFooterView = [[UIView alloc] init];
    [self registerClass:[CartCell class] forCellReuseIdentifier:ID];
    [self registerClass:[OpenSectionCell class] forCellReuseIdentifier:openID];
    [self registerClass:[SwitchCell class] forCellReuseIdentifier:switchID];
    [self registerClass:[InputCell class] forCellReuseIdentifier:inputID];
    // 注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyBoardShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyBoardHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}

// 处理通知
- (void)handleKeyBoardShowNotification:(NSNotification *)notification {
    
    if ([[GlobalControl myControl].firstResponder isKindOfClass:[InputCell class]]) {
        //判断如果当前第一响应者是上面的cell，则将self固定在键盘的上方
        InputCell * cell = (InputCell *)[GlobalControl myControl].firstResponder;
        CGFloat height = 0;
        if (cell.type == InputCellTypeScore) {//积分cell
            if (Screen_height == 480) {//iphone4
                height = 174.0;
            } else if (Screen_height == 568) {//iphone5
                height = 126.0;
            } else if (Screen_height == 667) {//iphone6
                height = 63.0;
            } else if (Screen_height == 736) {//iphone6+
                height = 44.0;
            }
            self.contentOffset = CGPointMake(0, height);
            return;
        }
    }

    self.transform = CGAffineTransformMakeTranslation(0, -[notification.userInfo[@"UIKeyboardBoundsUserInfoKey"] CGRectValue].size.height + 48);
}

- (void)handleKeyBoardHideNotification:(NSNotification *)notification {
    if ([[GlobalControl myControl].firstResponder isKindOfClass:[InputCell class]]) {
        InputCell * cell = (InputCell *)[GlobalControl myControl].firstResponder;
        if (cell.type == InputCellTypeScore) {//积分cell
            self.contentOffset = CGPointMake(0, 0);
            return;
        }
    }
    self.transform = CGAffineTransformIdentity;
}

- (void)dealloc {
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
