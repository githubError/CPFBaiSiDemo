//
//  CPFTopicCell.m
//  百思不得姐
//
//  Created by cuipengfei on 16/7/11.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFTopicCell.h"
#import "CPFTopicVoiceView.h"
#import "CPFTopicVideoView.h"

@interface CPFTopicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *creatTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIImageView *jie_VImageView;
@property (weak, nonatomic) IBOutlet UILabel *text_label;

// 最热评论
@property (weak, nonatomic) IBOutlet UIView *topcmtView;
@property (weak, nonatomic) IBOutlet UILabel *topcmtContentLabel;

@property (nonatomic, weak) CPFTopicPictureView *pictureView;   // cell中间图片内容
@property (nonatomic, weak) CPFTopicVoiceView *voiceView;   // cell中间的音频内容
@property (nonatomic, weak) CPFTopicVideoView *videoView;   // cell中间的音频内容

@end

@implementation CPFTopicCell

+ (instancetype)topicCell {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:0] firstObject];
}

- (CPFTopicPictureView *)pictureView {
    if (!_pictureView) {
        CPFTopicPictureView *pictureView = [CPFTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (CPFTopicVoiceView *)voiceView {
    if (!_voiceView) {
        CPFTopicVoiceView *voiceView = [CPFTopicVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (CPFTopicVideoView *)videoView {
    if (!_videoView) {
        CPFTopicVideoView *videoView = [CPFTopicVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

- (void)awakeFromNib {
    
    UIImageView *bgimageView = [[UIImageView alloc] init];
    bgimageView.image = [UIImage imageNamed:@"mainCellBackground"];
    
    self.backgroundView = bgimageView;
}

- (void)setTopic:(CPFTopic *)topic{
    _topic = topic;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    
    self.creatTimeLabel.text = topic.create_time;
    
    self.jie_VImageView.hidden = !topic.isJie_V;
    
    self.text_label.text = topic.text;
    
    // 根据帖子类型添加内容
    if (topic.type == CPFTopicTypePicture) {
        self.pictureView.hidden = NO;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureFrame;
    } else if (topic.type == CPFTopicTypeVoice) {
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = NO;
        
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceFrame;
    } else if (topic.type == CPFTopicTypeVideo) {
        self.pictureView.hidden = YES;
        self.videoView.hidden = NO;
        self.voiceView.hidden = YES;
        
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoFrame;
    } else {
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    }
    
    // 最热评论
    CPFComment *cmt = [topic.top_cmt firstObject];
    if (cmt) {
        self.topcmtView.hidden = NO;
        self.topcmtContentLabel.text = [NSString stringWithFormat:@"%@：%@",cmt.user.username, cmt.content];
    } else {
        self.topcmtView.hidden = YES;
    }
    
    
    [self formatWithButton:self.dingButton count:topic.ding title:@"顶"];
    [self formatWithButton:self.caiButton count:topic.cai title:@"踩"];
    [self formatWithButton:self.commentButton count:topic.comment title:@"评论"];
    [self formatWithButton:self.repostButton count:topic.repost title:@"转发"];
}

- (void)formatWithButton:(UIButton *)button count:(NSInteger)count title:(NSString *)title
{
    if (count > 10000) {
        title = [NSString stringWithFormat:@"%.1f万",count / 10000.0];
    }else if (count > 0) {
        title = [NSString stringWithFormat:@"%zd",count];
    }
    [button setTitle:title forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame {
    
    frame.origin.x = CPFTopicCellMargin;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height = self.topic.cellHeight - CPFTopicCellMargin;
    frame.origin.y += CPFTopicCellMargin;
    
    [super setFrame:frame];
}

@end
