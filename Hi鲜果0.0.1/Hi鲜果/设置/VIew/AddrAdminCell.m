//
//  AddrAdminCell.m
//  Hi鲜果
//
//  Created by 李波 on 15/7/4.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "AddrAdminCell.h"

@interface AddrAdminCell ()

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *phone;
@property (nonatomic, strong) UILabel *addr;

@end

@implementation AddrAdminCell



- (UILabel *)name
{
    if (_name == nil) {
        _name = [[UILabel alloc] initWithFrame:CGRectMake(Screen_width / 43 * 2, Screen_height / 4.5 / 2 - Screen_height / 25 / 2 - Screen_height / 25 - Screen_height / 25 / 3, Screen_width - Screen_width / 43 * 2 - Screen_width / 37.5 * 3, Screen_height / 25)];
        _name.font = [UIFont systemFontOfSize:Screen_height / 37];
        if (Screen_height != 480) {
            _name.font = [UIFont systemFontOfSize:Screen_height / 42];
        }
    }
    return _name;
}

- (UILabel *)phone
{
    if (_phone == nil) {
        _phone = [[UILabel alloc] initWithFrame:CGRectMake(Screen_width / 43 * 2, CGRectGetMaxY(self.name.frame) + Screen_height / 25 / 1.8 / 2.5, Screen_width - Screen_width / 43 * 2 - Screen_width / 37.5 * 3, Screen_height / 25)];
        _phone.font = [UIFont systemFontOfSize:Screen_height / 37];
        if (Screen_height != 480) {
            _phone.font = [UIFont systemFontOfSize:Screen_height / 42];
        }
    }
    return _phone;
}

- (UILabel *)addr
{
    if (_addr == nil) {
        _addr = [[UILabel alloc] initWithFrame:CGRectMake(Screen_width / 43 * 2, CGRectGetMaxY(self.phone.frame) + Screen_height / 25 / 1.8 / 2.5, Screen_width - Screen_width / 43 * 2 - Screen_width / 37.5 * 3, Screen_height / 25 * 1.7)];
        _addr.numberOfLines = 2;
        _addr.font = [UIFont systemFontOfSize:Screen_height / 37];
        if (Screen_height != 480) {
            _addr.font = [UIFont systemFontOfSize:Screen_height / 45];
        }
    }
    return _addr;
}


- (void)getAddrCellData:(NSDictionary *)data
{
    self.name.text = data[@"truename"];
    [self.contentView addSubview:self.name];
    self.phone.text = data[@"phone"];
    [self.contentView addSubview:self.phone];
    self.addr.text = data[@"addressname"];
    [self.contentView addSubview:self.addr];
}
@end
