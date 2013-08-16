//
//  BSBirdViewController.h
//  BirdSpotter
//
//  Created by Brent Stewart on 8/13/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSBird.h"
#import "BSBirdProfileView.h"

@interface BSBirdViewController : UIViewController

@property (strong, nonatomic) IBOutlet BSBirdProfileView *birdView;
@property (strong, nonatomic) IBOutlet UIImageView *birdImage;

- (void)loadBird : (BSBird*) bird;

@end
