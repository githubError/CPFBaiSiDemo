//
//  CPFRecommendCategoryCell.m
//  百思不得姐
//
//  Created by cuipengfei on 16/6/16.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFRecommendCategoryCell.h"

@interface CPFRecommendCategoryCell ()
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end

@implementation CPFRecommendCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = CPFRGBColor(244, 244, 244);
    
}

- (void)setCategory:(CPFRecommendCategory *)category {
    _category = category;
    
    self.textLabel.text = _category.name;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.textLabel.height = self.contentView.height - 2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.selectedIndicator.hidden = !selected;
    
    self.textLabel.textColor = selected ? CPFRGBColor(219, 21, 26):CPFRGBColor(78, 78, 78);
}

@end
