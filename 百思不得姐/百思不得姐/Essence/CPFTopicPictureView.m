//
//  CPFTopicPictureView.m
//  百思不得姐
//
//  Created by cuipengfei on 16/7/12.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFTopicPictureView.h"
#import <DALabeledCircularProgressView.h>

@interface CPFTopicPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end

@implementation CPFTopicPictureView

+ (instancetype)pictureView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (void)setTopic:(CPFTopic *)topic {
    _topic = topic;
    
    // 设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        [self.progressView setProgress:progress];
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
    
    // 隐藏gifImageView标识
    NSString *extension= topic.large_image.pathExtension;
    self.gifImageView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    
    if (topic.isBigPicture) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.seeBigButton.hidden = NO;
    }else {
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.seeBigButton.hidden = YES;
    }
}

- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;
    self.progressView.roundedCorners = 5;
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
}

@end
