//
//  CPFTopicCell.m
//  百思不得姐
//
//  Created by cuipengfei on 16/7/11.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFTopicCell.h"

@interface CPFTopicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *creatTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;

@end

@implementation CPFTopicCell

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
    
    frame.origin.x = 10;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 5;
    frame.origin.y += 5;
    
    [super setFrame:frame];
}

@end
