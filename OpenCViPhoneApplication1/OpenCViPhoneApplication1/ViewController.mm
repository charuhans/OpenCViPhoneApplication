//
//  ViewController.m
//  OpenCViPhoneApplication1
//
//  Created by MOHAMMED ALSHAIR on 6/7/12.
//  Copyright (c) 2012 University of Houston - Main Campus. All rights reserved.
//

#import "ViewController.h"
#import "UIImageCVMatConverter.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize thresholdSlider;
@synthesize imageView;
@synthesize hsvButton;
@synthesize grayButton;
@synthesize binaryButton;
@synthesize loadButton;
@synthesize fileName, cvMat;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setImageView:nil];
    [self setLoadButton:nil];
    [self setHsvButton:nil];
    [self setGrayButton:nil];
    [self setBinaryButton:nil];
    [self setThresholdSlider:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(IBAction)loadImageAction:(id)sender;
{
    fileName = [[NSBundle mainBundle] pathForResource:@"fruits" ofType:@"png"];
    UIImage *loadImage = [UIImage imageWithContentsOfFile:fileName];
    // convert UIImage to cvMat
    cvMat =[UIImageCVMatConverter cvMatFromUIImage:loadImage];
    if (loadImage != nil) {
        imageView.image = loadImage;
    } 
    hsvButton.enabled = YES;
    grayButton.enabled = YES;
    binaryButton.enabled = YES;
    thresholdSlider.hidden = YES;
    
}
-(IBAction)hsvImageAction:(id)sender
{
    thresholdSlider.hidden = YES;
    cv::Mat hsvImage;
    cv::cvtColor (cvMat, hsvImage, CV_BGR2HSV); 
    // convert cvMat to UIImage
    imageView.image = [UIImageCVMatConverter UIImageFromCVMat:hsvImage];
    hsvImage.release();
    
}
-(IBAction)grayImageAction:(id)sender
{
    thresholdSlider.hidden = YES;
    cv::Mat greyMat;
    cv::cvtColor(cvMat, greyMat, CV_BGR2GRAY);
    // convert cvMat to UIImage
    self.imageView.image = [UIImageCVMatConverter UIImageFromCVMat:greyMat];
    greyMat.release();
}
-(IBAction)binaryImageAction:(id)sender
{
    cv::Mat binaryMat, greyMat;
    thresholdSlider.hidden = NO;
    thresholdSlider.continuous = YES;
    float threshold = thresholdSlider.value;
    cv::cvtColor(cvMat, greyMat, CV_BGR2GRAY);
    cv::threshold(greyMat,binaryMat,threshold,255,cv::THRESH_BINARY);
    greyMat.release();
    // convert cvMat to UIImage
    imageView.image = [UIImageCVMatConverter UIImageFromCVMat:binaryMat];
    binaryMat.release();
    
}


@end
