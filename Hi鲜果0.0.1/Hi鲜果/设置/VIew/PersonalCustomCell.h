//
//  PersonalCustomCell.h
//  Hi鲜果
//
//  Created by 李波 on 15/7/3.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalCustomCell : UITableViewCell
/**
 *  头像
 */
@property (nonatomic, strong) UIImageView *headImageView;
- (void)getHeadImageView;

/**
 *  昵称
 */
@property (nonatomic, strong) UITextField *userName;
- (void)getUserName;

/**
 *  VIP等级
 */
@property (nonatomic, strong) UIImageView *vipLevel;
- (void)getVipLevel;

/**
 *  性别
 */
@property (nonatomic, strong) UILabel *sex;
- (void)getSex;

/**
 *  生日
 */
@property (nonatomic, strong) UILabel *birthday;
- (void)getBirthday;

/**
 *  积分
 */
@property (nonatomic, strong) UILabel *score;
- (void)getScore;

@end
