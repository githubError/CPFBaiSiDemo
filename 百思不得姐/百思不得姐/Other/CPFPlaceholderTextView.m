//
//  CPFPlaceholderTextView.m
//  百思不得姐
//
//  Created by cuipengfei on 16/7/17.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

/*
    textView继承自scrollView
    如果需要占位文字能上下随光标控件拖动需要设置
    textView.alwaysBounceVertical = YES;
    并且用label作为placeholder，给定label的宽度，使用sizeToFit自动计算高度
 */

#import "CPFPlaceholderTextView.h"

@interface CPFPlaceholderTextView ()

@property (nonatomic, weak) UILabel *placeholderLabel;

@end

@implementation CPFPlaceholderTextView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 垂直方向上永远有弹簧效果
        self.alwaysBounceVertical = YES;
        // 设置textView字体
        self.font = [UIFont systemFontOfSize:18];
        self.placeholderColor = [UIColor lightGrayColor];
        // 监听textView文本内容改变，处理placeholder的显示
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (UILabel *)placeholderLabel
{
    if (!_placeholderLabel) {
        // 添加一个用来显示占位文字的label
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.x = 4;
        placeholderLabel.y = 7;
        [self addSubview:placeholderLabel];
        _placeholderLabel = placeholderLabel;
    }
    return _placeholderLabel;
}

    // 监听文字改变
- (void)textDidChange
{
    // 只要有文字, 就隐藏占位文字label
    self.placeholderLabel.hidden = self.hasText;
}


    // 更新占位文字的尺寸
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.placeholderLabel.width = self.width - 2 * self.placeholderLabel.x;
    [self.placeholderLabel sizeToFit];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 重写setter
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    self.placeholderLabel.textColor = placeholderColor;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    self.placeholderLabel.text = placeholder;
    
    [self setNeedsLayout];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self textDidChange];
}


/*
- (void)drawRect:(CGRect)rect {
    
    // hasText 包括text和attributeText
    if (self.hasText) return;
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = self.placeholderColor;
    attrs[NSFontAttributeName] = self.font;
    
    CGFloat textX = 5;
    CGFloat textY = 8;
    CGFloat textW = self.width - 2 * textX;
    CGFloat textH = self.height;
    [self.placeholder drawInRect:CGRectMake(textX, textY, textW, textH) withAttributes:attrs];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 重写setter

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}
 */

@end
