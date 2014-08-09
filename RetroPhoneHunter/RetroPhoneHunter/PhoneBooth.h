//
//  PhoneBooth.h
//  RetroPhoneHunter
//
//  Created by artwalk on 5/26/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PhoneBooth : NSManagedObject

@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * imagePath;
@property (nonatomic, retain) NSNumber * lat;
@property (nonatomic, retain) NSNumber * lon;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * notes;

@end
