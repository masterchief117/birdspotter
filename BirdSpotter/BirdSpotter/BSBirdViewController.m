//
//  BSBirdViewController.m
//  BirdSpotter
//
//  Created by Brent Stewart on 8/13/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import "BSBirdViewController.h"

@interface BSBirdViewController (){
    NSString* recordingLocation;
    NSString* imageLocation;
}

@end

@implementation BSBirdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)loadBird : (BSBird*) bird{
            _birdImage.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:bird.pictureLocation]];

}

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view.
}

-(void)viewWillLayoutSubviews{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setImage{
    //_birdImage.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:imageLocation]];
}

@end