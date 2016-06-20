//
//  CPFRecommendTagsController.m
//  百思不得姐
//
//  Created by cuipengfei on 16/6/20.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFRecommendTagsController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>

@interface CPFRecommendTagsController ()

@property (nonatomic, strong) NSArray *tags;

@end

@implementation CPFRecommendTagsController

static NSString * const CPFRecommendTagCellID = @"tag";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"推荐标签";
    
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = CPFGlobalBg;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CPFRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:CPFRecommendTagCellID];
    // 请求参数
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"a"] = @"tag_recommend";
    dict[@"c"] = @"topic";
    dict[@"action"] = @"sub";
    
    [SVProgressHUD showWithStatus:@"正在加载数据"];
    // 请求数据
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.tags = [CPFRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CPFRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:CPFRecommendTagCellID forIndexPath:indexPath];
    
    cell.recommendTag = self.tags[indexPath.row];
    
    return cell;
}


@end
