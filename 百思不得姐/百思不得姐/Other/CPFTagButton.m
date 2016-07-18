//
//  CPFTagButton.m
//  百思不得姐
//
//  Created by cuipengfei on 16/7/18.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFTagButton.h"

#define CPFTagMargin 5

@implementation CPFTagButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.backgroundColor = CPFRGBColor(55, 135, 245);
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    
    [self sizeToFit];
    
    self.width += 5 * CPFTagMargin;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.x = 2 * CPFTagMargin;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + CPFTagMargin;
}

@end
