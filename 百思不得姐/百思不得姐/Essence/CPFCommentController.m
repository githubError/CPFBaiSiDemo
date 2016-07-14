//
//  CPFCommentController.m
//  百思不得姐
//
//  Created by cuipengfei on 16/7/14.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFCommentController.h"

@interface CPFCommentController () <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CPFCommentController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationItem];
    
    CPFTopicCell *topicCell = [CPFTopicCell topicCell];
    topicCell.topic = self.topic;
    topicCell.height = topicCell.topic.cellHeight;
    self.tableView.tableHeaderView = topicCell;
}

- (void)setupNavgationItem {
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.bottomSpace.constant = CPFScreenH - keyboardFrame.origin.y;
    
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
