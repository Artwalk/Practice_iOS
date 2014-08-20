//
//  NewsItem.h
//  16.3.BG Fetch
//
//  Created by artwalk on 8/20/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsItem : NSObject

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, copy) NSString *text;

@end
