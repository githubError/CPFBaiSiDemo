//
//  CPFTagTextField.h
//  百思不得姐
//
//  Created by cuipengfei on 16/7/18.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPFTagTextField : UITextField

@property (nonatomic, strong) void(^deleteBlock)();   // 键盘删除按钮回调

@end
