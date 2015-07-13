//
//  MyGardenView.h
//  Hi鲜果
//
//  Created by rimi on 15/6/25.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyGardenView : UIView

/**打开“我的果园”动画*/
- (void)openGardenAnimation;
/**关闭“我的果园”动画*/
- (void)closeGardenAnimation;
- (void)pushLoginViewController;
- (void)loginButtonPressed;
- (void)showlogoutUserInterface;
@end
