//
//  Birds.h
//  BirdSpotter
//
//  Created by Brent Stewart on 8/7/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bird.h"

@interface Birds : NSObject

+(void) addBird: (Bird*) bird;

+(NSMutableArray *) birds;

@end
