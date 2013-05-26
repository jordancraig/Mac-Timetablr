//
//  ExamsDoc.h
//  Mac Timetablr
//
//  Created by Jordan Craig on 26/05/2013.
//  Copyright (c) 2013 Jordan Craig. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ExamsData;

@interface ExamsDoc : NSObject

@property (strong) ExamsData *data;
@property (strong) NSImage *thumbImage;
@property (strong) NSImage *fullImage;

- (id)initWithTitle:(NSString*)title details:(NSString*)details thumbImage:(NSImage*)thumbImage fullImage:(NSImage*)fullImage;

@end
