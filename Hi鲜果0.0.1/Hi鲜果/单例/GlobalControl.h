//
//  GlobalControl.h
//  Hi鲜果
//
//  Created by 李波 on 15/6/26.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FruitNumberPicker.h"
#import "CarouselView.h"
#import "HomePageCustomCell.h"

@interface GlobalControl : NSObject

+ (GlobalControl *)myControl;

@property (nonatomic, weak) FruitNumberPicker *numPicker;
@property (nonatomic, weak) HomePageCustomCell *cell;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) CarouselView *carouselView;
//记录当前弹出键盘的第一响应者
@property (nonatomic, weak) UIView * firstResponder;

@end
