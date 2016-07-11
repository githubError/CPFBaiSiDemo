//
//  CPFEssenceController.m
//  百思不得姐
//
//  Created by cuipengfei on 16/6/13.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFEssenceController.h"

#import "CPFAllViewController.h"
#import "CPFPictureViewController.h"
#import "CPFVoiceViewController.h"
#import "CPFVideoViewController.h"
#import "CPFWordViewController.h"

@interface CPFEssenceController () <UIScrollViewDelegate>

@property (nonatomic, weak) UIView *indicatorView;

@property (nonatomic, weak) UIButton *selectedBtn;

@property (nonatomic, weak) UIView *titlesView;

@property (nonatomic, weak) UIScrollView *contentView;

@end

@implementation CPFEssenceController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航栏
    [self setupNavigation];
    
    // 设置子控制器
    [self setupChildVC];
    
    // 设置标签栏
    [self setupTitlesView];
    
    // 设置contentView
    [self setupContentView];
}

// 设置contentView
- (void)setupContentView {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    
    [self.view insertSubview:contentView atIndex:0];
    
    // 设置contentView内容区域
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    [self scrollViewDidEndScrollingAnimation:contentView];
}

// 设置标签栏
- (void)setupTitlesView {
    // 标签栏背景
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    titlesView.width = self.view.width;
    titlesView.height = 30;
    titlesView.y = 64;
    
    NSArray *titles = @[@"全部",@"图片",@"语音",@"视频",@"段子"];
    CGFloat width = titlesView.width / titles.count;
    CGFloat height = titlesView.height;
    
    // 标签栏按钮指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.height = 2;
    indicatorView.y = titlesView.height - indicatorView.height;
    indicatorView.backgroundColor = [UIColor redColor];
    
    self.indicatorView = indicatorView;
    
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.width = width;
        button.height = height;
        button.x = i * width;
        button.tag = i;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        // 默认选中
        if (i == 0) {
            button.enabled = NO;
            self.selectedBtn = button;
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    
    self.titlesView = titlesView;
    
    [titlesView addSubview:indicatorView];
    
    [self.view addSubview:titlesView];
}

// 设置子控制器
- (void)setupChildVC {
    
    CPFAllViewController *all = [[CPFAllViewController alloc] init];
    [self addChildViewController:all];
    
    CPFPictureViewController *picture = [[CPFPictureViewController alloc] init];
    [self addChildViewController:picture];
    
    CPFVoiceViewController *voice = [[CPFVoiceViewController alloc] init];
    [self addChildViewController:voice];
    
    CPFVideoViewController *video = [[CPFVideoViewController alloc] init];
    [self addChildViewController:video];
    
    CPFWordViewController *word = [[CPFWordViewController alloc] init];
    [self addChildViewController:word];
}

// 标签点击
- (void)titleClick:(UIButton *)button {
    self.selectedBtn.enabled = YES;
    button.enabled = NO;
    self.selectedBtn = button;
    [UIView animateWithDuration:0.15 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
    // 滚动
    CGPoint offSet = self.contentView.contentOffset;
    offSet.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offSet animated:YES];
}

// 设置导航栏
- (void)setupNavigation {
    // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    // 设置背景色
    self.view.backgroundColor = CPFGlobalBg;
}

- (void)tagClick
{
    CPFRecommendTagsController *tagsCtr = [[CPFRecommendTagsController alloc] init];
    [self.navigationController pushViewController:tagsCtr animated:YES];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    // 添加自控制器
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    
    // 设置contentView的内边距
    CGFloat top = CGRectGetMaxY(self.titlesView.frame) - 20;
    CGFloat bottom = self.tabBarController.tabBar.height;
    vc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    // 设置滚动条内边距
    vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset;
    
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
}

@end
