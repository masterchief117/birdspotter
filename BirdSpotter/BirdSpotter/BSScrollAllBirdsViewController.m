//
//  BSScrollAllBirdsViewController.m
//  BirdSpotter
//
//  Created by Brent Stewart on 8/13/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import "BSScrollAllBirdsViewController.h"
#import "BSAppDelegate.h"
#define WIDTH 220
#define HEIGHT 400
#define EMPTY_SPACE_ON_RIGHT 10

@interface BSScrollAllBirdsViewController ()

@end

@implementation BSScrollAllBirdsViewController

BSAppDelegate* appDelegate;
NSManagedObjectContext* context;
NSFetchRequest* fetch;
NSArray* birds;
AVAudioPlayer* player;

bool SIDE_SCROLL;
bool notPlayingSound;

int indexSize;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    SIDE_SCROLL = TRUE;
    notPlayingSound = TRUE;
    
    player.delegate = self;
    
    appDelegate = (BSAppDelegate*)[[UIApplication sharedApplication] delegate];
    context = [appDelegate managedObjectContext];
    
    fetch = [[NSFetchRequest alloc] initWithEntityName:@"BSBird"];
    NSError* error;
    birds = [context executeFetchRequest:fetch error:&error];
    indexSize = 0;
    [_primaryScrollView setShowsHorizontalScrollIndicator:NO];
    [_primaryScrollView setShowsVerticalScrollIndicator:NO];
    [_primaryScrollView setBackgroundColor:[UIColor redColor]];
    
    _primaryScrollView.delegate = self;
    
    
    // just added delegate
    [self.view addSubview:_primaryScrollView];
    
    [self loadMoreBirds];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loadMoreBirds{
    int initialWidth = EMPTY_SPACE_ON_RIGHT;
    
    for(int index  = 0; index < birds.count; index++){
        UIScrollView* secondaryScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(index * (WIDTH + 10) + initialWidth, 0, WIDTH+3, HEIGHT)];
        [secondaryScroll setContentSize:CGSizeMake(WIDTH, HEIGHT + 200)];
        BSBird* bird = [birds objectAtIndex:index];
        // probably do not need to keep regenerating this.
        // FIX LATERS
        NSArray* arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"BirdViewer" owner:nil options:nil];
        BSBirdProfileView* birdView = [arrayOfViews objectAtIndex:0];
        birdView.birdImage.image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfFile:bird.pictureLocation]];
        birdView.birdName.text = bird.name;
        birdView.recordingLocation = bird.notes;
        [secondaryScroll setBackgroundColor:[UIColor blackColor]];
        [secondaryScroll addSubview:[self createImageOfFoundBirdView:birdView imageXPosition: 0 imageYPosition:0]];
        [_primaryScrollView addSubview:secondaryScroll];
    }
    [_primaryScrollView setContentSize:CGSizeMake(birds.count * (WIDTH + 10) + (initialWidth * 2),HEIGHT)];
    
    [[NSRunLoop mainRunLoop] addTimer:[NSTimer timerWithTimeInterval:.01 target:self selector:@selector(scrollScreen) userInfo:Nil repeats:YES] forMode:NSRunLoopCommonModes];
    
}

-(void) scrollScreen{
    SIDE_SCROLL = NO;
    if(SIDE_SCROLL){
        int x = _primaryScrollView.contentOffset.x + 2;
        [_primaryScrollView setContentOffset:CGPointMake(x, _primaryScrollView.contentOffset.y) animated:NO];
        if(x > (_primaryScrollView.contentSize.width - WIDTH - EMPTY_SPACE_ON_RIGHT - 60)){
            [_primaryScrollView setContentOffset:CGPointMake(0, _primaryScrollView.contentOffset.y) animated:NO];
        }
    }
    
}


-(UIImageView*) createImageOfFoundBirdView : (BSBirdProfileView*) birdView imageXPosition : (int) x imageYPosition : (int) y {
    UIGraphicsBeginImageContext(birdView.frame.size);
    
    [birdView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContext(CGSizeMake(WIDTH, HEIGHT));
    [viewImage drawInRect:CGRectMake(0, 0, WIDTH, HEIGHT)];
    UIImage* imageAfterResize = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView* imageView = [[UIImageView alloc] initWithImage:imageAfterResize];
    imageView.frame = CGRectMake(x, y, WIDTH, HEIGHT);
    return imageView;
}

- (IBAction)loadMainMenu:(UIButton *)sender {
    [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"mainMenu"] animated:YES completion:^{
        
    }];
}

- (IBAction)playRecording:(id)sender {
    if([sender isKindOfClass:[UILongPressGestureRecognizer class] ]){
        if(notPlayingSound){
            notPlayingSound = FALSE;
            CGPoint point = [sender locationInView:_primaryScrollView];
            
            NSString* fileLocation = [self findBirdSelectedFromPoint : point];
            if( fileLocation != nil){
                NSURL *url = [[NSURL alloc] initWithString:fileLocation];
                
                NSData *songFile = [[NSData alloc] initWithContentsOfURL:url];
                
                NSError* error;
                
                player = [[AVAudioPlayer alloc] initWithData:songFile error:&error];
                
                if([player prepareToPlay]){
                    
                    [player play];
                }
                
            }
            notPlayingSound = TRUE;
        }
    }
}

-(NSString*) findBirdSelectedFromPoint : (CGPoint) point{
    int index = ((int)point.x  / 230);
    if(index < birds.count)
        return ((BSBird*)[birds objectAtIndex:index]).notes;
    return nil;
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    CGRect visibleRect;
    if(decelerate == false){
        visibleRect.origin = scrollView.contentOffset;
        visibleRect.size = scrollView.contentSize;
        
    }
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGRect visibleRect;
    visibleRect.origin = scrollView.contentOffset;
    visibleRect.size = scrollView.contentSize;
}

@end