//
//  BSBirdSubmissionViewViewController.h
//  BirdSpotter
//
//  Created by Brent Stewart on 7/17/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <AVFoundation/AVFoundation.h>
#import "BSBird.h"
#import "UIView+UITextFieldFinder.h"
#import "UITextField+AddObserver.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "BSGeoLocationService.h"
#import "BSActivityUtility.h"
#import "BSStoreBirdInformation.h"
#import "BSDateService.h"
#import "UIViewController+LatLonPropertiesDelegate.h"
#import "UITextField+TextValidation.h"
#import "BSAppDelegate.h"



@interface BSBirdSubmissionViewController : UIViewController <BSGeolLocationDelegate, UITextFieldDelegate, LatLonPropertiesDelegate, AVAudioRecorderDelegate, AVAudioPlayerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>



@property (strong, nonatomic) IBOutlet UILabel *latitudeValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *birdLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *geoLocationLabel;
@property (strong, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (strong, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (strong, nonatomic) IBOutlet UILabel *photoLabel;
@property (strong, nonatomic) IBOutlet UILabel *longitudeValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *activityLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationOfRecording;

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;


@property (strong, nonatomic) IBOutlet UIButton *dateButton;
@property (strong, nonatomic) IBOutlet UIButton *mapButton;
@property (strong, nonatomic) IBOutlet UIButton *recordButton;

@property (strong, nonatomic) IBOutlet UIButton *takePictureButton;
@property (strong, nonatomic) IBOutlet UIButton *exisitingPhotoButton;
@property (strong, nonatomic) IBOutlet UIButton* submitButton;
@property (strong, nonatomic) IBOutlet UIButton *activityButton;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UIImageView *thumbnailImageView;

@property (strong, nonatomic) IBOutlet UIView *birdDetailsView;
@property (strong, nonatomic) IBOutlet UIView *submissionView;

@property (strong, nonatomic) CLLocation* location;


- (IBAction)playRecording:(UITapGestureRecognizer *)sender;

- (IBAction)checkForValidInputs:(id)sender;

- (IBAction)submitButton:(id)sender;

- (IBAction)mapViewSelected:(UIButton *)sender;

- (IBAction)recordTasks:(UIButton *)sender;

- (IBAction)editSubmitButton:(id)sender;

- (IBAction)takePhoto:(UIButton *)sender;

- (IBAction)selectPhoto:(UIButton *)sender;


- (void) locationUpdate : (CLLocation*) location;
- (void) locationError : (NSError*) error;
@end
