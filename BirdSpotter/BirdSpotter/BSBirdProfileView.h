//
//  BSBirdProfileView.h
//  BirdSpotter
//
//  Created by Brent Stewart on 8/13/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSBirdProfileView : UIView
@property (strong, nonatomic) IBOutlet UILabel *birdName;
@property (strong, nonatomic) IBOutlet UIImageView *birdImage;
@property (strong, nonatomic) NSString* recordingLocation;


@end
