//
//  CPFTopicViewController.m
//  百思不得姐
//
//  Created by cuipengfei on 16/7/11.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFTopicViewController.h"

@interface CPFTopicViewController ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, strong) NSMutableArray *topics;

@property (nonatomic, assign) NSInteger currentPage;   // 当前页

@property (nonatomic, copy) NSString *maxtime;  // 加载下一页参数

@property (nonatomic, assign) NSInteger lastSelectedIndex;   // 上次点击的索引

@end

@implementation CPFTopicViewController

static NSString *cellId = @"topicCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CPFTopicCell class]) bundle:nil] forCellReuseIdentifier:cellId];
}


- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (NSMutableArray *)topics {
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (void)setupTableView {
    
    // 设置contentView的内边距
    CGFloat top = CPFTitleViewH + CPFTitleViewY - [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat bottom = self.tabBarController.tabBar.height;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarItemClick) name:CPFTabBarItemDidSelectedNotification object:nil];
}

- (void)tabBarItemClick {
    
    // 连续2次点击重新刷新
    if (self.lastSelectedIndex == self.tabBarController.selectedIndex && self.view.isShowingOnWindow) {
        
        [self.tableView.mj_header beginRefreshing];
    }
    self.lastSelectedIndex = self.tabBarController.selectedIndex;
    
}

#pragma mark - 请求参数 - 'a'
- (NSString *)a {
    return [self.parentViewController isKindOfClass:[CPFNewController class]] ? @"newlist" : @"list";
}

#pragma mark - 刷新数据
// 加载新数据
- (void)loadNewTopics {
    [self.tableView.mj_footer endRefreshing];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.topicType);
    
    // 发送请求
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [responseObject writeToFile:@"/Users/cuipengfei/Desktop/a.plist" atomically:YES];
        
        // 保存maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        self.topics = [CPFTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
        self.currentPage = 0;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

// 加载更多数据
- (void)loadMoreTopics {
    [self.tableView.mj_header endRefreshing];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.topicType);
    params[@"page"] = @(++self.currentPage);
    params[@"maxtime"] = self.maxtime;
    
    // 发送请求
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 保存maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        NSArray *topic = [CPFTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.topics addObjectsFromArray:topic];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
        // 恢复页码
        self.currentPage--;
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CPFTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    CPFTopic *topic = self.topics[indexPath.row];
    
    cell.topic = topic;
    
    return cell;
}

#pragma mark - tableView代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CPFTopic *topic = self.topics[indexPath.row];
    
    return topic.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CPFCommentController *comment = [[CPFCommentController alloc] init];
    comment.topic = self.topics[indexPath.row];
    [self.navigationController pushViewController:comment animated:YES];
}
@end
