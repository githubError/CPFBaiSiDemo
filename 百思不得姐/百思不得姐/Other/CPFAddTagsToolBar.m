//
//  CPFAddTagsToolBar.m
//  百思不得姐
//
//  Created by cuipengfei on 16/7/18.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFAddTagsToolBar.h"
#import "CPFEditTagsController.h"

@interface CPFAddTagsToolBar ()

@property (weak, nonatomic) IBOutlet UIView *tagsView;

@end

@implementation CPFAddTagsToolBar

+ (instancetype)addTagsToolBar {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    button.size = button.currentImage.size;
    button.x = 5;
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.tagsView addSubview:button];
}

- (void)buttonClick {
    CPFEditTagsController *editTags = [[CPFEditTagsController alloc] init];
    
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    CPFNavigationController *nav = (CPFNavigationController *)root.presentedViewController;
    
    [nav pushViewController:editTags animated:YES];
    
    /*
     *  [root presentViewController:nav animated:YES completion:nil];
     *  root model nav
     *  此时 root.presentedViewController -> nav
     *  nav.presentingViewController -> root
     */
}

@end
