//
//  MyGardenView.m
//  Hi鲜果
//
//  Created by rimi on 15/6/25.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "MyGardenView.h"
#import "AppDelegate.h"
#import "MyGardenCell.h"
#import "SettingController.h"


@interface MyGardenView () <UITableViewDelegate, UITableViewDataSource>
/**记录自身视图动画状态，是否是打开*/
@property (assign, nonatomic) BOOL open;
/**菜单栏*/
@property (strong, nonatomic) UITableView * tableView;
/**数据源*/
@property (strong, nonatomic) NSDictionary * dataSource;
/**头像视图*/
@property (strong, nonatomic) UIImageView * logoImageView;
/**登录按钮*/
@property (strong, nonatomic) UIButton * loginButton;
/**设置按钮*/
@property (strong, nonatomic) UIButton * settingButton;
/**退出登录按钮*/
@property (strong, nonatomic) UIButton * logoutButton;
/**昵称label*/
@property (strong, nonatomic) UILabel * nickNameLabel;
/**积分label*/
@property (strong, nonatomic) UILabel * scoreLabel;
/**顶部视图，用于"盛放"顶部控件的容器*/
@property (strong, nonatomic) UIView * headerView;
/**背景图片，被添加到window最底层，不进行动画*/
@property (strong, nonatomic) UIImageView * bkImageView;
/**初始化数据源*/
- (void)initializeDataSource;
/**初始化界面*/
- (void)initializeUserInterface;
/**登录按钮点击事件*/
- (void)loginButtonPressed:(UIButton *)sender;
/**设置按钮点击事件*/
- (void)settingButtonPressed:(UIButton *)sender;
/**退出登录按钮点击事件*/
- (void)logoutButtonPressed:(UIButton *)sender;
/**推送登录控制器*/
- (void)pushLoginViewController;
/**显示已登录的界面*/
- (void)showLoginUserInterface;
/**显示未登录的界面*/
- (void)showlogoutUserInterface;
@end

static MyGardenView * gardenView;

@implementation MyGardenView

- (void)dealloc {
    
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initializeDataSource];
        [self initializeUserInterface];
    }
    return self;
}

- (void)initializeDataSource {
    
    self.dataSource = @{@"titles" : @[@"我的订单",
                                      @"待评价",
                                      @"我的关注",
                                      @"我的试吃"],
                        @"imageNames" : @[@"bill_normal.png",
                                          @"bill_normal.png",
                                          @"bill_normal.png",
                                          @"bill_normal.png"]};
}

- (void)initializeUserInterface {
    
    UIWindow * keyWindow = [Framework controllers].window;
    /**添加“我的果园”子视图*/
    [keyWindow addSubview:self];
    [keyWindow sendSubviewToBack:self];
    // 添加背景视图
    _bkImageView = [[UIImageView alloc] initWithFrame:self.window.bounds];
    _bkImageView.image = ImageWithName(@"bkImage.jpg");
    [keyWindow addSubview:_bkImageView];
    [keyWindow sendSubviewToBack:_bkImageView];
    
    self.backgroundColor = [UIColor clearColor];
    self.transform = CGAffineTransformMakeScale(0.8, 0.8);
    self.transform = CGAffineTransformTranslate(self.transform, - self.bounds.size.width / 4, self.bounds.size.height / 8);
    
    // 添加头视图
    self.headerView = [[UIView alloc] initWithFrame:[FlexibleFrame frameWithIPhone5Frame:CGRectMake(20, 33, 210, 177)]];
    self.headerView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.headerView];

    // 头像
    self.logoImageView = ({
        UIImageView * imageView = [[UIImageView alloc] initWithiPhone5Frame:CGRectMake(20, 48, 70, 70)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.layer.cornerRadius = imageView.bounds.size.width / 2;
        imageView;
    });
    [self.headerView addSubview:self.logoImageView];
    
    // 添加tableView
    self.tableView.scrollEnabled = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[MyGardenCell class] forCellReuseIdentifier:@"garden"];
    [self addSubview:self.tableView];
    
    // 添加设置按钮
    self.settingButton = ({
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(32 * [FlexibleFrame ratios].width, CGRectGetMaxY(self.tableView.frame) + 30 * [FlexibleFrame ratios].height, 80 * [FlexibleFrame ratios].width, 30 * [FlexibleFrame ratios].height)];
        [button setTitle:@"设置" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(settingButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button.titleLabel setFont:[UIFont systemFontOfSize:15 * [FlexibleFrame ratios].height]];
        button.backgroundColor = [UIColor whiteColor];
        button.layer.cornerRadius = button.bounds.size.width / 8;
        button;
    });
    [self addSubview:self.settingButton];
    
    // 是否已登录界面
    switch ([User loginUser].isLogin) {
        case YES:
            [self showLoginUserInterface];
            break;
        case NO:
            [self showlogoutUserInterface];
            break;
        default:
            break;
    }
}

