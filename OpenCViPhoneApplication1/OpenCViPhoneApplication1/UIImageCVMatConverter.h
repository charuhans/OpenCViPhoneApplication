//
//  UIImageCVMatConverter.h
//  OpenCViPhoneApplication1
//


#import <Foundation/Foundation.h>


@interface UIImageCVMatConverter : NSObject {
    
}
+ (UIImage *)UIImageFromCVMat:(cv::Mat)cvMat;
+ (cv::Mat)cvMatFromUIImage:(UIImage *)image;
+ (cv::Mat)cvMatGrayFromUIImage:(UIImage *)image;


@end
