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

        // 添加开关按钮
        UISwitch * switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(Screen_width - 60*[FlexibleFrame ratios].width, (self.bounds.size.height - 30*[FlexibleFrame ratios].height)/2, 60*[FlexibleFrame ratios].width, 30*[FlexibleFrame ratios].height)];
        [switchButton addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:switchButton];
    }
    return self;
}

- (void)switchValueChanged:(UISwitch *)sender {
    
    self.switchOn = sender.on;
    NSLog(@"切换开关状态：%d", self.switchOn);
}

@end
