//
//  AppDelegate.m
//  Mac Timetablr
//
//  Created by Jordan Craig on 26/05/2013.
//  Copyright (c) 2013 Jordan Craig. All rights reserved.
//

#import "AppDelegate.h"
#include "MasterViewController.h"
#import "ExamsDoc.h"

@interface AppDelegate()
@property (nonatomic,strong) IBOutlet MasterViewController *masterViewController;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.masterViewController = [[MasterViewController alloc] initWithNibName:@"MasterViewController" bundle:nil];
    
    //SampleData
    ExamsDoc *exam1 = [[ExamsDoc alloc] initWithTitle:@"English" details:@"Bring notes" thumbImage:nil fullImage:nil];
    ExamsDoc *exam2 = [[ExamsDoc alloc] initWithTitle:@"Maths" details:@"Bring calculator" thumbImage:nil fullImage:nil];
    NSMutableArray *exams = [NSMutableArray arrayWithObjects:exam1,exam2, nil];
    
    self.masterViewController.exams = exams;
    
    
    [self.window.contentView addSubview:self.masterViewController.view];
    self.masterViewController.view.frame = ((NSView*)self.window.contentView).bounds;
}

@end
