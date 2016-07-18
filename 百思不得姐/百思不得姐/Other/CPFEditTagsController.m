//
//  CPFEditTagsController.m
//  百思不得姐
//
//  Created by cuipengfei on 16/7/18.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFEditTagsController.h"
#import "CPFTagButton.h"
#import "CPFTagTextField.h"

#define CPFTagMargin 5

@interface CPFEditTagsController ()<UITextFieldDelegate>

@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, weak) CPFTagTextField *textField;
@property (nonatomic, weak) UIButton *addTagsButton;
@property (nonatomic, strong) NSMutableArray *tagButtons;   // 标签集合

@end

@implementation CPFEditTagsController

- (NSMutableArray *)tagButtons {
    if (!_tagButtons) {
        _tagButtons = [NSMutableArray array];
    }
    return _tagButtons;
}

// 添加标签按钮
- (UIButton *)addTagsButton {
    if (!_addTagsButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.x = CPFTagMargin;
        button.width = self.contentView.width - 2 * button.x;
        button.height = 25;
        button.backgroundColor = CPFRGBColor(55, 135, 245);
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        // 设置button的内容（含label和imageView）水平位置
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(addTagsButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _addTagsButton = button;
        [self.contentView addSubview:_addTagsButton];
    }
    return _addTagsButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupContentView];
    
    [self setupTextField];
}


- (void)addTagsButtonClick {
    CPFTagButton *tagButton = [CPFTagButton buttonWithType:UIButtonTypeCustom];
    tagButton.height = self.textField.height;
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
    [tagButton addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:tagButton];
    [self.tagButtons addObject:tagButton];
    
    // 更新界面
    [self updateTagButtonsFrame];
    
    // 清空文字
    self.textField.text = nil;
    self.addTagsButton.hidden = YES;
}

- (void)tagButtonClick:(UIButton *)tagButton {
    [self.tagButtons removeObject:tagButton];
    [tagButton removeFromSuperview];
    // 更新界面
    [UIView animateWithDuration:0.25 animations:^{
        [self updateTagButtonsFrame];
    }];
}

- (void)updateTagButtonsFrame {
    for (int i=0; i<self.tagButtons.count; i++) {
        CPFTagButton *tagButton = self.tagButtons[i];
        
        if (i == 0) { // 第一个按钮
            tagButton.x = 0;
            tagButton.y = CPFTagMargin;
        } else {
            CPFTagButton *lastTagButton = self.tagButtons[i - 1];
            // 计算上一个按钮的左边右边剩余宽度
            CGFloat leftW = CGRectGetMaxX([lastTagButton frame]) + CPFTagMargin;
            CGFloat rightW = self.contentView.width - leftW - CPFTagMargin;
            
            if (rightW >= tagButton.width) { // 剩余宽度足够显示这个标签
                tagButton.x = leftW;
                tagButton.y = lastTagButton.y;
            } else {
                tagButton.x = 0;
                tagButton.y = CGRectGetMaxY(lastTagButton.frame) + CPFTagMargin;
            }
            
        }
    }
    
    // 计算textField的位置
    CPFTagButton *lastTagButton = [self.tagButtons lastObject];
    // 左边占用的宽度
    CGFloat leftW = CGRectGetMaxX(lastTagButton.frame) + CPFTagMargin;
    CGFloat rightW = self.contentView.width - leftW;
    
    if (rightW >= [self textFieldTextWidth]) {
        self.textField.x = leftW;
        self.textField.y = lastTagButton.y;
    } else {
        self.textField.x = 0;
        self.textField.y = CGRectGetMaxY(lastTagButton.frame) + CPFTagMargin;
    }
}

// 计算textField文字宽度
- (CGFloat)textFieldTextWidth {
    CGFloat textW = [self.textField.text sizeWithAttributes:@{NSFontAttributeName : self.textField.font}].width;
    return MAX(90, textW);
}

- (void)setupContentView {
    UIView *contentView = [[UIView alloc] init];
    contentView.x = CPFTagMargin;
    contentView.y = 64 + CPFTagMargin;
    contentView.width = self.view.width - 2 * contentView.x;
    contentView.height = self.view.height - contentView.y - CPFTagMargin;
    contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentView];
    self.contentView = contentView;
}
- (void)setupTextField {
    
    __weak typeof(self) weakSelf = self;
    CPFTagTextField *textField = [[CPFTagTextField alloc] init];
    textField.placeholder = @"请输入标签文字";
    // 使用KVC设置placeholder的文字颜色
    [textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    // 使用block回调的方式监听键盘删除按钮,删除标签
    textField.deleteBlock = ^{
        if (weakSelf.textField.hasText) return ;
        [weakSelf tagButtonClick:[weakSelf.tagButtons lastObject]];
    };
    textField.width = CPFScreenW;
    textField.height = 25;
    [textField becomeFirstResponder];
    textField.delegate = self;
    [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:textField];
    self.textField = textField;
    self.textField.returnKeyType = UIReturnKeyDone;
}

- (void)setupNav {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"添加标签";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
}

- (void)done {
    
}

- (void)textDidChange {
    if (self.textField.hasText) {
        self.addTagsButton.hidden = NO;
        self.navigationItem.rightBarButtonItem.enabled = YES;
        self.addTagsButton.y = CGRectGetMaxY(self.textField.frame);
        [self.addTagsButton setTitle:[NSString stringWithFormat:@"添加标签: %@",self.textField.text] forState:UIControlStateNormal];
    } else {
        self.navigationItem.rightBarButtonItem.enabled = NO;
        self.addTagsButton.hidden = YES;
    }
}

#pragma mark - <UITextFieldDelegate>

- (BOOL)textFieldShouldReturn:(CPFTagTextField *)textField {
    [self textDidChange];
    if (textField.hasText)
        [self addTagsButtonClick];
    return YES;
}

@end
