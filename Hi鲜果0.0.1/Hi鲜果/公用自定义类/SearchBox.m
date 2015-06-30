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
        self.backgroundColor = [UIColor colorWithRed:0.574 green:0.746 blue:1.000 alpha:1.000];
        self.layer.cornerRadius = 4;
        [self setTitle:@"搜索鲜果" forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self addTarget:self action:@selector(searchFruit:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *searcImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.bounds) - 50, 1, 20, 20)];
        searcImage.image = ImageWithName(@"search_menu.png");
        [self addSubview:searcImage];
        
        
    }
    return self;
}

/**
 *  点击推送到搜索界面
 *
 *  @param sender 搜索按钮
 */

- (void)searchFruit:(UIButton *)sender
{
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:[[SearchController alloc] init] animated:YES completion:nil];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
