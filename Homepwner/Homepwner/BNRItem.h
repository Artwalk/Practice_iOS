//
//  BNRItem.h
//  Homepwner
//
//  Created by artwalk on 6/7/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BNRItem : NSManagedObject

@property (nonatomic, retain) NSString * itemName;
@property (nonatomic, retain) NSString * serialNumber;
@property (nonatomic) int valueInDollars;
@property (nonatomic, retain) NSDate * dateCreated;
@property (nonatomic, retain) NSString * itemKey;
@property (nonatomic, retain) UIImage * thumbnail;
@property (nonatomic, retain) NSData * thumbnailData;
@property (nonatomic) double orderingValue;
@property (nonatomic, retain) NSManagedObject *assetType;

- (void)setThumbnailFromImage:(UIImage *)image;

@end
