//
//  CPFSettingsViewController.m
//  百思不得姐
//
//  Created by cuipengfei on 16/7/19.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFSettingsViewController.h"
#import <SVProgressHUD.h>

@interface CPFSettingsViewController ()

@property (nonatomic,assign) CGFloat cachesDirectorySize;

@end

@implementation CPFSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cachesDirectorySize = [self sizeOfCachesDirectory];
}

- (CGFloat)sizeOfCachesDirectory {
    
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSFileManager *manager = [NSFileManager defaultManager];
    CGFloat size = 0;
    NSDirectoryEnumerator *fileEnumerator = [manager enumeratorAtPath:cachesPath];
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath = [cachesPath stringByAppendingPathComponent:fileName];
        
        /* 跳过子文件夹
         BOOL dir = NO;
         // 判断文件的类型：文件\文件夹
         [manager fileExistsAtPath:filePath isDirectory:&dir];
         if (dir) continue;
         */
        
        NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        size += [attrs[NSFileSize] doubleValue];
    }
    return size;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"清除缓存 (已缓存%.2fM)",self.cachesDirectorySize / 1000.0/1000];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSError *error = nil;
    [[NSFileManager defaultManager] removeItemAtPath:cachesPath error:&error];
    if (!error) {
        [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"释放内存%.2fM",self.cachesDirectorySize / 1000.0/1000]];
        self.cachesDirectorySize = 0;
        [self tableView:tableView cellForRowAtIndexPath:indexPath];
        [self.tableView reloadData];
    } else {
        [SVProgressHUD showErrorWithStatus:@"清除缓存失败"];
        [self.tableView reloadData];
    }
}

@end
