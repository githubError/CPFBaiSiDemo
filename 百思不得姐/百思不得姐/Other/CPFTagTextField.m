//
//  CPFTagTextField.m
//  百思不得姐
//
//  Created by cuipengfei on 16/7/18.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFTagTextField.h"

@implementation CPFTagTextField


// 按下键盘的删除按钮会调用UITextField的UITextInput协议下UIKeyInput协议下的deleteBackward方法
// 可以在重写的UITextField的子类中拦截该方法监听键盘的删除键响应
- (void)deleteBackward {
    !self.deleteBlock ? : self.deleteBlock();
    [super deleteBackward];
}

@end
