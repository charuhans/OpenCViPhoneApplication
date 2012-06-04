//
//  OpenCViPhoneApplication1ViewController.m
//  OpenCViPhoneApplication1
//



#import "UIImageCVMatConverter.h"
#import "OpenCViPhoneApplication1ViewController.h"

@implementation OpenCViPhoneApplication1ViewController

@synthesize thresholdSlider;
@synthesize imageView;
@synthesize hsvButton;
@synthesize grayButton;
@synthesize binaryButton;
@synthesize loadButton;



@synthesize fileName, cvImage;


-(IBAction)loadImageAction:(id)sender;
{
    fileName = [[NSBundle mainBundle] pathForResource:@"fruits" ofType:@"png"];
    UIImage *loadImage = [UIImage imageWithContentsOfFile:fileName];
    // convert UIImage to cvMat
    cvImage =[UIImageCVMatConverter cvMatFromUIImage:loadImage];
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
    cv::Mat hsv_image;
    cv::cvtColor (cvImage, hsv_image, CV_BGR2HSV); 
    // convert cvMat to UIImage
    imageView.image = [UIImageCVMatConverter UIImageFromCVMat:hsv_image];
    hsv_image.release();

}
-(IBAction)grayImageAction:(id)sender
{
    thresholdSlider.hidden = YES;
    cv::Mat greyMat;
    cv::cvtColor(cvImage, greyMat, CV_BGR2GRAY);
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
    cv::cvtColor(cvImage, greyMat, CV_BGR2GRAY);
    cv::threshold(greyMat,binaryMat,threshold,255,cv::THRESH_BINARY);
    greyMat.release();
    // convert cvMat to UIImage
    imageView.image = [UIImageCVMatConverter UIImageFromCVMat:binaryMat];
    binaryMat.release();
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}
- (void)dealloc
{
    [fileName release];
    [loadButton release];
    [hsvButton release];
    [grayButton release];
    [binaryButton release];
    [imageView release];
    [thresholdSlider release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload
{
    
   [self setImageView:nil];
   [self setLoadButton:nil];
   [self setHsvButton:nil];
   [self setGrayButton:nil];
   [self setBinaryButton:nil];
   [self setImageView:nil];
  
    [self setThresholdSlider:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
