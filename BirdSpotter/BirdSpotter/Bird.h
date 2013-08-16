//
//  Bird.h
//  BirdSpotter
//
//  Created by Brent Stewart on 8/7/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bird : NSObject

@property (strong, nonatomic) NSNumber* latitude;
@property (strong, nonatomic) NSNumber* longitude;
@property (strong, nonatomic) NSString* locationName;
@property (strong, nonatomic) NSString* commonName;


@end
