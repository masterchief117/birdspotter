//
//  BSViewController.h
//  BirdSpotter
//
//  Created by Brent Stewart on 7/17/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "BSGeoLocationService.h"
#import "BSScrollAllBirdsViewController.h"
#import "BSInitializeUtility.h"

@interface BSViewMainMenuController : UIViewController<FBLoginViewDelegate, AVAudioRecorderDelegate>

@property (strong, nonatomic) IBOutlet FBLoginView *fbLoginView;
@property (strong, nonatomic) IBOutlet UIButton *foundNewBird;
- (IBAction)secretMovement:(UITapGestureRecognizer *)sender;
- (IBAction)makeSound:(UITapGestureRecognizer *)sender;
- (IBAction)viewAllBirdsFound:(UIButton *)sender;
@property(strong, nonatomic) BSInitializeUtility* initializeUtility;

@end
