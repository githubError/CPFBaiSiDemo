//
//  CPFPublishViewController.m
//  百思不得姐
//
//  Created by cuipengfei on 16/7/13.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFPublishViewController.h"
#import "CPFReverseButton.h"

@interface CPFPublishViewController ()

@end

@implementation CPFPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    sloganView.y = CPFScreenH * 0.15;
    sloganView.centerX = CPFScreenW * 0.5;
    [self.view addSubview:sloganView];
    
    // 按钮数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (CPFScreenH - 2 * buttonH ) / 2;
    CGFloat buttonStartX = 25;
    CGFloat colMargin = (CPFScreenW - (maxCols - 1) * buttonW ) / (maxCols - 1);
    
    for (int i = 0; i < titles.count; i++) {
        CPFReverseButton *button = [[CPFReverseButton alloc] init];
        
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        button.width = buttonW;
        button.height = buttonH;
        
        int row = i / maxCols;
        int col = i % maxCols;
        button.x = buttonStartX + col * colMargin;
        button.y = buttonStartY + row * buttonH;;
        [self.view addSubview:button];
    }
    
}
- (IBAction)cancel {
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
