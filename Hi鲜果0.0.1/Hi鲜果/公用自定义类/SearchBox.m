//
//  SearchBox.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/25.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "SearchBox.h"
#import "SearchController.h"

@implementation SearchBox

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 4;
        [self setTitle:@"搜索鲜果" forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self addTarget:self action:@selector(searchFruit:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *searcImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.bounds) - 50, 1, 20, 20)];
        searcImage.image = ImageWithName(@"search_menu.png");
        [self addSubview:searcImage];
        
        
    }
    return self;
}

/**
 *  点击Push到搜索界面
 */

- (void)searchFruit:(UIButton *)sender
{
    SearchController *searchController = [[SearchController alloc] init];
    [UIView animateWithDuration:0.7 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [[Framework controllers].homePageVC.navigationController pushViewController:searchController animated:NO];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:[Framework controllers].homePageVC.navigationController.view cache:NO];
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
