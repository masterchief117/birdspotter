//
//  Bird.h
//  BirdSpotter
//
//  Created by Brent Stewart on 7/17/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BSBird : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * dateLocated;
@property (nonatomic, retain) NSString * activity;
@property (nonatomic, retain) NSString * latitude;
@property (nonatomic, retain) NSString * longitude;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * pictureLocation;
@property (nonatomic, retain) NSNumber * birdId;

@end
