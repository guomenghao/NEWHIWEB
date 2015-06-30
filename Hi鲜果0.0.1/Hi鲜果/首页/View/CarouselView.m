//
//  CarouselView.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/25.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "CarouselView.h"
#import "CarouselButton.h"
#import "HomePageCustomCell.h"
#import "GlobalControl.h"

@interface CarouselView () <UIScrollViewDelegate> {
    
    NSMutableArray *_imageArray;
    NSMutableArray *_contentViews;//存放滚动视图子视图
    NSInteger _currentIndex;//记录当前中间图片的下标
    NSTimer *_timer;
}

//处理下标
- (NSInteger)correctIndex:(NSInteger)currectIndex maxCount:(NSInteger)maxCount;

//刷新滚动视图
- (void)updateScrollView;

@end

@implementation CarouselView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, Screen_width, Screen_height * 0.27);
        self.bounces = NO;
        self.pagingEnabled = YES;
        self.showsVerticalScrollIndicator = FALSE;
        self.showsHorizontalScrollIndicator = FALSE;
        self.delegate = self;
        [self initializeUserInterface];
    }
    return self;
}

- (void)initializeUserInterface
{
    //设置起始下标
    _currentIndex = 0;
    
    //保存所有图片的名称
    _imageArray = [[NSMutableArray alloc] init];
    
    _contentViews = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 3; i ++) {
        NSString *imageName = [NSString stringWithFormat:@"%d.jpg", i + 1];
        [_imageArray addObject:imageName];
    }
    
    for (int i = 0; i < 3; i++) {
        CGFloat x = i * CGRectGetMaxX(self.bounds);
        CGFloat y = 0;
        CarouselButton *imageButton = [CarouselButton buttonWithType:UIButtonTypeCustom];
        imageButton.frame = CGRectMake(x, y, CGRectGetMaxX(self.bounds), CGRectGetHeight(self.bounds));
        NSString *imageName = [NSString stringWithFormat:@"%d.jpg", i + 1];
        [imageButton setBackgroundImage:ImageWithName(imageName) forState:UIControlStateNormal];
        [imageButton setBackgroundImage:ImageWithName(imageName) forState:UIControlStateHighlighted];
        imageButton.clipsToBounds = NO;
        NSInteger index = [self correctIndex: - 1 + i maxCount:_imageArray.count];
        [imageButton setBackgroundImage:ImageWithName(_imageArray[index]) forState:UIControlStateNormal];
        [imageButton setBackgroundImage:ImageWithName(_imageArray[index]) forState:UIControlStateHighlighted];
        [imageButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:imageButton];
        [_contentViews addObject:imageButton];
    }
    
    self.contentSize = CGSizeMake(CGRectGetWidth(self.bounds) * 3, CGRectGetMaxY(self.bounds));
    
    
    //设置偏移量，默认显示中间
    [self setContentOffset:CGPointMake(CGRectGetWidth(self.bounds), 0) animated:NO];
    
    
    
    
    
    /**
     *  自动轮播
     */
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(updateCarousel) userInfo:nil repeats:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateScrollView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_timer setFireDate:[NSDate distantFuture]];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    [_timer setFireDate:[NSDate date]];
}

- (NSInteger)correctIndex:(NSInteger)currectIndex maxCount:(NSInteger)maxCount {
    if (currectIndex < 0) {
        return maxCount - 1;
    }
    if (currectIndex > maxCount - 1) {
        return 0;
    }
    return currectIndex;
}

//刷新滚动视图，更改偏移量
- (void)updateScrollView {
    BOOL isNeedUpdate = NO;
    if (self.contentOffset.x <= 0) {
        _currentIndex -= 1;
        _currentIndex = [self correctIndex:_currentIndex maxCount:_imageArray.count];
        isNeedUpdate = YES;
    }
    if (self.contentOffset.x >= CGRectGetWidth(self.bounds) * 2) {
        _currentIndex += 1;
        _currentIndex = [self correctIndex:_currentIndex maxCount:_imageArray.count];
        isNeedUpdate = YES;
    }
    if (isNeedUpdate == NO) {
        return;
    } else {
        for (NSInteger i = 0; i < 3; i++) {
            CarouselButton *imageButton = _contentViews[i];
            NSString *imageName = _imageArray[[self correctIndex:_currentIndex - 1 + i maxCount:_imageArray.count]];
            [imageButton setBackgroundImage:ImageWithName(imageName) forState:UIControlStateNormal];
            [imageButton setBackgroundImage:ImageWithName(imageName) forState:UIControlStateHighlighted];
            imageButton.index = [self correctIndex:_currentIndex - 1 + i maxCount:_imageArray.count];
        }
        [GlobalControl myControl].pageControl.currentPage = _currentIndex;
        
        //更改偏移量
        [self setContentOffset:CGPointMake(CGRectGetWidth(self.bounds), 0) animated:NO];
    }
}


- (void)buttonPressed:(CarouselButton *)sender
{
    NSLog(@"%ld", (long)sender.index);
}

- (void)updateCarousel
{
    [self setContentOffset:CGPointMake(CGRectGetWidth(self.bounds) * 2, 0) animated:YES];
    [self updateScrollView];
}

@end
