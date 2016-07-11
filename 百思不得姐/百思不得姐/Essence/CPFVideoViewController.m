//
//  CPFVideoViewController.m
//  百思不得姐
//
//  Created by cuipengfei on 16/7/9.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFVideoViewController.h"

@interface CPFVideoViewController ()

@end

@implementation CPFVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
}

- (void)setupTableView {
    
    // 设置contentView的内边距
    CGFloat top = CPFTitleViewH + CPFTitleViewY - [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat bottom = self.tabBarController.tabBar.height;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@---%ld",[self class], indexPath.row];
    
    return cell;
}
@end
