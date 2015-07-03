//
//  SubmitOrderTableView.m
//  Hi鲜果
//
//  Created by rimi on 15/7/3.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "SubmitOrderTableView.h"
#import "CartCell.h"
static NSString * identifier = @"orderCell";
@interface SubmitOrderTableView ()

@end

@implementation SubmitOrderTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self initializeUserInterface];
    }
    return self;
}

- (void)initializeUserInterface {
    
    self.backgroundColor = RGBAColor(0, 0, 0, 0.1);
    self.tableFooterView = [[UIView alloc] init];
    [self registerClass:[CartCell class] forCellReuseIdentifier:identifier];
}

@end
