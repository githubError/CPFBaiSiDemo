//
//  CPFEditTagsController.m
//  百思不得姐
//
//  Created by cuipengfei on 16/7/18.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFEditTagsController.h"

@interface CPFEditTagsController ()<UITextFieldDelegate>

@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, weak) UIButton *addTagsButton;

@end

@implementation CPFEditTagsController

- (UIButton *)addTagsButton {
    if (!_addTagsButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.x = 10;
        button.width = self.contentView.width - 2 * button.x;
        button.height = 25;
        button.backgroundColor = CPFRGBColor(55, 135, 245);
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:17];
        // 设置button的内容（含label和imageView）水平位置
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _addTagsButton = button;
        [self.contentView addSubview:_addTagsButton];
    }
    return _addTagsButton;
}

- (void)setupContentView {
    UIView *contentView = [[UIView alloc] init];
    contentView.x = 10;
    contentView.y = 64 + 10;
    contentView.width = self.view.width - 2 * contentView.x;
    contentView.height = self.view.height - contentView.y - 10;
    contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentView];
    self.contentView = contentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupContentView];
    
    [self setupTextField];
}

- (void)setupTextField {
    UITextField *textField = [[UITextField alloc] init];
    textField.placeholder = @"请输入标签文字";
    textField.width = CPFScreenW;
    textField.height = 35;
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
        self.addTagsButton.y = CGRectGetMaxY(self.textField.frame);
        [self.addTagsButton setTitle:[NSString stringWithFormat:@"添加标签: %@",self.textField.text] forState:UIControlStateNormal];
    } else {
        self.addTagsButton.hidden = YES;
    }
}

#pragma mark - <UITextFieldDelegate>

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self textDidChange];
    return YES;
}

@end
