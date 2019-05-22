//
//  UIImage+BXShare.m
//  MaiMkt
//
//  Created by ayi on 2018/5/24.
//  Copyright © 2018 ayi. All rights reserved.
//

#import "UIImage+BXShare.h"

@implementation UIImage (BXShare)

/**
 *  压缩图片分辨率
 *
 *  @param originalImage 原图
 *  @param maxWidth      最大宽度
 *  @param maxHeight     最大高度
 *
 *  @return 压缩分辨率后的图片
 */
+ (UIImage *)imageCompressToJPGWithImgage:(UIImage *)originalImage
                                 maxWidth:(NSInteger)maxWidth
                                maxHeight:(NSInteger)maxHeight {
    
    CGSize size = [self conversionSizeWithSize:originalImage.size maxWidth:maxWidth maxHeight:maxHeight];
    
    if (CGSizeEqualToSize(originalImage.size, size)) {
        // 分辨率没有改变直接返回原图
        return originalImage;
    }
    
    // Scale the original image to match the new size.
    UIGraphicsBeginImageContext(size);
    [originalImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* compressedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return compressedImage;
}

// 根据宽高计算压缩后的分辨率，宽高同时不超过设置的最大值
+ (CGSize)conversionSizeWithSize:(CGSize)size maxWidth:(NSInteger)maxWidth maxHeight:(NSInteger)maxHeight {
    float scaleWidth = 1;
    float scaleHeight = 1;
    if (size.width > maxWidth) {
        scaleWidth = (float)maxWidth / (float)size.width;
    }
    if (size.height > maxHeight) {
        scaleHeight = (float)maxHeight / (float)size.height;
    }
    
    float scale = MIN(scaleHeight, scaleWidth);
    CGSize conversionSize = CGSizeMake(size.width * scale, size.height * scale);
    
    return conversionSize;
}

@end
