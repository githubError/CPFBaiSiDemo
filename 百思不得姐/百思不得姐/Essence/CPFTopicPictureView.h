//
//  CPFTopicPictureView.h
//  百思不得姐
//
//  Created by cuipengfei on 16/7/12.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CPFTopic;

@interface CPFTopicPictureView : UIView

+ (instancetype)pictureView;

@property (nonatomic, strong) CPFTopic *topic;   // cell数据

@end
