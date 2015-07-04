//
//  CartTableView.m
//  Hi鲜果
//
//  Created by rimi on 15/6/30.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "CartTableView.h"
#import "CartCell.h"
static NSString * identifier = @"cartCell";
@interface CartTableView () <UITableViewDataSource, UITableViewDelegate>

- (void)initializeUserInterface;

@end

@implementation CartTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.goods = [[NSMutableArray alloc] init];
        [self initializeUserInterface];
    }
    return self;
}

- (void)initializeUserInterface {
    
    self.dataSource = self;
    self.backgroundColor = RGBAColor(0, 0, 0, 0.1);
    self.tableFooterView = [[UIView alloc] init];
    [self registerClass:[CartCell class] forCellReuseIdentifier:identifier];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.goods.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CartCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {

        cell = [[CartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.type = CartCellTypeCart;
    if (self.goods.count > 0) {
        cell.fruit = self.goods[indexPath.row];
    }
    return cell;
}

@end
