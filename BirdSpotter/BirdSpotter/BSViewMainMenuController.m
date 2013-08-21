//
//  BSViewController.m
//  BirdSpotter
//
//  Created by Brent Stewart on 7/17/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import "BSViewMainMenuController.h"

@interface BSViewMainMenuController ()


@end

@implementation BSViewMainMenuController 

SystemSoundID soundId;
AVAudioRecorder *recorder;

int alpha = 0;
int count = 0;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self becomeFirstResponder];
    [_foundNewBird setTitle:[NSString stringWithFormat:NSLocalizedString(@"Found Bird", nil)] forState:UIControlStateNormal];
    [BSGeoLocationService initialize];
    [self initService];
    
}

-(void) initService{
    if(_initializeUtility == nil){
        _initializeUtility = [[BSInitializeUtility alloc] init];
    }
    [_initializeUtility initService:[BSGeoLocationService class]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.subtype == UIEventSubtypeMotionShake) {
        
        UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(40, 40, 30, 200)];
        button.backgroundColor = [UIColor blackColor];
        [button setTitle:@"Top Secrets!" forState:UIControlStateNormal];
        [self.view addSubview:button];
    }
}


-(void)loginView:(FBLoginView *)loginView handleError:(NSError *)error{
}



- (IBAction)secretMovement:(UITapGestureRecognizer *)sender {
    [UIView animateWithDuration:5
                          delay:.1
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.foundNewBird.alpha = alpha;
                     }
                     completion:^(BOOL finished)
    {
                         alpha = alpha == 0 ? 1 : 0;
                     }];
}

- (IBAction)makeSound:(UITapGestureRecognizer *)sender {
    
    NSURL* sound = [[NSBundle mainBundle] URLForResource:@"hawk" withExtension:@"aif"];
    
    CFURLRef noise = (__bridge CFURLRef)sound;
    AudioServicesCreateSystemSoundID(noise, &soundId);
    [NSTimer scheduledTimerWithTimeInterval:.9 target:self selector:@selector(playSound:) userInfo:nil repeats:YES];
   
}

- (IBAction)viewAllBirdsFound:(UIButton *)sender {
    UIViewController* scrollBirds = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewAllBirds"];
    [self presentViewController:scrollBirds animated:YES completion:^{
    // nothing for now. Probably a good spot to run save state methods! :-D
    }];
}

-(void) playSound : (id) sender{
    if(count > 4){
        AudioServicesRemoveSystemSoundCompletion(soundId);
    }
    else{
        AudioServicesPlaySystemSound(soundId);
        count++;
    }
    
}
@end
