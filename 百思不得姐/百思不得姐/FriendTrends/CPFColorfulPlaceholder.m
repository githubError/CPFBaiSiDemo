//
//  CPFColorfulPlaceholder.m
//  百思不得姐
//
//  Created by cuipengfei on 16/6/21.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFColorfulPlaceholder.h"
#import <objc/runtime.h>


@implementation CPFColorfulPlaceholder


- (void)awakeFromNib {
    
    self.tintColor = self.textColor;
    
    [self resignFirstResponder];
    
}


#pragma mark - 运行时设置placeholderLabel
- (BOOL)becomeFirstResponder {
    [self setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder {
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    return [super resignFirstResponder];
}

@end
