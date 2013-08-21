//
//  BSBirdSubmissionViewViewController.m
//  BirdSpotter
//
//  Created by Brent Stewart on 7/17/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import "BSBirdSubmissionViewController.h"
#import "UIView+UITextFieldFinder.h"

@interface BSBirdSubmissionViewController ()
{
    bool okayToSubmit;
    
    AVAudioRecorder* recorder;
    AVAudioPlayer* player;
    NSString* imageLocation;
    
}
-(void) addObservers;

@end

@implementation BSBirdSubmissionViewController


bool okayToSubmit = FALSE;
static BOOL invalidInput = FALSE;
static BSGeoLocationService* geoLocationService;
static bool usedMap = FALSE;


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
    if(!usedMap){
        geoLocationService = [[BSGeoLocationService alloc] initWithDelegateId:self];
    }else{
        [geoLocationService setLatAndLon: self];
    }
    
    self.nameTextField.delegate = self;
    
	[self.dateButton setTitle:[BSDateService description:(Dates)FOUND_DATE] forState:UIControlStateNormal];
    if([BSStoreBirdInformation getObjectFromUserDefaults:@"name"] != nil){
        self.nameTextField.text = [BSStoreBirdInformation getObjectFromUserDefaults:@"name"];
    }else{
        self.nameTextField.placeholder = @"Common Name";
    }
    
    if([BSStoreBirdInformation getObjectFromUserDefaults:@"notes"] != nil){
        self.nameTextField.text = [BSStoreBirdInformation getObjectFromUserDefaults:@"notes"];
    }else{
        self.nameTextField.placeholder = @"Location Of Recording";
    }
    if(([BSStoreBirdInformation getObjectFromUserDefaults:@"recording"] != nil)){
        self.locationOfRecording.text = [BSStoreBirdInformation getObjectFromUserDefaults:@"recording"];
    }else{
    
    }
    if([BSStoreBirdInformation getObjectFromUserDefaults:@"birdImage"] != nil){
        imageLocation=[BSStoreBirdInformation getObjectFromUserDefaults:@"birdImage"];
        
        self.thumbnailImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:imageLocation]];
        
//        ALAssetsLibrary* library = [[ALAssetsLibrary alloc] init];
//        [library assetForURL:[[NSURL alloc] initWithString:string] resultBlock:^(ALAsset *asset) {
//            
//            ALAssetRepresentation *representation = asset.defaultRepresentation;
//            long long size = representation.size;
//            NSMutableData *rawData = [[NSMutableData alloc] initWithCapacity:size];
//            void *buffer = [rawData mutableBytes];
//            [representation getBytes:buffer fromOffset:0 length:size error:nil];
//            NSData *assetData = [[NSData alloc] initWithBytes:buffer length:size];
//        
//            self.thumbnailImageView.image = [[UIImage alloc] initWithData:assetData];
//            
//        } failureBlock:^(NSError *error) {
//            NSLog(@"%@", error);
//        }];
        
//        ALAssetRepresentation* asset = [ALAssetRepresentation
//        NSURL *url = [[NSURL alloc] initWithString:string];
//        NSData* data = [[NSData alloc]
//        self.thumbnailImageView.image = [[UIImage alloc] initWithData:data];
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(storeName:) name:UITextFieldTextDidEndEditingNotification object:self.nameTextField];
    [self addObservers];
    
    
    [self.mapButton setImage:[[UIImage alloc] initWithContentsOfFile:@"earth.jpg"] forState:UIControlStateNormal];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(saveStatus:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    
    [self.activityButton setTitle:[BSActivityUtility getActivity] forState:UIControlStateNormal];
    [self.nameTextField checkForValidInput:self.nameTextField];
    
    
    // Set the audio file
    NSArray *pathComponents = [NSArray arrayWithObjects:
                               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
                               ,[NSString stringWithFormat:@"%lf", [[NSDate date] timeIntervalSince1970]], nil];
    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
    
    // Setup audio session
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    // Define the recorder setting
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
    
    // Initiate and prepare the recorder
    recorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:recordSetting error:NULL];
    recorder.delegate = self;
    recorder.meteringEnabled = YES;
    [recorder prepareToRecord];
    
    [self editSubmitButton: self];
}


- (void)locationUpdate:(CLLocation *)location {
    
    
    self.latitudeValueLabel.text = [[NSMutableString alloc] initWithFormat: @"%f" , location.coordinate.latitude] ;
    self.longitudeValueLabel.text = [[NSMutableString alloc] initWithFormat: @"%f" , location.coordinate.longitude] ;
}
    
- (void)locationError:(NSError *)error {
    self.latitudeValueLabel.text = [error description];
    self.latitudeValueLabel.text = [error description];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) addObservers{
    [self.view addObserverForTextField];
}
- (void) thisMethod : (NSString*) a  : (NSString*) b{
    
}


- (IBAction)playRecording:(UITapGestureRecognizer *)sender {
    NSURL *url = [[NSURL alloc] initWithString:self.locationOfRecording.text];
    
    NSData *songFile = [[NSData alloc] initWithContentsOfURL:url];

    
    NSError* error;
    
    player = [[AVAudioPlayer alloc] initWithData:songFile error:&error];

    if(player.prepareToPlay)
        [player play];
}

