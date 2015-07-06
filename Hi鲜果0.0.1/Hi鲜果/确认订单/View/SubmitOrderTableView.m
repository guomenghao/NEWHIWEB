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
static NSString * ID = @"orderCell";
static NSString * openID = @"openCell";
static NSString * switchID = @"switchCell";
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
}

@end