- (void)showLoginUserInterface {
    // 显示用户头像
    self.logoImageView.image = ImageWithName(@"user_button_normal.png");
    // 添加“退出登录”按钮
    self.logoutButton = ({
        CGFloat margin = 32 * [FlexibleFrame ratios].width;
        CGFloat width = 80 * [FlexibleFrame ratios].width;
        CGFloat height = 30 * [FlexibleFrame ratios].height;
        CGFloat x = self.tableView.bounds.size.width - margin - width;
        CGFloat y = self.settingButton.frame.origin.y;
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [button setTitle:@"退出登录" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(logoutButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button.titleLabel setFont:[UIFont systemFontOfSize:15 * [FlexibleFrame ratios].height]];
        button.backgroundColor = BtnBkColor;
        button.layer.cornerRadius = button.bounds.size.width / 8;
        button;
    });
    [self addSubview:self.logoutButton];
}

- (void)showlogoutUserInterface {
    
    // 显示默认头像
    self.logoImageView.image = ImageWithName(@"logo_default.png");
    // 登录按钮
    self.loginButton = ({
        UIButton * button = [[UIButton alloc] initWithiPhone5Frame:CGRectMake(130, 68, 80, 30)];
        [button setTitle:@"登录" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(loginButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button.titleLabel setFont:[UIFont systemFontOfSize:15 * [FlexibleFrame ratios].height]];
        button.backgroundColor = BtnBkColor;
        button.layer.cornerRadius = button.bounds.size.width / 8;
        button;
    });
    [self.headerView addSubview:self.loginButton];
}

#pragma mark - <UITableViewDelegate/UITabelViewDataSource>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60 * [FlexibleFrame ratios].height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"garden";
    MyGardenCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MyGardenCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    MyGardenCell * currentCell = (MyGardenCell *)cell;
    currentCell.backgroundColor = [UIColor clearColor];
    currentCell.info = @{@"title" : self.dataSource[@"titles"][indexPath.row],
                         @"imageName" : self.dataSource[@"imageNames"][indexPath.row]};
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([User loginUser].isLogin == NO) {//直接推送至登录页面
#warning 具体推送的控制器可能不同
        [self pushLoginViewController];
    } else {
        
        switch (indexPath.row) {
            case 0://我的订单
                NSLog(@"我的订单");
                break;
            case 1://待评价
                NSLog(@"待评价");
                break;
            case 2://我的关注
                NSLog(@"我的关注");
                break;
            case 3://我的试吃
                NSLog(@"我的试吃");
                break;
            default:
                break;
        }
    }
}

#pragma mark - 动画相关
- (void)openGardenAnimation {
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.4 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        
        self.transform = CGAffineTransformIdentity;
        self.center = CGPointMake(Screen_width * 0.5, Screen_height * 0.5);
        [UIApplication sharedApplication].keyWindow.rootViewController.view.center = CGPointMake(Screen_width * (0.75 + 0.4), 0.5 * Screen_height);
        [UIApplication sharedApplication].keyWindow.rootViewController.view.transform = CGAffineTransformMakeScale(0.8, 0.8);
    } completion:^(BOOL finished) {
        // 动画完成
        self.open = YES;
        // 为根控制器的view添加tap手势
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapRootView:)];
        [[UIApplication sharedApplication].keyWindow.rootViewController.view addGestureRecognizer:tap];
    }];
}

- (void)closeGardenAnimation {

    /**
     *  让主页可交互
     */
    [[Framework controllers].homePageVC.navigationController setNavigationBarHidden:NO];
    [Framework controllers].homePageVC.view.userInteractionEnabled = YES;
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.6 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        [UIApplication sharedApplication].keyWindow.rootViewController.view.center = CGPointMake(Screen_width * 0.5, Screen_height * 0.5);
        [UIApplication sharedApplication].keyWindow.rootViewController.view.transform = CGAffineTransformIdentity;
        self.transform = CGAffineTransformMakeScale(0.8, 0.8);
        self.transform = CGAffineTransformTranslate(self.transform, - self.bounds.size.width / 4, self.bounds.size.height / 8);
    } completion:^(BOOL finished) {
        // 动画完成
        UIView * mainView = [UIApplication sharedApplication].keyWindow.rootViewController.view;
        //移除mainVC的tap手势
        for (UITapGestureRecognizer * tap in mainView.gestureRecognizers) {
            [mainView removeGestureRecognizer:tap];
        }
        [self.bkImageView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

#pragma mark - getter
- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame) + 20, 0.75 * self.bounds.size.width, 60 * [FlexibleFrame ratios].height * 4) style:UITableViewStylePlain];
    }
    return _tableView;
}

#pragma mark - 其他
- (void)pushLoginViewController {
    
    // 由主页控制器推送登录界面
    LoginController * loginVC = [[LoginController alloc] init];
    [[Framework controllers].homePageVC.navigationController pushViewController:loginVC animated:NO];
    [self closeGardenAnimation];
}

- (void)loginButtonPressed:(UIButton *)sender {
    
    [self pushLoginViewController];
}


/**
 *  推送到设置页面
 */
- (void)settingButtonPressed:(UIButton *)sender {
    
    SettingController * settingVC = [[SettingController alloc] init];
    // 由主页控制器推送
    [[Framework controllers].homePageVC.navigationController pushViewController:settingVC animated:NO];
    [self closeGardenAnimation];
}

- (void)logoutButtonPressed:(UIButton *)sender {
    
    NSLog(@"提示用户是否退出登录");
}

- (void)handleTapRootView:(UITapGestureRecognizer *)sender {
    
    [self closeGardenAnimation];
}
@end
