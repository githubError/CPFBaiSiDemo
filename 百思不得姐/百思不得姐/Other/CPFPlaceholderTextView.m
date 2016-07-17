//
//  CPFPlaceholderTextView.m
//  百思不得姐
//
//  Created by cuipengfei on 16/7/17.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFPlaceholderTextView.h"

@implementation CPFPlaceholderTextView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        // 设置textView字体
        self.font = [UIFont systemFontOfSize:18];
        
        // 监听textView文本内容改变，处理placeholder的显示
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)textDidChange {
    // 文本内容改变，调用drawRect重绘
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    // hasText 包括text和attributeText
    if (self.hasText) return;
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    
    CGFloat textX = 5;
    CGFloat textY = 8;
    CGFloat textW = self.width;
    CGFloat textH = self.height;
    [self.placeholder drawInRect:CGRectMake(textX, textY, textW, textH) withAttributes:attrs];
}


@end
