//
//  BSDateService.h
//  BirdSpotter
//
//  Created by Brent Stewart on 7/25/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSDateService : NSObject

typedef enum Dates{
    START_DATE,
    END_DATE,
    FOUND_DATE
} Dates;

+(void)setDate : (NSDate*) date dateType : (Dates) dateEnum;
+(NSDate*)getDate : (Dates) dateEnum;
+(NSString *)description : (Dates) dateEnum;
@end
