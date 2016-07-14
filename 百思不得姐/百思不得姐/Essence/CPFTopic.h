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

@property (nonatomic, assign, getter=isJie_V) NSInteger *jie_v;   // 百思认证

@property (nonatomic, copy) NSString *small_image;  // 小图片
@property (nonatomic, copy) NSString *middle_image;  // 中图片
@property (nonatomic, copy) NSString *large_image;  // 大图片

@property (nonatomic, assign) CGFloat height;   // 图片高度
@property (nonatomic, assign) CGFloat width;   // 图片宽度

@property (nonatomic, assign) NSInteger type;  // 帖子类型

@property (nonatomic, assign) NSInteger voicetime;   // 音频时长
@property (nonatomic, assign) NSInteger videotime;   // 视频时长
@property (nonatomic, assign) NSInteger playcount;   // 播放次数


@property (nonatomic, assign, readonly) CGFloat cellHeight;   // cell的高度
@property (nonatomic, assign, readonly) CGRect pictureFrame;   // 图片控件位置
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;   // 大图片标识
@property (nonatomic, assign) CGFloat picDownloadProgress;   // 图片下载进度

@property (nonatomic, assign, readonly) CGRect voiceFrame;   // 音频控件的位置
@property (nonatomic, assign, readonly) CGRect videoFrame;   // 视频控件的位置

@end
