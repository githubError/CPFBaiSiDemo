//
//  CPFRecommendController.m
//  百思不得姐
//
//  Created by cuipengfei on 16/6/13.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFRecommendController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import <MJRefresh.h>

#define CPFSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

@interface CPFRecommendController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) NSArray *users;

@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *usersTableView;

@property (nonatomic, strong) NSMutableDictionary *dict;

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation CPFRecommendController

static NSString * const categaryCellId = @"categaryCell";
static NSString * const userCellId = @"userCell";

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置tableView
    [self setupTableView];
    
    // 设置刷新
    [self setupRefresh];
    
    // 加载categroies
    [self loadCategories];
}


- (void)setupTableView {
    
    self.title = @"推荐关注";
    
    // 设置背景色
    self.view.backgroundColor = CPFGlobalBg;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(65, 0, 0, 0);
    self.usersTableView.contentInset = self.categoryTableView.contentInset;
    self.usersTableView.rowHeight = 60;
    
    // 注册categoryTableViewCell
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CPFRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:categaryCellId];
    
    // 注册userTableViewCell
    [self.usersTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CPFRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:userCellId];
}

// 设置刷新
- (void)setupRefresh{
    
    self.usersTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    self.usersTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.usersTableView.mj_footer.hidden = YES;
}

#pragma mark - 加载数据
// 加载categroies
- (void)loadCategories{
    // 请求tableViewCategoryCell数据
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"a"] = @"category";
    dict[@"c"] = @"subscribe";
    self.dict = dict;
    
    [SVProgressHUD showWithStatus:@"正在加载"];
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        
        self.categories = [CPFRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.categoryTableView reloadData];
        
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        [self.usersTableView.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
    
    
}

- (void)loadNewUsers {
    
    CPFRecommendCategory *category = CPFSelectedCategory;
    category.currentPage = 1;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"a"] = @"list";
    dict[@"c"] = @"subscribe";
    dict[@"category_id"] = @(category.id);
    dict[@"page"] = @(category.currentPage);
    self.dict = dict;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *users = [CPFRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 删除旧数据
        [category.users removeAllObjects];
        
        // 缓存数据
        [category.users addObjectsFromArray:users];
        
        // 判断请求是否改变
        if (self.dict != dict) return ;
        
        [self.usersTableView.mj_header endRefreshing];
        
        [self.usersTableView reloadData];
        
        category.total = [responseObject[@"total"] integerValue];
        
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)loadMoreUsers {
    
    CPFRecommendCategory *category = CPFSelectedCategory;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"a"] = @"list";
    dict[@"c"] = @"subscribe";
    dict[@"category_id"] = @(category.id);
    dict[@"page"] = @(++category.currentPage);
    self.dict = dict;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *users = [CPFRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 缓存数据
        [category.users addObjectsFromArray:users];
        
        // 判断请求是否改变
        if (self.dict != dict) return ;
        
       [self checkFooterState];
        
        [self.usersTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)checkFooterState {
    
    CPFRecommendCategory *category = CPFSelectedCategory;
    
    if (category.users.count == category.total) {
        [self.usersTableView.mj_footer endRefreshingWithNoMoreData];
    }else {
        [self.usersTableView.mj_footer endRefreshing];
    }
    
    // 设置tableView的footer的显示/隐藏
    self.usersTableView.mj_footer.hidden = (category.users.count == 0);
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.categoryTableView) {
        return self.categories.count;
    }else {
        CPFRecommendCategory *category = CPFSelectedCategory;
        
        [self checkFooterState];
        
        return category.users.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.categoryTableView) {
        CPFRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categaryCellId forIndexPath:indexPath];
        cell.category = self.categories[indexPath.row];
        
        return cell;
    }else {
        CPFRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:userCellId forIndexPath:indexPath];
        cell.user = [CPFSelectedCategory users][indexPath.row];
        return cell;
    }
}

#pragma mark - <UITableViewDelagate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 结束刷新
    [self.usersTableView.mj_header endRefreshing];
    [self.usersTableView.mj_footer endRefreshing];
    
    CPFRecommendCategory *category = self.categories[indexPath.row];
    
    if (tableView == self.categoryTableView) {
        
        if (category.users.count) {
            [self.usersTableView reloadData];
        }else {
            [self.usersTableView reloadData];
            
            [self.usersTableView.mj_header beginRefreshing];
        }
    }
}

#pragma mark - 控制器销毁
- (void)dealloc {
    
    // 停止所有网络请求
    [self.manager.operationQueue cancelAllOperations];
}
@end
