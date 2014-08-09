//
//  main.m
//  RandomItems
//
//  Created by artwalk on 5/31/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRItem.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSMutableArray *items = [[NSMutableArray alloc]init];
//
//        [items addObject:@"one"];
//        [items addObject:@"two"];
//        
//        
//        [items insertObject:@"zero" atIndex:0];
//        
//        for (NSString *item in items) {
//            NSLog(@"%@", item);
//        }
//        
        
//        for (int i = 0; i < 10; ++i) {
//            BNRItem *item = [BNRItem randomItem];
//            [items addObject:item];
//        }
        
        BNRItem *backpack = [[BNRItem alloc] initWithItemName:@"Backpack"];
        [items addObject:backpack];
        
        BNRItem *calculator = [[BNRItem alloc] initWithItemName:@"Calculator"];
        [items addObject:calculator];
        
        backpack.containedItem = calculator;
//        NSLog(@"backpack: container %@; containedItem %@", backpack.container ,backpack.containedItem);
//        
//        NSLog(@"calculator: container %@; containedItem %@", calculator.container ,calculator.containedItem);
//        calculator.containedItem = backpack;
//        NSLog(@"backpack: container %@; containedItem %@", backpack.container ,backpack.containedItem);
//        
//        NSLog(@"calculator: container %@; containedItem %@", calculator.container ,calculator.containedItem);
        
        backpack = nil;
        calculator = nil;
        
        
        for (BNRItem *item in items) {
            NSLog(@"%@", item);
        }
//        NSLog(@"%@", items[10]);
        
        NSLog(@"items = nil");
        items = nil;
        
        
    }
    
    return 0;
}

