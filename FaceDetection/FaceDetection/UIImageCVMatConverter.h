//
//  UIImageCVMatConverter.h
//  OpenCViOS
//
//  Created by MOHAMMED ALSHAIR on 6/6/12.
//  Copyright (c) 2012 University of Houston - Main Campus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImageCVMatConverter : NSObject

+ (UIImage *)UIImageFromCVMat:(cv::Mat)cvMat;
+ (cv::Mat)cvMatFromUIImage:(UIImage *)image;
+ (cv::Mat)cvMatGrayFromUIImage:(UIImage *)image;
+ (UIImage *)scaleAndRotateImage:(UIImage *)image;

@end
