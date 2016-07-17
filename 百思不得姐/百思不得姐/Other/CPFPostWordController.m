//
//  CPFPostWordController.m
//  百思不得姐
//
//  Created by cuipengfei on 16/7/17.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFPostWordController.h"

@interface CPFPostWordController ()

@end

@implementation CPFPostWordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发段子";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    
    self.view.backgroundColor = CPFGlobalBg;
}

- (void)post {
    
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
