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

@interface CPFRecommendController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) NSArray *users;

@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *usersTableView;

@end

@implementation CPFRecommendController

static NSString * const categaryCellId = @"categaryCell";
static NSString * const userCellId = @"userCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    // 请求tableViewCategoryCell数据
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"a"] = @"category";
    dict[@"c"] = @"subscribe";
    [SVProgressHUD showWithStatus:@"正在加载"];
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.categories = [CPFRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.categoryTableView reloadData];
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.categoryTableView) {
        return self.categories.count;
    }else {
        
        CPFRecommendCategory *category = self.categories[[self.categoryTableView indexPathForSelectedRow].row];
        
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
        
        CPFRecommendCategory *category = self.categories[[self.categoryTableView indexPathForSelectedRow].row];
        cell.user = category.users[indexPath.row];
        return cell;
    }
}

#pragma mark - <UITableViewDelagate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CPFRecommendCategory *category = self.categories[indexPath.row];
    
    if (tableView == self.categoryTableView) {
        
        if (category.users.count) {
            [self.usersTableView reloadData];
        }else {
            CPFRecommendCategory *category = self.categories[indexPath.row];
        
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[@"a"] = @"list";
            dict[@"c"] = @"subscribe";
            dict[@"category_id"] = @(category.id);
            [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSArray *users = [CPFRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
                // 缓存数据
                [category.users addObjectsFromArray:users];
                
                [self.usersTableView reloadData];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
        }
    }
    
}
@end
