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

@implementation AddrSelectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        for (int i = 0; i < 3; i ++) {
            CGFloat height  = 20*[FlexibleFrame ratios].height;
            if (i == 2) {
                height = 40*[FlexibleFrame ratios].height;
            }
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(16*[FlexibleFrame ratios].width, Margin + (Margin + height) * i, Screen_width - 32*[FlexibleFrame ratios].width, height)];
            label.tag = Tag_Base + i;
            [self.contentView addSubview:label];
        }
    }
    return self;
}

- (void)setCellInfo:(NSDictionary *)info {

    UILabel * nameLabel = (UILabel *)[self.contentView viewWithTag:Tag_Base];
    UILabel * phoneLabel = (UILabel *)[self.contentView viewWithTag:Tag_Base + 1];
    UILabel * addrLabel = (UILabel *)[self.contentView viewWithTag:Tag_Base + 2];
    nameLabel.text = info[@"truename"];
    phoneLabel.text = info[@"phone"];
    addrLabel.text = info[@"addressname"];
    //更新位置
    CGSize size = [GlobalMethod sizeWithString:addrLabel.text font:MiddleFont maxWidth:280 *[FlexibleFrame ratios].width maxHeight:40 * [FlexibleFrame ratios].height];
    [addrLabel setFrame:CGRectMake(nameLabel.frame.origin.x, 5 + CGRectGetMaxY(phoneLabel.frame), phoneLabel.bounds.size.width, size.height)];
}
@end
