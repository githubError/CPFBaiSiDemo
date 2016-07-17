//
//  CPFSquareButton.m
//  百思不得姐
//
//  Created by cuipengfei on 16/7/16.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFSquareButton.h"
#import "CPFSquare.h"
#import <UIButton+WebCache.h>

@implementation CPFSquareButton

- (void)layoutSubviews {
    [super layoutSubviews];
    // 设置imageView位置
    self.imageView.y = self.height * 0.2;
    self.imageView.width = self.width * 0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX = self.width * 0.5;
    
    // 设置textLabel位置
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
    
    [self setup];
}

- (void)setup {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
}

- (void)setSquare:(CPFSquare *)square
{
    _square = square;
    
    [self setTitle:square.name forState:UIControlStateNormal];
    // 利用SDWebImage给按钮设置image
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
}

@end
