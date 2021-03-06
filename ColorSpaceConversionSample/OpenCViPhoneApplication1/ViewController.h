//
//  ViewController.h
//  OpenCViPhoneApplication1
//

#include <opencv2/core/mat.hpp>
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *hsvButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *grayButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *binaryButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *loadButton;
@property (weak, nonatomic) NSString *fileName;
@property (readonly, nonatomic) cv::Mat cvMat;
@property (weak, nonatomic) IBOutlet UISlider *thresholdSlider;


-(IBAction)loadImageAction:(id)sender;
-(IBAction)hsvImageAction:(id)sender;
-(IBAction)grayImageAction:(id)sender;
-(IBAction)binaryImageAction:(id)sender;
@end
