//
//  OpenSectionCell.h
//  Hi鲜果
//
//  Created by 吕玉梅 on 15/7/5.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OpenSectionCellDelegate <NSObject>

- (void)openSectionCellLeaveMessage:(NSString *)content;

@end

@interface OpenSectionCell : UITableViewCell

@property (weak, nonatomic) id<OpenSectionCellDelegate> delegate;

@end
