//
//  BSStoreBirdInformation.h
//  BirdSpotter
//
//  Created by Brent Stewart on 7/24/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSStoreBirdInformation : NSObject

+(void)addObjectsToUserDefault : (NSDictionary*) dic;
+(id)getObjectFromUserDefaults : (NSString*) key;
+(void)removeAllObjectsFromUserDefaults;
+(void)removeObjectFromUserDefaults : (NSString*) key;
+(NSUserDefaults*) getUserDefaults;
+(void) setUserDefaults : (NSUserDefaults*) nsUserDefaults;

@end
