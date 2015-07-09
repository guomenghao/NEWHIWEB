//
//  AddrSelectCell.m
//  Hi鲜果
//
//  Created by rimi on 15/7/7.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "AddrSelectCell.h"
#define Tag_Base 2000
#define Margin 5

@interface AddrSelectCell ()
@property (strong, nonatomic) UILabel * defaultLabel;
@end

@implementation AddrSelectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        for (int i = 0; i < 3; i ++) {
            CGFloat height  = 20*[FlexibleFrame ratios].height;
            if (i == 2) {
                height = 40*[FlexibleFrame ratios].height;
            }
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(16*[FlexibleFrame ratios].width, Margin + (Margin + height) * i, Screen_width - 42*[FlexibleFrame ratios].width, height)];
            label.tag = Tag_Base + i;
            label.textColor = RGBAColor(0, 0, 0, 0.8);
            label.font = MiddleFont;
            label.numberOfLines = 0;
            [self.contentView addSubview:label];
        }
    }
    return self;
}

- (void)setCellInfo:(NSDictionary *)info {

    UILabel * nameLabel = (UILabel *)[self.contentView viewWithTag:Tag_Base];
    UILabel * phoneLabel = (UILabel *)[self.contentView viewWithTag:Tag_Base + 1];
    UILabel * addrLabel = (UILabel *)[self.contentView viewWithTag:Tag_Base + 2];
    nameLabel.text = [NSString stringWithFormat:@"姓名：%@", info[@"truename"]];
    phoneLabel.text = [NSString stringWithFormat:@"电话：%@", info[@"phone"]];
    addrLabel.text = [NSString stringWithFormat:@"收货地址：%@", info[@"addressname"]];
    //判断是否是默认地址
    if ([info[@"addressid"] isEqualToString:[[User loginUser] getDefaultAddress][@"addressid"]]) {
        [self.contentView addSubview:self.defaultLabel];
    } else {
        [self.defaultLabel removeFromSuperview];
    }
    //更新位置
    CGSize size = [GlobalMethod sizeWithString:addrLabel.text font:MiddleFont maxWidth:250 *[FlexibleFrame ratios].width maxHeight:60 * [FlexibleFrame ratios].height];
    [addrLabel setFrame:CGRectMake(nameLabel.frame.origin.x, 5 + CGRectGetMaxY(phoneLabel.frame), phoneLabel.bounds.size.width, size.height)];
    self.defaultLabel.center = CGPointMake(Screen_width - 40 - 15*[FlexibleFrame ratios].width, nameLabel.center.y);
}

- (UILabel *)defaultLabel {
    
    if (_defaultLabel == nil) {
        _defaultLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30*[FlexibleFrame ratios].width, 20*[FlexibleFrame ratios].height)];
        _defaultLabel.backgroundColor = [UIColor orangeColor];
        _defaultLabel.textAlignment = NSTextAlignmentCenter;
        _defaultLabel.textColor = [UIColor whiteColor];
        _defaultLabel.text = @"默认";
        _defaultLabel.layer.cornerRadius = 4;
        _defaultLabel.layer.masksToBounds = YES;
        _defaultLabel.font = SmallFont;
    }
    return _defaultLabel;
}
@end
