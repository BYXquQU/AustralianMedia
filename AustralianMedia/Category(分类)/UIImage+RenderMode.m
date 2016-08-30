//
//  UIImage+RenderMode.m
//  BaisiTest
//
//  Created by saifing on 16/1/19.
//  Copyright © 2016年 saifing. All rights reserved.
//

#import "UIImage+RenderMode.h"

@implementation UIImage (RenderMode)

+ (UIImage *)imageRenderingModeImageNamed:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
