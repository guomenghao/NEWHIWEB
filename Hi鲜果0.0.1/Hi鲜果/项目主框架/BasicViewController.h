//
//  BasicViewController.h
//  Hi鲜果
//
//  Created by 李波 on 15/6/25.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM (NSUInteger, UIViewControllerType) {
    UIViewControllerHaveNavigation = 0,
    UIViewControllerNotNavigation,
    UIViewControllerNavigationTransluct,
};



@interface BasicViewController : UIViewController

@property(nonatomic, assign) UIViewControllerType controllerType;
- (void)initializeDataSource;
- (void)initializeUserInterface;

@end
