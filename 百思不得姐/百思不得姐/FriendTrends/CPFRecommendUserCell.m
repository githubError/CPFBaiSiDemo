//
//  CPFRecommendUserCell.m
//  百思不得姐
//
//  Created by cuipengfei on 16/6/16.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFRecommendUserCell.h"
#import <UIImageView+WebCache.h>

@interface CPFRecommendUserCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation CPFRecommendUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUser:(CPFRecommendUser *)user {
    _user = user;
    self.screenNameLabel.text = _user.screen_name;
    
    NSString *fansCount = nil;
    if (user.fans_count < 10000) {
        fansCount = [NSString stringWithFormat:@"%zd人关注", user.fans_count];
    } else { // 大于等于10000
        fansCount = [NSString stringWithFormat:@"%.1f万人关注", user.fans_count / 10000.0];
    }
    
    self.fansCountLabel.text = fansCount;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:_user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

@end
