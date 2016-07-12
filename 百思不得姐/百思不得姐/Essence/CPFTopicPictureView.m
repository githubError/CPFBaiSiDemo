//
//  CPFTopicPictureView.m
//  百思不得姐
//
//  Created by cuipengfei on 16/7/12.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFTopicPictureView.h"

@interface CPFTopicPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;

@end

@implementation CPFTopicPictureView

+ (instancetype)pictureView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (void)setTopic:(CPFTopic *)topic {
    _topic = topic;
    
    // 设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
}

- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;
}

@end
