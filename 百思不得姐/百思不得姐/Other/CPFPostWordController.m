//
//  CPFPostWordController.m
//  百思不得姐
//
//  Created by cuipengfei on 16/7/17.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFPostWordController.h"
#import "CPFPlaceholderTextView.h"

@interface CPFPostWordController ()


@end

@implementation CPFPostWordController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTextView];
}

- (void)setupTextView {
    CPFPlaceholderTextView *textView = [[CPFPlaceholderTextView alloc] init];
    
    textView.frame = self.view.bounds;
    
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    
    [self.view addSubview:textView];
}

- (void)setupNav {
    self.title = @"发段子";
    self.view.backgroundColor = CPFGlobalBg;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    
    // 默认发表按钮不可点击
    self.navigationItem.rightBarButtonItem.enabled = NO;
    // navigationItem属性在appearance中设置后会在视图显示完成之前有效果，
    // 在这里设置rightBarButtonItem.enabled不会产生disable属性的效果
    // 需要将navigationBar强制刷新，立即显示效果
    [self.navigationController.navigationBar layoutIfNeeded];
    
}

- (void)post {
    
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
