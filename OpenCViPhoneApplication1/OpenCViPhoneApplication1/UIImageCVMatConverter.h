//
//  UIImageCVMatConverter.h
//  OpenCViPhoneApplication1
//


#import <Foundation/Foundation.h>


@interface UIImageCVMatConverter : NSObject {
    
}
+ (UIImage *)UIImageFromCVMat:(const cv::Mat&)cvMat;
//-(cv::Mat)cvMatWithImage:(UIImage *)image;


@end
