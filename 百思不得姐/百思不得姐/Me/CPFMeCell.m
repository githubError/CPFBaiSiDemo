//
//  CPFMeCell.m
//  百思不得姐
//
//  Created by cuipengfei on 16/7/16.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFMeCell.h"

@implementation CPFMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.font = [UIFont systemFontOfSize:16];
        [self.textLabel setTextColor:[UIColor lightGrayColor]];
        
        UIImageView *bgimageView = [[UIImageView alloc] init];
        bgimageView.image = [UIImage imageNamed:@"mainCellBackground"];
        self.backgroundView = bgimageView;
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    if (!self.imageView.image) return;
    
    self.imageView.width = 30;
    self.imageView.height = self.imageView.width;
    self.imageView.centerY = self.height * 0.5;
    
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + 10;
}

@end
