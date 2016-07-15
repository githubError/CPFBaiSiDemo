//
//  CPFCommentController.m
//  百思不得姐
//
//  Created by cuipengfei on 16/7/14.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFCommentController.h"

@interface CPFCommentController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *hotComments;   // 热门评论
@property (nonatomic, strong) NSMutableArray *latestComments;   // 最新评论

@property (nonatomic, strong) NSArray *saved_top_cmt;   // 存放热门评论

@end

@implementation CPFCommentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setupNavgationItem];
    // 设置tableHeaderView
    [self setupTableHeaderView];
    
    [self setupRefresh];
}

- (void)setupRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadNewComments {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [responseObject writeToFile:@"/Users/cuipengfei/Desktop/comments.plist" atomically:YES];
        
        self.hotComments = [CPFComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        self.latestComments = [CPFComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)setupTableHeaderView {
    UIView *header = [[UIView alloc] init];
    
    // 清除评论cell中的热门评论
    if (self.topic.top_cmt.count) {
        self.saved_top_cmt = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
    }
    
    CPFTopicCell *topicCell = [CPFTopicCell topicCell];
    topicCell.topic = self.topic;
    topicCell.size = CGSizeMake(CPFScreenW, self.topic.cellHeight);
    [header addSubview:topicCell];
    header.height = topicCell.topic.cellHeight + CPFTopicCellMargin;
    self.tableView.tableHeaderView = header;
}

- (void)setupNavgationItem {
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.view.backgroundColor = CPFGlobalBg;
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.bottomSpace.constant = CPFScreenH - keyboardFrame.origin.y;
    
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - tableView数据源

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.hotComments.count) return 2;
    if (self.latestComments.count) return 1;
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
        return self.hotComments.count ? self.hotComments.count : self.latestComments.count;
    
    return self.latestComments.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return self.hotComments.count ? @"热门评论" : @"最新评论";
    } else {
        return @"最新评论";
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"comment"];
    }
    
    CPFComment *comment = [self commentsInIndexPath:indexPath];
    
    cell.textLabel.text = comment.content;
    return cell;
}

#pragma mark - tableView代理方法

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerTitleView = [[UIView alloc] init];
    headerTitleView.backgroundColor = CPFGlobalBg;
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    titleLabel.x = CPFTopicCellMargin;
    titleLabel.width = 200;
    titleLabel.textColor = CPFRGBColor(67, 67, 67);
    
    if (section == 0) {
        titleLabel.text = self.hotComments.count ? @"热门评论" : @"最新评论";
    } else {
        titleLabel.text = @"最新评论";
    }
    [headerTitleView addSubview:titleLabel];
    
    
    return headerTitleView;
}

#pragma mark - 其他

- (NSArray *)commentsInSection:(NSInteger)section {
    if (section == 0) {
        return self.hotComments.count ? self.hotComments : self.latestComments;
    }
    return self.latestComments;
}

- (CPFComment *)commentsInIndexPath:(NSIndexPath *)indexPath {
    return [self commentsInSection:indexPath.section][indexPath.row];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // 恢复top_cmt 重新计算cellHeight
    if (self.saved_top_cmt.count) {
        self.topic.top_cmt = self.saved_top_cmt;
        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
    }
    
}

@end
