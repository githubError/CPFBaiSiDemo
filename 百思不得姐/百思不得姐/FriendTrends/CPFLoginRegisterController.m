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
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    self.phoneField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"手机号" attributes:attr];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (IBAction)close {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
