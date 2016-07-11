//
//  CPFTopicViewController.h
//  百思不得姐
//
//  Created by cuipengfei on 16/7/11.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    CPFTopicTypeAll = 1,
    CPFTopicTypePicture = 10,
    CPFTopicTypeWord = 29,
    CPFTopicTypeVoice = 31,
    CPFTopicTypeVideo = 41
}CPFTopicType;

@interface CPFTopicViewController : UITableViewController

@property (nonatomic, assign) CPFTopicType topicType;  // 帖子类型

@end
