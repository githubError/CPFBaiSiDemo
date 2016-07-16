//
//  CPFCommentController.m
//  百思不得姐
//
//  Created by cuipengfei on 16/7/14.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFCommentController.h"
#import "CPFCommentCell.h"

static NSString *commentCellID = @"commentCell";

@interface CPFCommentController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *hotComments;   // 热门评论
@property (nonatomic, strong) NSMutableArray *latestComments;   // 最新评论

@property (nonatomic, strong) NSArray *saved_top_cmt;   // 存放热门评论

@property (nonatomic, assign) NSInteger currentPage;   // 当前页码

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation CPFCommentController

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

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
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    self.tableView.mj_footer.hidden = YES;
}

- (void)loadMoreComments {
    
    // 结束之前发送请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSInteger page = self.currentPage + 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";
    params[@"page"] = @(page);
    CPFComment *cmt = [self.latestComments lastObject];
    params[@"lastcid"] = cmt.ID;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
        NSArray *hotComments = [CPFComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        NSArray *latestComments = [CPFComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self.hotComments addObjectsFromArray:hotComments];
        [self.latestComments addObjectsFromArray:latestComments];
        
        // 设置页码
        self.currentPage = page;
        
        // 设置fotter状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= total) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.tableView.mj_footer endRefreshing];
        }
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadNewComments {
    
    // 结束之前发送请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            [self.tableView.mj_header endRefreshing];
            return;
        }
        
        self.hotComments = [CPFComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        self.latestComments = [CPFComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        // 设置页码
        self.currentPage = 1;
        
        // 设置fotter状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= total) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
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
    
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CPFCommentCell class]) bundle:nil] forCellReuseIdentifier:commentCellID];
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
    
    self.tableView.mj_footer.hidden = (self.latestComments.count == 0);
    
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
    CPFCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentCellID];
    
    CPFComment *comment = [self commentsInIndexPath:indexPath];
    cell.comment = comment;
    return cell;
}

#pragma mark - tableView代理方法

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setMenuVisible:NO animated:YES];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    
    // 再次点击隐藏menu
    if (menu.isMenuVisible) {
        [menu setMenuVisible:NO animated:YES];
        return;
    }
    
    CPFCommentCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // 将cell设为第一响应者
    [cell becomeFirstResponder];
    // 添加menuitem
    UIMenuItem *ding = [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)];
    UIMenuItem *revert = [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(revert:)];
    UIMenuItem *report = [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(report:)];
    menu.menuItems = @[ding, revert, report];
    
    CGRect rect = CGRectMake(0, cell.height * 0.5, cell.width, cell.height * 0.5);
    [menu setTargetRect:rect inView:cell];
    [menu setMenuVisible:YES animated:YES];
}

#pragma mark - UIMenuController的处理

// 顶
- (void)ding:(UIMenuController *)menu {
    NSLog(@"%s",__func__);
}

// 回复
- (void)revert:(UIMenuController *)menu {
    NSLog(@"%s",__func__);
}

// 举报
- (void)report:(UIMenuController *)menu {
    NSLog(@"%s",__func__);
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
    
    // 销毁所有请求
    [self.manager invalidateSessionCancelingTasks:YES];
}

@end
