//
//  CPFTopic.m
//  百思不得姐
//
//  Created by cuipengfei on 16/7/11.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFTopic.h"

@interface CPFTopic ()
{
    CGFloat _cellHeight;
}

@end

@implementation CPFTopic

- (NSString *)create_time {
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 帖子的创建时间
    NSDate *create = [fmt dateFromString:_create_time];
    
    if (create.isThisYear) { // 今年
        if (create.isToday) { // 今天
            NSDateComponents *cmps = [[NSDate date] intervalFromDate:create];
            
            if (cmps.hour >= 1) { // 时间差距 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > 时间差距 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > 时间差距
                return @"刚刚";
            }
        } else if (create.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:create];
        } else { // 其他
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:create];
        }
    } else { // 非今年
        return _create_time;
    }
}


- (CGFloat)cellHeight {
    
    if (!_cellHeight) {
        
        CGFloat textY = CPFTopicCellTopBarH + 3 * CPFTopicCellMargin;
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * CPFTopicCellMargin, MAXFLOAT);
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil].size.height;
        CGFloat buttomBarH = CPFTopicCellButtomBarH;
        
        _cellHeight = textY + textH + buttomBarH ;
        
        if (self.type == CPFTopicTypePicture) {
            
            // 等比例缩放图片
            CGFloat pictureW = maxSize.width;
            CGFloat pictureH = pictureW * self.height / self.width;
            // 判断是否为大图片
            if (pictureH >= CPFTopicCellPictureMaxH) {
                self.bigPicture = YES;
                pictureH = CPFTopicCellPictureOverMaxH;
            }
            
            CGFloat pictureY = textY + textH + CPFTopicCellMargin;
            CGFloat pictureX = CPFTopicCellMargin;
            _pictureFrame = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            
            _cellHeight += pictureH + CPFTopicCellMargin;
        } else if (self.type == CPFTopicTypeVoice) {
            
            CGFloat voiceX = CPFTopicCellMargin;
            CGFloat voiceY = textY + textH + CPFTopicCellMargin;
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = voiceW * self.height / self.width;
            _voiceFrame = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            
            _cellHeight += (voiceH + CPFTopicCellMargin);
        } else if (self.type == CPFTopicTypeVideo) {
            CGFloat videoX = CPFTopicCellMargin;
            CGFloat videoY = textY + textH + CPFTopicCellMargin;
            CGFloat videoW = maxSize.width;
            CGFloat videoH = videoW * self.height / self.width;
            _videoFrame = CGRectMake(videoX, videoY, videoW, videoH);
            
            _cellHeight += (videoH + CPFTopicCellMargin);
        }
        _cellHeight += 2 * CPFTopicCellMargin;
    }
    return _cellHeight;
}

// 转换服务器返回模型属性名
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2",
             };
}

@end
