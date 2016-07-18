//
//  CPFPostWordController.m
//  百思不得姐
//
//  Created by cuipengfei on 16/7/17.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFPostWordController.h"
#import "CPFPlaceholderTextView.h"
#import "CPFAddTagsToolBar.h"

@interface CPFPostWordController () <UITextViewDelegate>

@property (nonatomic, weak) CPFAddTagsToolBar *toolBar;

@property (nonatomic, weak) CPFPlaceholderTextView *textView;

@end

@implementation CPFPostWordController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTextView];
    
    [self setupToolBar];
}

- (void)setupToolBar {
    
    CPFAddTagsToolBar *toolBar = [CPFAddTagsToolBar addTagsToolBar];
    toolBar.width = self.view.width;
    toolBar.y = CPFScreenH - toolBar.height;
    [self.view addSubview:toolBar];
    self.toolBar = toolBar;
    
    // 监听键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        
        self.toolBar.transform = CGAffineTransformMakeTranslation(0, keyboardFrame.origin.y - CPFScreenH);
    }];
}

- (void)setupTextView {
    CPFPlaceholderTextView *textView = [[CPFPlaceholderTextView alloc] init];
    
    textView.frame = self.view.bounds;
    textView.delegate = self;
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    [self.view addSubview:textView];
    self.textView = textView;
}

- (void)setupNav {
    self.title = @"发段子";
    self.view.backgroundColor = CPFGlobalBg;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    
    // 默认发表按钮不可点击
    self.navigationItem.rightBarButtonItem.enabled = NO;
    // navigationItem属性在appearance中设置后会在视图显示完成之前有效果，
    // 在这里设置rightBarButtonItem.enabled不会产生disable属性的效果
    // 需要将navigationBar强制刷新，立即显示效果
    // 在viewDidload里面设置属性不起作用是可以尝试用layoutIfNeeded刷新
    [self.navigationController.navigationBar layoutIfNeeded];
    
}

- (void)post {
    
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.textView becomeFirstResponder];
}

#pragma mark - <UITextViewDelegate>

- (void)textViewDidChange:(UITextView *)textView {
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    // 父视图结束编辑，键盘关闭
    [self.textView endEditing:YES];
}

@end
