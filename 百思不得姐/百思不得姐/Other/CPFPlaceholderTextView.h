//
//  CPFPlaceholderTextView.h
//  百思不得姐
//
//  Created by cuipengfei on 16/7/17.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPFPlaceholderTextView : UITextView

@property (nonatomic, copy) NSString *placeholder;  // 占位文字

@property (nonatomic, strong) UIColor *placeholderColor;   // 占位文字颜色

@end
