//
//  CPFLoginRegisterController.m
//  百思不得姐
//
//  Created by cuipengfei on 16/6/20.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFLoginRegisterController.h"

@interface CPFLoginRegisterController ()
{
    BOOL _isClick;
}
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeading;

@end

@implementation CPFLoginRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)loginOrRegieste:(UIButton *)sender {
    
    if (!_isClick) {
        [sender setTitle:@"已有账号?" forState:UIControlStateNormal];
        self.loginViewLeading.constant = - self.view.frame.size.width;
        _isClick = YES;
    }else {
        [sender setTitle:@"注册账号" forState:UIControlStateNormal];
        self.loginViewLeading.constant = 0;
        _isClick = NO;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (IBAction)close {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
