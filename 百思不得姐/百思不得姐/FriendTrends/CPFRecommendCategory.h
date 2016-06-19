//
//  CPFRecommendCategory.h
//  百思不得姐
//
//  Created by cuipengfei on 16/6/16.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPFRecommendCategory : NSObject

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *name;

// 保存用户临时缓存数据
@property (nonatomic, strong) NSMutableArray *users;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, assign) NSInteger currentPage;

@end
