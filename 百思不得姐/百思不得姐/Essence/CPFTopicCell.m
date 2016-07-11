//
//  CPFTopicCell.m
//  百思不得姐
//
//  Created by cuipengfei on 16/7/11.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFTopicCell.h"

@implementation CPFTopicCell

- (void)awakeFromNib {
    
    UIImageView *bgimageView = [[UIImageView alloc] init];
    bgimageView.image = [UIImage imageNamed:@"mainCellBackground"];
    
    self.backgroundView = bgimageView;
}

- (void)setTopic:(CPFTopic *)topic{
    _topic = topic;
    
}

- (void)setFrame:(CGRect)frame {
    
    frame.origin.x = 10;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 5;
    frame.origin.y += 5;
    
    [super setFrame:frame];
}

@end
