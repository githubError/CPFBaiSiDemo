//
//  CPFRecommendTagCell.m
//  百思不得姐
//
//  Created by cuipengfei on 16/6/20.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFRecommendTagCell.h"
#import <UIImageView+WebCache.h>

@interface CPFRecommendTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageLiatImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;

@end

@implementation CPFRecommendTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setRecommendTag:(CPFRecommendTag *)recommendTag {
    _recommendTag = recommendTag;
    [self.imageLiatImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.themeNameLabel.text = recommendTag.theme_name;
    NSString *subNumber = nil;
    if (recommendTag.sub_number < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人订阅", recommendTag.sub_number];
    } else { // 大于等于10000
        subNumber = [NSString stringWithFormat:@"%.1f万人订阅", recommendTag.sub_number / 10000.0];
    }
    self.subNumberLabel.text = subNumber;
}

- (void)setFrame:(CGRect)frame {
    frame.size.height -= 1;
    [super setFrame:frame];
}

@end
