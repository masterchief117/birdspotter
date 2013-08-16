//
//  Bird.m
//  BirdSpotter
//
//  Created by Brent Stewart on 7/17/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import "BSBird.h"


@implementation BSBird

@dynamic name;
@dynamic dateLocated;
@dynamic activity;
@dynamic latitude;
@dynamic longitude;
@dynamic notes;
@dynamic pictureLocation;
@dynamic birdId;


-(NSString*) description{
    return self.name;
}

@end
