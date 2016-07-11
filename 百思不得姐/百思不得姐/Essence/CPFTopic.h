//
//  CPFTopic.h
//  百思不得姐
//
//  Created by cuipengfei on 16/7/11.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPFTopic : NSObject

@property (nonatomic, copy) NSString *name;   // 昵称

@property (nonatomic, copy) NSString *profile_image;   // 头像

@property (nonatomic, copy) NSString *create_time;   // 发帖时间

@property (nonatomic, copy) NSString *text;   // 文本内容

@property (nonatomic, assign) NSInteger ding;   // 点赞人数

@property (nonatomic, assign) NSInteger cai;   // 踩的人数

@property (nonatomic, assign) NSInteger repost;   // 转发数

@property (nonatomic, assign) NSInteger comment;   // 评论数

@end
