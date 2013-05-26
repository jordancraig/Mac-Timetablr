//
//  ExamsData.m
//  Mac Timetablr
//
//  Created by Jordan Craig on 26/05/2013.
//  Copyright (c) 2013 Jordan Craig. All rights reserved.
//

#import "ExamsData.h"

@implementation ExamsData

- (id)initWithTitle:(NSString *)title details:(NSString *)details {
    if((self = [super init])) {
        self.title = title;
        self.details = details;
    }
    return self;
}

@end
