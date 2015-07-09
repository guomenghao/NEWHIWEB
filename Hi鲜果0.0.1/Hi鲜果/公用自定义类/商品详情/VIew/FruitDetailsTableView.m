//
//  FruitDetailsTableView.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/26.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "FruitDetailsTableView.h"
#import "FruitDetailsCustomCell.h"
#import <WebKit/WebKit.h>

@interface FruitDetailsTableView () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation FruitDetailsTableView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, Screen_width, Screen_height);
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource = self;
//        self.scrollEnabled = NO;
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, Screen_height, Screen_width, Screen_height)];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(20, Screen_height - 100, 40, 40);
        button.layer.cornerRadius = 20;
        button.backgroundColor = [UIColor orangeColor];
        [button setImage:ImageWithName(@"top.png") forState:UIControlStateNormal];
        [button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        [self.webView addSubview:button];
        [[Framework controllers].fruitDetailVC.view addSubview:self.webView];
    }
    return self;
}

/**
 *  cell行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

/**
 *  cell行高
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return Screen_height * 0.4;
    }
    if (indexPath.row == 1) {
        return Screen_height * 0.15;
    }
    if (indexPath.row == 2) {
        return Screen_height / 20;
    }
    if (indexPath.row == 3) {
        return Screen_height / 10;
    }
    if (indexPath.row == 4) {
        return Screen_height / 5;
    }
    return 100;
}

/**
 *  cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FruitDetailsCustomCell *cell = [[FruitDetailsCustomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    [GlobalMethod removeAllSubViews:cell.contentView];
    
    if (indexPath.row == 0) {
        if (self.dataSourceDic != nil) {
            [cell getScrollViewCellData:self.dataSourceDic];
        }
    }
    if (indexPath.row == 1) {
        if (self.dataSourceDic != nil) {
            [cell getFruitInfoCellData:self.dataSourceDic];
        }
    }
    if (indexPath.row == 2) {
        if (self.dataSourceDic != nil) {
            [cell getUnitCellData:self.dataSourceDic];
        }
    }
    if (indexPath.row == 3) {
        if (self.dataSourceDic != nil) {
            [cell getEvaluateCellData:self.dataSourceDic];
        }
    }
    if (indexPath.row == 4) {
        if (self.dataSourceDic != nil) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Screen_width, Screen_height / 5)];
            label.text = @"点击查看商品详情";
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont boldSystemFontOfSize:Screen_height / 35];
            [cell.contentView addSubview:label];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

/**
 *  cell点击效果
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4) {
        
        [self.webView loadHTMLString:self.dataSourceDic[@"newstext"] baseURL:nil];
        
        [UIView animateWithDuration:0.5 animations:^{
            self.center = CGPointMake(Screen_width / 2, Screen_height / -2);
            self.webView.center = CGPointMake(Screen_width / 2, Screen_height / 2);
        }];
    }
}

/**
 *  cell将要出现的动画
 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
}


- (void)back:(UIButton *)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        self.center = CGPointMake(Screen_width / 2, Screen_height / 2);
        self.webView.center = CGPointMake(Screen_width / 2, Screen_height * 1.5);
    }];
}

@end
