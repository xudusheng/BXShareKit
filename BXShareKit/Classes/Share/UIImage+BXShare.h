//
//  UIImage+BXShare.h
//  MaiMkt
//
//  Created by ayi on 2018/5/24.
//  Copyright © 2018 ayi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BXShare)

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
                                maxHeight:(NSInteger)maxHeight;

@end
