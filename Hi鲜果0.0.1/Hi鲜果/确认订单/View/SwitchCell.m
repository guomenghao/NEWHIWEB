//
//  SwitchCell.m
//  Hi鲜果
//
//  Created by rimi on 15/7/6.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "SwitchCell.h"

@implementation SwitchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        // 添加开关按钮(51, 31)大小固定
        UISwitch * switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        switchButton.center = CGPointMake(Screen_width - 16*[FlexibleFrame ratios].width - CGRectGetWidth(switchButton.bounds)*[FlexibleFrame ratios].height*0.5, 20 *[FlexibleFrame ratios].height);
        
        switchButton.transform = CGAffineTransformMakeScale([FlexibleFrame ratios].height, [FlexibleFrame ratios].height);
        [switchButton addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:switchButton];
    }
    return self;
}

- (void)switchValueChanged:(UISwitch *)sender {
    
    self.switchOn = sender.on;
}

@end
