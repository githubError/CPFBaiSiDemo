//
//  CPFContent.h
//  百思不得姐
//
//  Created by cuipengfei on 16/7/14.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CPFUser;

@interface CPFComment : NSObject

@property (nonatomic, copy) NSString *content;  // 评论内容

@property (nonatomic, copy) NSString *voicetime;  // 语音评论时长

@property (nonatomic, copy) NSString *like_count;  // 评论点赞数

@property (nonatomic, copy) NSString *ctime;  // 评论时间

@property (nonatomic, strong) CPFUser *user;   // 用户

@end
