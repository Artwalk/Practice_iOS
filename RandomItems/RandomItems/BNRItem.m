//
//  BNRItem.m
//  RandomItems
//
//  Created by artwalk on 5/31/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "BNRItem.h"


@implementation BNRItem

+ (instancetype)randomItem {
    NSArray *randomAdjectiveList = @[@"Fluffy", @"Rusty", @"Shiny"];
    
    NSArray *randomNounList = @[@"Bear", @"Spork", @"Mac"];
    
    NSInteger adjectiveIndex = arc4random() % [randomAdjectiveList count];
    NSInteger nounIndex = arc4random() % [randomNounList count];
    
    NSString  *randomName = [NSString stringWithFormat:@"%@ %@", randomAdjectiveList[adjectiveIndex], randomNounList[nounIndex]];
    
    int randomValue = arc4random() % 100;
    
    NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c", '0' + arc4random()%10,
                                    'A' + arc4random() % 26, '0' + arc4random()%10,
                                    'A' + arc4random() % 26, '0' + arc4random()%10];
    BNRItem *newItem = [[self alloc] initWithItemName:randomName valueInDollars:randomValue serialNumber:randomSerialNumber];
    
    return newItem;
}

- (instancetype)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber {
    self = [super init];
    
    if (self) {
        _valueInDollars = value;
        _itemName = name;
        _serialNumber = sNumber;
        _dateCreated = [[NSDate alloc] init];
    }
    
    return self;
}

- (instancetype)initWithItemName:(NSString *)name {
    return [self initWithItemName:name valueInDollars:0 serialNumber:@""];
}


- (instancetype)initWithItemName:(NSString *)name serialNumber:(NSString*)sNumber {
    return [self initWithItemName:name valueInDollars:0 serialNumber:sNumber];
}

- (instancetype)init {
    return [self initWithItemName:@"Item"];
}


- (NSString *)description {
    NSString* descriptionString = [[NSString alloc]initWithFormat:@"%@ %@ (%@) $%d", self.itemName, self.dateCreated, self.serialNumber, self.valueInDollars];
    
    return descriptionString;
}

- (void)dealloc {
    NSLog(@"dealloc %@", self);
}

- (void)setContainedItem:(BNRItem *)containedItem {
    _containedItem = containedItem;
    self.containedItem.container = self;
}

@end
