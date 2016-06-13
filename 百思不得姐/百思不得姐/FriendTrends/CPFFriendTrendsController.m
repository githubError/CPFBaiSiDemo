//
//  CPFFriendTrendsController.m
//  百思不得姐
//
//  Created by cuipengfei on 16/6/13.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFFriendTrendsController.h"

@interface CPFFriendTrendsController ()

@end

@implementation CPFFriendTrendsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航栏标题
    self.navigationItem.title = @"我的关注";
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
    
    // 设置背景色
    self.view.backgroundColor = CPFGlobalBg;
}

- (void)friendsClick
{
    CPFRecommendController *vc = [[CPFRecommendController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)testClick:(id)sender {
}
@end
