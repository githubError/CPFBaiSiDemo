//
//  CPFReverseButton.m
//  百思不得姐
//
//  Created by cuipengfei on 16/6/20.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFReverseButton.h"

@implementation CPFReverseButton

- (void)layoutSubviews {
    [super layoutSubviews];
    // 设置imageView位置
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    // 设置textLabel位置
    self.titleLabel.x = 0;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
    
}

@end
