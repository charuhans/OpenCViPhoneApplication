//
//  OpenCViPhoneApplication1ViewController.h
//  OpenCViPhoneApplication1
//

#include <opencv2/core/mat.hpp>
#import <UIKit/UIKit.h>


@interface OpenCViPhoneApplication1ViewController : UIViewController {
   
    NSString *fileName;  
   IBOutlet UIBarButtonItem *loadButton;
 
  IBOutlet  UIBarButtonItem *hsvButton;
  IBOutlet  UIBarButtonItem *grayButton;
  IBOutlet  UIBarButtonItem *binaryButton;
  IBOutlet UIImageView *imageView;
    
    UISlider *thresholdSlider;
}

@property (nonatomic, retain) IBOutlet UISlider *thresholdSlider;

@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) NSString *fileName;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *loadButton;

@property(nonatomic, readonly) cv::Mat cvImage;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *hsvButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *grayButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *binaryButton;

- (void)loadImageFromFile:(NSString *) theFileName;

-(IBAction)loadImageAction:(id)sender;
-(IBAction)hsvImageAction:(id)sender;
-(IBAction)grayImageAction:(id)sender;
-(IBAction)binaryImageAction:(id)sender;



@end
