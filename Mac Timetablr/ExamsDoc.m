//
//  ExamsDoc.m
//  Mac Timetablr
//
//  Created by Jordan Craig on 26/05/2013.
//  Copyright (c) 2013 Jordan Craig. All rights reserved.
//

#import "ExamsDoc.h"
#import "ExamsData.h"

@implementation ExamsDoc

- (id)initWithTitle:(NSString *)title details:(NSString*)details thumbImage:(NSImage *)thumbImage fullImage:(NSImage *)fullImage {
    if((self = [super init])) {
        self.data = [[ExamsData alloc] initWithTitle:title details:details];
        self.thumbImage = thumbImage;
        self.fullImage = fullImage;
    }
    return self;
}

@end
