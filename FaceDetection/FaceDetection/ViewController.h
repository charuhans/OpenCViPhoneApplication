//
//  ViewController.h
//  FaceDetection
//
//  Created by MOHAMMED ALSHAIR on 6/8/12.
//  Copyright (c) 2012 University of Houston - Main Campus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> 
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *loadButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *faceButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cameraButton;

@property (weak, nonatomic) NSString *fileName;

- (IBAction)loadImageFromPhotoLibrary:(id)sender;
- (IBAction)loadImageFromCamera:(id)sender;
- (IBAction)faceDetect:(id)sender;
-(UIImage*)detect_and_draw:(UIImage* )inputImage;
@end
