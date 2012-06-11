//
//  ViewController.h
//  FaceDetection
//


#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> 
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *loadButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *faceButton;

@property (weak, nonatomic) NSString *fileName;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cameraButton;

- (IBAction)loadImageFromPhotoLibrary:(id)sender;
- (IBAction)loadImageFromCamera:(id)sender;
- (IBAction)faceDetect:(id)sender;
-(UIImage*)detect_and_draw:(UIImage* )inputImage;
-(cv::CascadeClassifier*)loadClassifier;
- (CGContextRef)getContextForImage:(UIImage*)image;
@end
