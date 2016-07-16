//
//  UIImage+CPFImageExt.m
//  百思不得姐
//
//  Created by cuipengfei on 16/7/16.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "UIImage+CPFImageExt.h"

@implementation UIImage (CPFImageExt)

- (UIImage *)circleImage {
    
    // 开启图形上下文 （BOOL opaque -> 不透明度）
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    // 获得当前上下文
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    // 为当前上下文添加圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctr, rect);
    
    // 裁剪
    CGContextClip(ctr);
    
    // 将图片画到rect
    [self drawInRect:rect];
    
    // 从当前图形上下文获得图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}

@end
