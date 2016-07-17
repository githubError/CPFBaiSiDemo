//
//  CPFPublishViewController.m
//  百思不得姐
//
//  Created by cuipengfei on 16/7/13.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFPublishViewController.h"
#import "CPFReverseButton.h"
#import "CPFPostWordController.h"
#import <POP.h>

@interface CPFPublishViewController ()

@end

@implementation CPFPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 动画结束前禁止子视图响应事件
    self.view.userInteractionEnabled = NO;
    
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
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * colMargin;
        CGFloat buttonEndY = buttonStartY + row * buttonH;;
        CGFloat buttonBeginY = buttonH - CPFScreenH;
        [self.view addSubview:button];
        
        // 按钮动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        anim.springBounciness = 8;
        anim.springSpeed = 5;
        anim.beginTime = CACurrentMediaTime() + i * 0.1;
        [button pop_addAnimation:anim forKey:nil];
    }
    
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    CGFloat centerX = CPFScreenW * 0.5;
    CGFloat centerEndY = CPFScreenH * 0.2;
    CGFloat centerBeginY = centerEndY - CPFScreenH;
    sloganView.frame = CGRectMake(centerX, centerBeginY, sloganView.width, sloganView.height);
    [self.view addSubview:sloganView];
    // slogan动画
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    
    
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBeginY)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    anim.springBounciness = 8;
    anim.springSpeed = 5;
    anim.beginTime = CACurrentMediaTime() + images.count * 0.1;
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        
        self.view.userInteractionEnabled = YES;
    }];
    [sloganView pop_addAnimation:anim forKey:nil];
}

- (void)buttonClick:(UIButton *)button {
    [self cancelWithCompletionBlock:^{
        if (button.tag == 2) {
            CPFPostWordController *postWord = [[CPFPostWordController alloc] init];
            CPFNavigationController *nav = [[CPFNavigationController alloc] initWithRootViewController:postWord];
            UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
            [root presentViewController:nav animated:YES completion:nil];
        }
    }];
}

// 退出动画
- (void)cancelWithCompletionBlock:(void(^)())completionBlock {
    
    for (int i = 1; i < self.view.subviews.count; i++) {
        UIView *subview = self.view.subviews[i];
        CGFloat subviewEndY = subview.centerY + CPFScreenH;
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subview.centerX, subviewEndY)];
        anim.beginTime = CACurrentMediaTime() + (i - 1) * 0.1;
        [subview pop_addAnimation:anim forKey:nil];
        
        if (i == self.view.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                self.view.userInteractionEnabled = YES;
                [self dismissViewControllerAnimated:YES completion:nil];
                !completionBlock ? : completionBlock();
            }];
        }
    }
}

- (IBAction)cancel {
    [self cancelWithCompletionBlock:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self cancel];
}

@end
