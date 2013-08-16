//
//  BSDateService.m
//  BirdSpotter
//
//  Created by Brent Stewart on 7/25/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import "BSDateService.h"

@implementation BSDateService


static NSMutableDictionary* dates;

static NSDate* dateFound;
static NSDate* startDate;
static NSDate* endDate;



+(void) initialize{
    dateFound = [NSDate date];
    startDate = [NSDate date];
    endDate = [NSDate date];
    dates = [[NSMutableDictionary alloc] initWithObjectsAndKeys:dateFound, @"dateFound", startDate, @"startDate", endDate, @"endDate", nil];
}

+(void)setDate : (NSDate*) date dateType : (Dates) dateEnum{
    [dates setObject:date forKey:[BSDateService enumToString:dateEnum]];
}

+(NSDate*)getDate : (Dates) dateEnum{
    
    return [dates objectForKey:[BSDateService enumToString:dateEnum]];
}

+(NSString *)description : (Dates) dateEnum{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[BSDateService getDate:dateEnum]];
    return [[[NSMutableString alloc] initWithFormat:@"%d - %d - %d", [components month], [components day], [components year]] description];
}

+(NSString*)enumToString : (Dates) dateEnum{
    return ((int)dateEnum == START_DATE ? @"startDate" : (int)dateEnum == END_DATE ? @"endDate" : @"dateFound");
}

@end
