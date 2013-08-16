//
//  BSStoreBirdInformation.m
//  BirdSpotter
//
//  Created by Brent Stewart on 7/24/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import "BSStoreBirdInformation.h"
#import <UIKit/UIKit.h>

@implementation BSStoreBirdInformation

NSUserDefaults* userDefaults;


+(void)initialize{
    userDefaults = [NSUserDefaults standardUserDefaults];
}


+(void)addObjectsToUserDefault : (NSDictionary*) dic{
    for(id key in dic){
        [userDefaults setObject:[dic objectForKey:key] forKey: key];
    }
}

+(id)getObjectFromUserDefaults : (NSString*) key{
    return [userDefaults objectForKey:key];
}

+(void)removeAllObjectsFromUserDefaults{
    NSDictionary* dic = [userDefaults dictionaryRepresentation];
    for(id key in dic){
        [userDefaults removeObjectForKey:key];
    }
}

+(void)removeObjectFromUserDefaults : (NSString*)  key{
    [userDefaults removeObjectForKey:key];
}

+(NSUserDefaults*) getUserDefaults{
    return userDefaults;
}

+(void) setUserDefaults : (NSUserDefaults*) nsUserDefaults{
    userDefaults = nsUserDefaults;
}

@end
