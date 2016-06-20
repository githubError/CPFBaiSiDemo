//
//  CPFEssenceController.m
//  百思不得姐
//
//  Created by cuipengfei on 16/6/13.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFEssenceController.h"

@interface CPFEssenceController ()

@end

@implementation CPFEssenceController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
