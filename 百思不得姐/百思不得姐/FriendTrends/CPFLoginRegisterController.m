//
//  CPFLoginRegisterController.m
//  百思不得姐
//
//  Created by cuipengfei on 16/6/20.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFLoginRegisterController.h"

@interface CPFLoginRegisterController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneField;

@end

@implementation CPFLoginRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (IBAction)close {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
