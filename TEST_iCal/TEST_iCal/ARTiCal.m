//
//  ARTiCal.m
//  TEST_iCal
//
//  Created by artwalk on 6/22/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ARTiCal.h"

@implementation ARTiCal

- (id)init {
    
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    EKCalendar *calendar = [EKCalendar calendarWithEventStore:eventStore];
    calendar.title = CALENDAR_TITLE;
    
    // Iterate over all sources in the event store and look for the local source
    EKSource *theSource = nil;
    for (EKSource *source in eventStore.sources) {
        if (source.sourceType == EKSourceTypeLocal) {
            theSource = source;
            break;
        }
    }
    
    if (theSource) {
        calendar.source = theSource;
    } else {
        NSLog(@"Error: Local source not available");
        return;
    }
    
}

@end
