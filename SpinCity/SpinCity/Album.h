//
//  Album.h
//  SpinCity
//
//  Created by artwalk on 5/21/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Album : NSObject 

@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* artist;
@property (nonatomic, copy) NSString* summary;
@property (nonatomic, copy) NSString* locationInStore;

@property (nonatomic, assign) float price;

-(id)initWithTitle:(NSString*)title artist:(NSString*)artist summary:(NSString*)summary price:(float)price locationInStore:(NSString*)locationInStore;
@end