- (IBAction)checkForValidInputs:(id)sender {
    NSArray* array = [UIView arrayOfFields] ;
    if([array count] > 0){
        okayToSubmit = TRUE;}
    else{
        okayToSubmit = FALSE;
    }
    for(id field in array)
    {
        if([field isKindOfClass:[UITextField class]]){
            if([(UITextField*)field checkForValidInput:(UITextField*)field])
            {
                okayToSubmit = FALSE;
            }
        }else{
            okayToSubmit = FALSE;
        }
    }
    if(okayToSubmit){
        self.submitButton.backgroundColor = [UIColor brownColor];
    }
    else{
        self.submitButton.backgroundColor = [UIColor blackColor];
    }
}

- (IBAction)submitButton:(id)sender {
    
    BSAppDelegate *appDelegate = (BSAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BSBird" inManagedObjectContext:context];
    
    
    BSBird* bird = (BSBird*)[[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
    
    NSError* error;
    
    [BSActivityUtility setActivity:@"None"];
    
    [bird setName:self.nameTextField.text];
    [bird setNotes: self.locationOfRecording.text];
    [bird setActivity:self.activityButton.titleLabel.text];
    [bird setLongitude:self.longitudeValueLabel.text];
    [bird setLatitude:self.latitudeValueLabel.text];
    [bird setPictureLocation:imageLocation];
    [context save:&error];

    
    [BSStoreBirdInformation removeAllObjectsFromUserDefaults];
}

- (IBAction)mapViewSelected:(UIButton *)sender {
    usedMap = TRUE;
}

- (void) saveStatus : (id) sender{
    
    [BSStoreBirdInformation addObjectsToUserDefault:[[NSDictionary alloc] initWithObjectsAndKeys:self.nameTextField.text, @"name", nil]];
}

- (IBAction)editSubmitButton:(id)sender {
    invalidInput = FALSE;
    [self checkInputs:self.view];
    [self.submitButton setEnabled: invalidInput ? FALSE : TRUE];
    
}

- (void) checkInputs : (UIView*) subview{
    if(![self checkValidation:subview]){
        for(UIView* view in subview.subviews){
            [self checkInputs:view];
        }
    }
}


-(BOOL) checkValidation : (id) obj{
    if([obj isKindOfClass:[UITextField class]]){
        if(((UITextField*)obj).text.length > 0){
        }else{
            
            invalidInput = TRUE;
            
        }
    } else if([obj isKindOfClass:[UIButton class]]){
        if(![((UIButton*)obj).titleLabel.text isEqualToString:@"Choose Activity"]){
        }   else{
            invalidInput = TRUE;
        }
    }
    return invalidInput;
}


- (IBAction)recordTasks:(UIButton *)sender {
    if([sender.titleLabel.text isEqualToString:@"Record"]){
        if(!recorder.recording){
            [recorder record];
            AVAudioSession *session = [AVAudioSession sharedInstance];
            [session setActive:YES error:nil];
            [sender setTitle:@"Stop" forState:UIControlStateNormal];
        }
    }else{
        if(recorder.recording){
            [recorder stop];
            AVAudioSession *session = [AVAudioSession sharedInstance];
            [session setActive:NO error:nil];
            [sender setTitle:@"Record" forState:UIControlStateNormal];
            [BSStoreBirdInformation addObjectsToUserDefault:[[NSDictionary alloc] initWithObjectsAndKeys:[recorder.url description], @"recording", nil]];
        }
    }
}



-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)record successfully:(BOOL)flag{
    [self.locationOfRecording setText:[record.url description]];
}


-(void) storeName: (id) sender{
    
    NSDictionary* dict =[[NSDictionary alloc] initWithObjectsAndKeys:self.nameTextField.text, @"name", nil];
    [BSStoreBirdInformation addObjectsToUserDefault:dict];
}


// start the camera stuff
- (IBAction)takePhoto:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)selectPhoto:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    NSInteger date = [[NSDate date] timeIntervalSince1970];
    NSData* data = UIImagePNGRepresentation(chosenImage);
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%ld", (long)date]]; //Add the file name
    imageLocation = filePath;
    [data writeToFile:filePath atomically:YES];
    [BSStoreBirdInformation addObjectsToUserDefault:[[NSDictionary alloc] initWithObjectsAndKeys:filePath, @"birdImage", nil]];
    
    // If wanting to save image in the libraries. Probably a secondary command to issue!
    
//    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//    // Request to save the image to camera roll
//    [library writeImageToSavedPhotosAlbum:[chosenImage CGImage] orientation:(ALAssetOrientation)[chosenImage imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error){
//        if (error) {
//            NSLog(@"error");
//        } else {
//            NSLog(@"url %@", assetURL);
//            [BSStoreBirdInformation addObjectsToUserDefault:[[NSDictionary alloc] initWithObjectsAndKeys:[assetURL description], @"birdImage", nil]];
//        }
//    }];
//    
    self.thumbnailImageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
// stop the camera stuff
@end