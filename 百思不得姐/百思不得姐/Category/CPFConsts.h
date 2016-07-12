

#import <UIKit/UIKit.h>


typedef enum {
    CPFTopicTypeAll = 1,
    CPFTopicTypePicture = 10,
    CPFTopicTypeWord = 29,
    CPFTopicTypeVoice = 31,
    CPFTopicTypeVideo = 41
}CPFTopicType;

UIKIT_EXTERN CGFloat const CPFTitleViewH;
UIKIT_EXTERN CGFloat const CPFTitleViewY;

UIKIT_EXTERN CGFloat const CPFTopicCellMargin;
UIKIT_EXTERN CGFloat const CPFTopicCellButtomBarH;
UIKIT_EXTERN CGFloat const CPFTopicCellTopBarH;

// 图片最大不压缩高度
UIKIT_EXTERN CGFloat const CPFTopicCellPictureMaxH;
// 图片高度溢出
UIKIT_EXTERN CGFloat const CPFTopicCellPictureOverMaxH;

