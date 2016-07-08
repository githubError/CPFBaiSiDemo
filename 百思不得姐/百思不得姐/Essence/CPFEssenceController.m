//
//  CPFEssenceController.m
//  百思不得姐
//
//  Created by cuipengfei on 16/6/13.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFEssenceController.h"

@interface CPFEssenceController ()

@property (nonatomic, weak) UIView *indicatorView;

@property (nonatomic, weak) UIButton *selectedBtn;

@end

@implementation CPFEssenceController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigation];
    
    [self setupTitlesView];
}

// 设置标签栏
- (void)setupTitlesView {
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    titlesView.width = self.view.width;
    titlesView.height = 30;
    titlesView.y = 64;
    
    NSArray *titles = @[@"全部",@"图片",@"语音",@"视频",@"段子"];
    CGFloat width = titlesView.width / titles.count;
    CGFloat height = titlesView.height;
    
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.width = width;
        button.height = height;
        button.x = i * width;
        
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
    }
    
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.height = 2;
    indicatorView.y = titlesView.height - indicatorView.height;
    indicatorView.backgroundColor = [UIColor redColor];
    [titlesView addSubview:indicatorView];
    
    self.indicatorView = indicatorView;
    
    [self.view addSubview:titlesView];
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

@end
