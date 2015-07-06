//
//  OpenHeaderView.h
//  Hi鲜果
//
//  Created by 吕玉梅 on 15/7/4.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpenHeaderView : UIView
@property (assign, nonatomic) BOOL open;
@property (strong, nonatomic) NSString * title;
@property (assign, nonatomic, readonly) NSInteger numberOfRow;

@end
