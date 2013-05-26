//
//  ExamsData.h
//  Mac Timetablr
//
//  Created by Jordan Craig on 26/05/2013.
//  Copyright (c) 2013 Jordan Craig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExamsData : NSObject

@property (strong) NSString *title;
@property (strong) NSString *details;

- (id)initWithTitle:(NSString*)title details:(NSString*)details;

@end
