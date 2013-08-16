//
//  BSActivityUtility.h
//  BirdSpotter
//
//  Created by Brent Stewart on 7/24/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSActivityUtility : NSObject

+(void)initialize;
+(NSArray*) getActivities;
+(void) setActivity : (NSString*) activity;
+(NSString*) getActivity;
@end