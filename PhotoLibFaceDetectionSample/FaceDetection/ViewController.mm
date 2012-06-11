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

#pragma mark - 
#pragma mark Properties
@implementation ViewController
@synthesize imageView;
@synthesize loadButton;
@synthesize faceButton;
@synthesize fileName;
@synthesize cameraButton;

#pragma mark - 
#pragma mark Managing Views
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
    [self setCameraButton:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

#pragma mark - 
#pragma mark Picker View
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[picker dismissModalViewControllerAnimated:YES];
	UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"]; 
   // image = [UIImageCVMatConverter scaleAndRotateImage:image];
    imageView.image = image;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
}

#pragma mark - 
#pragma mark Face Detection

-(cv::CascadeClassifier*)loadClassifier
{
    NSString* haar = [[NSBundle mainBundle] pathForResource:@"haarcascade_frontalface_default" ofType:@"xml"];    
    cv::CascadeClassifier* cascade = new cv::CascadeClassifier();
    cascade->load([haar UTF8String]);
    return cascade;
}

-(UIImage*)detect_and_draw:(UIImage* )inputImage
{
    int scale = 2;
    cv::Size minSize = cvSize(30, 30);
    float haarScale = 1.3f;
    int minNeighbors = 2;
    int haarFlags = 0 | CV_HAAR_DO_CANNY_PRUNING;
    cv::Mat grayMat;
    std::vector<cv::Rect> faces;
    cv::CascadeClassifier* faceCascade;
    cv::Mat cvMat =[UIImageCVMatConverter cvMatFromUIImage:inputImage];
    if(cvMat.channels() == 1)
        grayMat = cvMat;
    else{
        grayMat = cv :: Mat(cvMat.rows,cvMat.cols, CV_8UC3);
        cv::cvtColor(cvMat, grayMat, CV_BGR2GRAY);
    }
    cv::Mat smallMat =  cv::Mat((cvMat.rows / scale),(cvMat.cols / scale),CV_8UC3);

    // scale input image for faster processing
   cv::resize(grayMat, smallMat, smallMat.size(),0,0,CV_INTER_LINEAR);
   cv::equalizeHist(smallMat, smallMat);

    // Load XML   
    faceCascade = [self loadClassifier];
    CvMemStorage* storage = cvCreateMemStorage(0);
    // detect face
    faceCascade->detectMultiScale( grayMat, faces, haarScale, minNeighbors, haarFlags, minSize );
    smallMat.release();
    
    // get a CGContext with the image 
	CGContextRef contextRef = [self getContextForImage:imageView.image];
    // set line color
    CGContextSetRGBStrokeColor(contextRef, 1.0, 1.0, 0.0, 1);
    // set line width
    CGContextSetLineWidth(contextRef, 5.0);
    
    // for each face found, draw a box
   for( int i = 0; i < faces.size(); i++ )
   {        
       CvRect rect = faces[i];
        CGRect faceRect = CGContextConvertRectToDeviceSpace(contextRef,CGRectMake(rect.x , rect.y , rect.width , rect.height));
        CGContextAddRect(contextRef, faceRect);
        CGContextStrokePath(contextRef);
    }
    // make image out of bitmap context
    CGImageRef cgImage = CGBitmapContextCreateImage(contextRef);
    UIImage* faceImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    CGContextRelease(contextRef);
 
    cvReleaseMemStorage(&storage);
   // cvReleaseHaarClassifierCascade(&cascade);
    
    return faceImage;

}
#pragma mark - 
#pragma mark Button Action

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
- (IBAction)loadImageFromCamera:(id)sender
{
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentModalViewController:picker animated:YES];

}
#pragma mark - 
#pragma mark Image Context

- (CGContextRef)getContextForImage:(UIImage*)image
{
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    CGFloat widthStep = image.size.width;
    
    CGContextRef contextRef = CGBitmapContextCreate(NULL,                 // Pointer to  data
                                                    cols,                       // Width of bitmap
                                                    rows,                       // Height of bitmap
                                                    8,                          // Bits per component
                                                    widthStep*4,              // Bytes per row
                                                    colorSpace,                 // Colorspace
                                                    kCGImageAlphaNoneSkipLast |
                                                    kCGBitmapByteOrderDefault); // Bitmap info flags
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
   
    return contextRef;

}

@end
