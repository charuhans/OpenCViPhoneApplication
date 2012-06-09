//
//  ViewController.m
//  FaceDetection
//
//  Created by MOHAMMED ALSHAIR on 6/8/12.
//  Copyright (c) 2012 University of Houston - Main Campus. All rights reserved.
//

#import "ViewController.h"
#import <opencv2/imgproc/imgproc_c.h>
#import <opencv2/objdetect/objdetect.hpp>
#import "UIImageCVMatConverter.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize imageView;
@synthesize loadButton;
@synthesize faceButton;
@synthesize fileName;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setImageView:nil];
    [self setLoadButton:nil];
    [self setFaceButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [picker dismissModalViewControllerAnimated:YES];
    imageView.image = image;

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
}
-(UIImage*)detect_and_draw:(UIImage* )inputImage
{
    int scale = 2;
    cv::Size minSize = cvSize(20, 20);
    float haarScale = 1.2f;
    int minNeighbors = 2;
    int haarFlags = CV_HAAR_DO_CANNY_PRUNING;
    cv::Mat cvMat =[UIImageCVMatConverter cvMatFromUIImage:inputImage];
    cv::Mat grayMat;
    if(cvMat.channels() == 1)
        grayMat = cvMat;
    else{
        grayMat = cv :: Mat(cvMat.rows,cvMat.cols, CV_8UC1);
        cv::cvtColor(cvMat, grayMat, CV_BGR2GRAY);
    }
    cv::Mat smallMat =  cv::Mat((cvMat.rows / scale),(cvMat.cols / scale),CV_8UC3);

    // scale input image for faster processing
   cv::resize(grayMat, smallMat, smallMat.size(),0,0,CV_INTER_LINEAR);
   cv::equalizeHist(smallMat, smallMat);

    // Load XML
    NSString* haar = [[NSBundle mainBundle] pathForResource:@"haarcascade_frontalface_default" ofType:@"xml"];    
    CvHaarClassifierCascade* cascade = (CvHaarClassifierCascade*)cvLoad([haar cStringUsingEncoding:NSASCIIStringEncoding], 0, 0, 0);
    
    CvMemStorage* storage = cvCreateMemStorage(0);
    IplImage iplImg = smallMat;
    CvSeq* faces = cvHaarDetectObjects(&iplImg, cascade, storage, haarScale, minNeighbors, haarFlags, minSize);
    smallMat.release();
    
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(imageView.image.CGImage);
    CGFloat cols = imageView.image.size.width;
    CGFloat rows = imageView.image.size.height;
    CGFloat widthStep = imageView.image.size.width;
    
    CGContextRef contextRef = CGBitmapContextCreate(NULL,                 // Pointer to  data
                                                    cols,                       // Width of bitmap
                                                    rows,                       // Height of bitmap
                                                    8,                          // Bits per component
                                                    widthStep*4,              // Bytes per row
                                                    colorSpace,                 // Colorspace
                                                    kCGImageAlphaNoneSkipLast |
                                                    kCGBitmapByteOrderDefault); // Bitmap info flags
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), imageView.image.CGImage);
    CGContextSetRGBStrokeColor(contextRef, 1, 0, 0, 1);
    
    // for each face found, draw a box
    for(int i = 0 ; i < ( faces ? faces->total : 0 ) ; i++ )
    {        
        CvRect rect = *( CvRect* )cvGetSeqElem( faces, i );
        
        CGRect faceRect = CGContextConvertRectToDeviceSpace(contextRef,CGRectMake(rect.x * scale, rect.y * scale, rect.width * scale, rect.height * scale));
        CGContextAddRect(contextRef, faceRect);
        CGContextStrokePath(contextRef);
    }
    // make image out of bitmap context
    CGImageRef cgImage = CGBitmapContextCreateImage(contextRef);
    UIImage* faceImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    CGContextRelease(contextRef);
    CGColorSpaceRelease(colorSpace);
    cvReleaseMemStorage(&storage);
    cvReleaseHaarClassifierCascade(&cascade);
    
    return faceImage;

}
- (IBAction)loadImageFromPhotoLibrary:(id)sender
{
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentModalViewController:picker animated:YES]; 
     
}
- (IBAction)faceDetect:(id)sender
{
    UIImage *face = [self detect_and_draw:imageView.image];
    if (face != nil) {
        imageView.image = face;
    }
}

@end
