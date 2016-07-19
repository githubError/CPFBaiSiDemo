//
//  CPFAddTagsToolBar.m
//  百思不得姐
//
//  Created by cuipengfei on 16/7/18.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFAddTagsToolBar.h"
#import "CPFEditTagsController.h"

#define CPFTagMargin 5

@interface CPFAddTagsToolBar ()

@property (weak, nonatomic) IBOutlet UIView *tagsView;

@property (nonatomic, strong) NSMutableArray *tagLabels;   // 标签集合

@property (nonatomic, strong) UIButton *addTagsButton;   // 添加标签

@end

@implementation CPFAddTagsToolBar

- (NSMutableArray *)tagLabels {
    if (!_tagLabels) {
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}

+ (instancetype)addTagsToolBar {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    button.size = button.currentImage.size;
    button.x = 5;
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.tagsView addSubview:button];
    self.addTagsButton = button;
    
    [self creatTagLabels:@[@"吐槽",@"糗事"]];
}

- (void)buttonClick {
    CPFEditTagsController *editTags = [[CPFEditTagsController alloc] init];
    
    // 接收CPFEditTagsController回调的参数
    __weak typeof(self) weakSelf = self;
    [editTags setAllTagsBlock:^(NSArray *tagTitles) {
        [weakSelf creatTagLabels:tagTitles];
    }];
    
    // 将标签传给CPFEditTagsController
    editTags.tags = [self.tagLabels valueForKeyPath:@"text"];
    
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    CPFNavigationController *nav = (CPFNavigationController *)root.presentedViewController;
    
    [nav pushViewController:editTags animated:YES];
    
    /*
     *  [root presentViewController:nav animated:YES completion:nil];
     *  root model nav
     *  此时 root.presentedViewController -> nav
     *  nav.presentingViewController -> root
     */
}

- (void)creatTagLabels:(NSArray *)tagTitles {
    
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];
    
    for (int i = 0; i < tagTitles.count; i++) {
        UILabel *label = [[UILabel alloc] init];
        [self.tagLabels addObject:label];
        label.text = tagTitles[i];
        label.font = [UIFont systemFontOfSize:14];
        label.backgroundColor = CPFRGBColor(55, 135, 245);
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [label sizeToFit];
        label.width += 2 * CPFTagMargin;
        label.height = 25;
        
        label.layer.cornerRadius = 5;
        label.layer.masksToBounds = YES;
        [self.tagsView addSubview:label];
        
        // 设置label的位置
        if (i == 0) { // 第一个按钮
            label.x = 0;
            label.y = CPFTagMargin;
        } else {
            UILabel *lastTagLabel = self.tagLabels[i - 1];
            // 计算上一个按钮的左边右边剩余宽度
            CGFloat leftW = CGRectGetMaxX([lastTagLabel frame]) + CPFTagMargin;
            CGFloat rightW = self.tagsView.width - leftW - CPFTagMargin;
            
            if (rightW >= label.width) { // 剩余宽度足够显示这个标签
                label.x = leftW;
                label.y = lastTagLabel.y;
            } else {
                label.x = 0;
                label.y = CGRectGetMaxY(lastTagLabel.frame) + CPFTagMargin;
            }
        }
    }
    
    // 计算textField的位置
    UILabel *lastTagLabel = [self.tagLabels lastObject];
    // 左边占用的宽度
    CGFloat leftW = CGRectGetMaxX(lastTagLabel.frame) + CPFTagMargin;
    CGFloat rightW = self.tagsView.width - leftW;
    
    if (rightW >= self.addTagsButton.width) {
        self.addTagsButton.x = leftW;
        self.addTagsButton.y = lastTagLabel.y;
    } else {
        self.addTagsButton.x = 0;
        self.addTagsButton.y = CGRectGetMaxY(lastTagLabel.frame) + CPFTagMargin;
    }
    
    [self updateTagsViewFrame];
}

- (void)updateTagsViewFrame {
    CGFloat oldH = self.height;
    self.height = CGRectGetMaxY(self.addTagsButton.frame) + CPFTagMargin + 35;
    self.y -= self.height - oldH;
}

@end
