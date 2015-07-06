//
//  SarchViewCustomCell.m
//  Hi鲜果
//
//  Created by 李波 on 15/7/2.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "SearchCustomCell.h"

@interface SearchCustomCell ()

@property (nonatomic, strong) UIView *separator;
@property (nonatomic, strong) UIButton *clearButton;

@end

@implementation SearchCustomCell

- (UIButton *)clearButton
{
    if (_clearButton == nil) {
        _clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _clearButton.frame = CGRectMake(0, 0, Screen_width / 3 * 1.5, Screen_height / 10 - Screen_height / 30);
        _clearButton.center = CGPointMake(Screen_width / 2, Screen_height / 10 / 2);
        _clearButton.backgroundColor = [UIColor whiteColor];
        _clearButton.titleLabel.font = [UIFont boldSystemFontOfSize:Screen_height / 37];
        _clearButton.layer.borderWidth = Screen_height / 500;
        _clearButton.layer.borderColor = [UIColor orangeColor].CGColor;
        _clearButton.layer.cornerRadius = Screen_height / 66;
        [_clearButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_clearButton setTitle:@"清除搜索历史" forState:UIControlStateNormal];
        [_clearButton setTitle:@"移出手指取消清除" forState:UIControlStateHighlighted];
        [_clearButton addTarget:self action:@selector(clear:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearButton;
}

- (UIView *)separator
{
    if (_separator == nil) {
        _separator = [[UIView alloc] initWithFrame:CGRectMake(Screen_height / 66.7, Screen_height / 13 - 0.5, Screen_width - Screen_height / 66.7 * 2, 0.5)];
        _separator.backgroundColor = [UIColor orangeColor];
    }
    return _separator;
}

- (void)getSearchCell
{
    [self.contentView addSubview:self.separator];
}

- (void)getsearchClearCell
{
    [self.contentView addSubview:self.clearButton];
}


- (void)clear:(UIButton *)sender
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"searchHistory"];
    [[Framework controllers].searchVC.dataSource removeAllObjects];
    [[Framework controllers].searchVC.tableView reloadData];
    
}




@end
