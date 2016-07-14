//
//  CPFTopicVoiceView.h
//  百思不得姐
//
//  Created by cuipengfei on 16/7/14.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPFTopicVoiceView : UIView

@property (nonatomic, strong) CPFTopic *topic;   // 帖子模型

+ (instancetype)voiceView;

@end
