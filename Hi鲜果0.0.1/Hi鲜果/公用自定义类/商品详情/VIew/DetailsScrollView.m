//
//  DetailsScrollView.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/26.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "DetailsScrollView.h"

@implementation DetailsScrollView


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, Screen_width, Screen_height * 0.4);
        self.bounces = NO;
        self.pagingEnabled = YES;
        self.showsVerticalScrollIndicator = FALSE;
        self.showsHorizontalScrollIndicator = FALSE;
        [self initializeUserInterface];
    }
    return self;
}

- (void)initializeUserInterface
{
    
    for (int i = 0; i < 3; i++) {
        CGFloat x = i * CGRectGetWidth(self.bounds);
        CGFloat y = 0;
        CGFloat width = CGRectGetWidth(self.bounds);
        CGFloat heigth = CGRectGetHeight(self.bounds);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, heigth)];
        NSString *imageName = [NSString stringWithFormat:@"%d.jpg", i + 1];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:imageName]];
        [self addSubview:imageView];
    }
    
    self.contentSize = CGSizeMake(CGRectGetWidth(self.bounds) * 3, CGRectGetHeight(self.bounds));
    
}

@end
