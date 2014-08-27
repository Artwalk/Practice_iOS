//
//  ViewController.m
//  19.10.EventViewControllers
//
//  Created by artwalk on 8/26/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ViewController.h"
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>

@interface ViewController () <EKEventViewDelegate>

@property (nonatomic, strong) EKEventStore *eventStore;

@end

@implementation ViewController

- (EKSource *)sourceInEventStore:(EKEventStore *)evStore sourceType:(EKSourceType)type sourceTitle:(NSString *)title {
    for (EKSource *s in evStore.sources) {
        if (s.sourceType == type && [s.title caseInsensitiveCompare:title] == NSOrderedSame) {
            return s;
        }
    }
    return nil;
}

- (void)displayEventViewController {
    EKSource *icloudSource = [self sourceInEventStore:self.eventStore sourceType:EKSourceTypeCalDAV sourceTitle:@"iCloud"];
    
    if (icloudSource == nil) {
        NSLog(@"no iCloud");
        return;
    }
    
    NSSet *cals = [icloudSource calendarsForEntityType:EKEntityTypeEvent];
    
    NSTimeInterval NSOneDay = 1 * 24.0f * 60 * 60;
    NSDate *startDate = [[NSDate date] dateByAddingTimeInterval:-NSOneDay];
    NSDate *endDate = [NSDate date];
    
    NSPredicate *predicate = [self.eventStore predicateForEventsWithStartDate:startDate endDate:endDate calendars:cals.allObjects];
    
    NSArray *events = [self.eventStore eventsMatchingPredicate:predicate];
    
    if ([events count] > 0) {
        EKEvent *e = events[0];
        EKEventViewController *controller = [[EKEventViewController alloc] init];
        controller.event = e;
//        controller.allowsEditing = NO;
//        controller.allowsCalendarPreview = YES;
        controller.delegate = self;
        
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.eventStore = [[EKEventStore alloc] init];
    switch ([EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent ]) {
        case EKAuthorizationStatusAuthorized:
            [self displayEventViewController];
            break;
        case EKAuthorizationStatusNotDetermined: {
            [self.eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
                if (granted) {
                    [self displayEventViewController];
                }
            }];
            break;
        }
            
        default:
            break;
    }
}

- (void)eventViewController:(EKEventViewController *)controller didCompleteWithAction:(EKEventViewAction)action {
    switch (action) {
        case EKEventViewActionDeleted:
            NSLog(@"del");
            break;
        case EKEventViewActionDone:
            NSLog(@"done");
            break;
        case EKEventViewActionResponded:
            NSLog(@"responded");
            break;
        default:
            break;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
