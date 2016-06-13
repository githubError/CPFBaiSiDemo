//
//  UIBarButtonItem+CPFEssence.h
//  百思不得姐
//
//  Created by cuipengfei on 16/6/13.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (CPFEssence)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

@end
