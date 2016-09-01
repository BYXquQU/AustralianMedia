//
//  UIImage+XBCategory.h
//  BXYTool
//
//  Created by saifing on 16/8/26.
//  Copyright © 2016年 saifing. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIImage (XBCategory)

//需求:防止图片渲染
+ (UIImage *)imageRenderingModeImageNamed:(NSString *)imageName;

//自由拉伸一张图片
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;

//根据颜色和大小获取Image
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

//根据图片和颜色返回一张加深颜色以后的图片
+ (UIImage *)colorizeImage:(UIImage *)baseImage withColor:(UIColor *)theColor;

//自由改变Image的大小
- (UIImage *)cropImageWithSize:(CGSize)size;


//由颜色生成图片
+ (UIImage *) imageWithColor:(UIColor*)color;

//将图片剪裁至目标尺寸
+ (UIImage *) imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize;

//图片旋转角度
- (UIImage *) imageRotatedByDegrees:(CGFloat)degrees;

//拉伸图片UIEdgeInsets
- (UIImage *) resizableImage:(UIEdgeInsets)insets;

//拉伸图片CGFloat
- (UIImage *) imageByResizeToScale:(CGFloat)scale;

//放大图片CGSize
- (UIImage *) imageByResizeWithMaxSize:(CGSize)size;

//小样图图片CGSize
- (UIImage *) imageWithThumbnailForSize:(CGSize)size;

//通过Rect剪裁图片
- (UIImage *) imageByCropToRect:(CGRect)rect;

//图片增加圆角
- (UIImage *) imageByRoundCornerRadius:(CGFloat)radius;

//图片增加圆角及边框
- (UIImage *) imageByRoundCornerRadius:(CGFloat)radius
                           borderWidth:(CGFloat)borderWidth
                           borderColor:(UIColor *)borderColor;

//图片向左90度
//- (UIImage *)imageByRotateLeft90;
//
////图片向右90度
//- (UIImage *)imageByRotateRight90;

//图片转180度
- (UIImage *)imageByRotate180;

@end


@interface UIImage (Blur)


/**
 *  CoreImage图片高斯模糊
 *
 *  @param image 图片
 *  @param blur  模糊数值(默认是10)
 *
 *  @return 重新绘制的新图片
 */

+(UIImage *)coreBlurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

/**
 *  vImage模糊图片
 *
 *  @param image 原始图片
 *  @param blur  模糊数值(0-1)
 *
 *  @return 重新绘制的新图片
 */
+ (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

@end


@interface UIImage (ImageEffects)

//图片效果

- (UIImage *)applyLightEffect;
- (UIImage *)applyExtraLightEffect;
- (UIImage *)applyDarkEffect;
- (UIImage *)applyBlurEffect;
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius
                       tintColor:(UIColor *)tintColor
           saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                       maskImage:(UIImage *)maskImage;
@end
