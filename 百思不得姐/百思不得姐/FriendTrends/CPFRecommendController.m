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

@interface CPFRecommendController () <UITableViewDataSource>

@property (nonatomic, strong) NSArray *categories;

@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

@end

@implementation CPFRecommendController

static NSString * const categaryCellId = @"categaryCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"推荐关注";
    
    // 设置背景色
    self.view.backgroundColor = CPFGlobalBg;
    
    // 注册tableViewCell
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CPFRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:categaryCellId];
    
    // 请求tableViewCategoryCell数据
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"a"] = @"category";
    dict[@"c"] = @"subscribe";
    [SVProgressHUD showWithStatus:@"正在加载"];
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.categories = [CPFRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.categoryTableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CPFRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categaryCellId forIndexPath:indexPath];
    cell.category = self.categories[indexPath.row];
    
    return cell;
}
@end
