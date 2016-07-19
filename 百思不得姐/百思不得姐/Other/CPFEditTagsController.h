//
//  CPFEditTagsController.h
//  百思不得姐
//
//  Created by cuipengfei on 16/7/18.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPFEditTagsController : UIViewController

@property (nonatomic, copy) void (^allTagsBlock)(NSArray *);  // 所有标签

@property (nonatomic, strong) NSArray *tags;   // 接收传过来的标签

@end
