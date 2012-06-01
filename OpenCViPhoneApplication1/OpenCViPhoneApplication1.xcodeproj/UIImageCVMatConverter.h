//
//  UIImageCVMatConverter.h
//  OpenCViPhoneApplication1
//
//  Created by MOHAMMED ALSHAIR on 5/31/12.
//  Copyright 2012 University of Houston - Main Campus. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIImageCVMatConverter : NSObject {
    
}
+(UIImage *)UIImageFromCVMat:(cv::Mat)image;
//-(cv::Mat)cvMatWithImage:(UIImage *)image;


@end
