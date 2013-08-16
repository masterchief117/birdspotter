//
//  BSActivityUtility.m
//  BirdSpotter
//
//  Created by Brent Stewart on 7/24/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import "BSActivityUtility.h"

@implementation BSActivityUtility

NSArray* activities;
NSString* selectedActivity;


+ (void)initialize{
    activities = @[@"None", @"Eating", @"Squawking"];
    selectedActivity = @"Choose Activity";
}

+(NSArray*) getActivities{
    return activities;
}

+(void) setActivity : (NSString*) activity{
    selectedActivity = activity;
}

+(NSString*) getActivity{
    return selectedActivity;
}

@end
