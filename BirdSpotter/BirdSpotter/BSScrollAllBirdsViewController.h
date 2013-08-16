//
//  BSScrollAllBirdsViewController.h
//  BirdSpotter
//
//  Created by Brent Stewart on 8/13/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "BSBird.h"
#import "BSBirdViewController.h"
#import "BSBirdProfileView.h"
#import <AVFoundation/AVFoundation.h>

@interface BSScrollAllBirdsViewController : UIViewController<UIScrollViewDelegate, AVAudioPlayerDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *primaryScrollView;
- (IBAction)loadMainMenu:(UIButton *)sender;

- (IBAction)playRecording:(id)sender;

@end
