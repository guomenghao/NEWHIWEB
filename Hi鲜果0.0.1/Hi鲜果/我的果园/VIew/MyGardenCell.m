//
//  MyGardenCell.m
//  Hi鲜果
//
//  Created by rimi on 15/6/26.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "MyGardenCell.h"

@interface MyGardenCell ()
@property (strong, nonatomic) UIImageView * icon;
@property (strong, nonatomic) UILabel * titleLabel;
- (void)updateUI;
@end

@implementation MyGardenCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
//        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        self.icon = [[UIImageView alloc] initWithiPhone5Frame:CGRectMake(32, 5, 32, 32)];
        //self.icon.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:self.icon];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + CGRectGetMaxX(self.icon.frame), 16, 100, 15)];
        self.titleLabel.textColor = [UIColor whiteColor];
        [self.titleLabel setFont:[UIFont systemFontOfSize:15 * [FlexibleFrame ratios].height]];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)setInfo:(NSDictionary *)info {
    
    _info = info;
    [self updateUI];
}

- (void)updateUI {
    
    self.icon.image = ImageWithName(_info[@"imageName"]);
    self.titleLabel.text = _info[@"title"];
}

@end
