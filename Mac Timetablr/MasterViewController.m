//
//  MasterViewController.m
//  Mac Timetablr
//
//  Created by Jordan Craig on 26/05/2013.
//  Copyright (c) 2013 Jordan Craig. All rights reserved.
//

#import "MasterViewController.h"
#import <Quartz/Quartz.h>
#import "NSImage+Extras.h"
#import "ExamsDoc.h"
#import "ExamsData.h"

@interface MasterViewController ()
@property (weak) IBOutlet NSTableView *examsTableView;
@property (weak) IBOutlet NSTextField *examTitleView;
@property (weak) IBOutlet NSTextField *examDetailsView;
@property (weak) IBOutlet NSImageView *examImageView;

@end

@implementation MasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (NSView*) tableView:(NSTableView*)tableView viewForTableColumn:(NSTableColumn*)tableColumn row:(NSInteger)row {
    
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    if( [tableColumn.identifier isEqualToString:@"ExamColumn"] ) {
        ExamsDoc *examDoc = [self.exams objectAtIndex:row];
        cellView.imageView.image = examDoc.thumbImage;
        cellView.textField.stringValue = examDoc.data.title;
    }
    return cellView;
}

- (void) loadView {
    [super loadView];
}

-(ExamsDoc*)selectedExamDoc {
    NSInteger selectedRow = [self.examsTableView selectedRow];
    if( selectedRow >=0 && self.exams.count > selectedRow ) {
        ExamsDoc *selectedExam = [self.exams objectAtIndex:selectedRow];
        return selectedExam;
    }
    return nil;
}

-(void)setDetailInfo:(ExamsDoc*)doc {
    NSString    *title = @"";
    //NSImage     *image = nil;
    NSString    *details = @"";
    if( doc != nil ){
        title = doc.data.title;
        //image = doc.fullImage;
        details = doc.data.details;
    }
    [self.examTitleView setStringValue:title];
    [self.examDetailsView setStringValue:details];
    //[self.examImageView setImage:image];
    
}

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification {
    ExamsDoc *selectedDoc = [self selectedExamDoc];
    
    //Update info
    [self setDetailInfo:selectedDoc];
}

-(NSInteger)numberOfRowsInTableView:(NSTableView*)tableView {
    return [self.exams count];
}


- (IBAction)examTitleDidEndEdit:(id)sender {
    ExamsDoc *selectedDoc = [self selectedExamDoc];
    if(selectedDoc) {
        selectedDoc.data.title = [self.examTitleView stringValue];
        NSIndexSet * indexSet = [NSIndexSet indexSetWithIndex:[self.exams indexOfObject:selectedDoc]];
        NSIndexSet * columnSet = [NSIndexSet indexSetWithIndex:0];
        [self.examsTableView reloadDataForRowIndexes:indexSet columnIndexes:columnSet];
    }
}

- (IBAction)examDetailsDidEndEdit:(id)sender {
    ExamsDoc *selectedDoc = [self selectedExamDoc];
    if(selectedDoc) {
        selectedDoc.data.details = [self.examDetailsView stringValue];
        NSIndexSet * indexSet = [NSIndexSet indexSetWithIndex:[self.exams indexOfObject:selectedDoc]];
        NSIndexSet * columnSet = [NSIndexSet indexSetWithIndex:0];
        [self.examsTableView reloadDataForRowIndexes:indexSet columnIndexes:columnSet];
    }
}


- (IBAction)changePicture:(id)sender {
    ExamsDoc *selectedDoc = [self selectedExamDoc];
    if( selectedDoc )
    {
        [[IKPictureTaker pictureTaker] beginPictureTakerSheetForWindow:self.view.window withDelegate:self didEndSelector:@selector(pictureTakerDidEnd:returnCode:contextInfo:) contextInfo:nil];
    }
}

- (void) pictureTakerDidEnd:(IKPictureTaker *) picker
                 returnCode:(NSInteger) code
                contextInfo:(void*) contextInfo
{
    NSImage *image = [picker outputImage];
    if( image !=nil && (code == NSOKButton) )
    {
        [self.examImageView setImage:image];
        ExamsDoc * selectedExamDoc = [self selectedExamDoc];
        if( selectedExamDoc )
        {
            selectedExamDoc.fullImage = image;
            selectedExamDoc.thumbImage = [image imageByScalingAndCroppingForSize:CGSizeMake( 44, 44 )];
            NSIndexSet * indexSet = [NSIndexSet indexSetWithIndex:[self.exams indexOfObject:selectedExamDoc]];
            
            NSIndexSet * columnSet = [NSIndexSet indexSetWithIndex:0];
            [self.examsTableView reloadDataForRowIndexes:indexSet columnIndexes:columnSet];
        }
    }
}


- (IBAction)addExam:(id)sender {
    ExamsDoc *newExam = [[ExamsDoc alloc] initWithTitle:@"New Exam" details:@"New Details" thumbImage:nil fullImage:nil];
    [self.exams addObject:newExam];
    NSInteger newRowIndex = self.exams.count-1;
    
    [self.examsTableView insertRowsAtIndexes:[NSIndexSet indexSetWithIndex:newRowIndex] withAnimation:NSTableViewAnimationEffectGap];
[self.examsTableView selectRowIndexes:[NSIndexSet indexSetWithIndex:newRowIndex] byExtendingSelection:NO];
    [self.examsTableView scrollRowToVisible:newRowIndex];
}

- (IBAction)deleteExam:(id)sender {
    ExamsDoc *selectedDoc = [self selectedExamDoc];
    if (selectedDoc) {
        [self.exams removeObject:selectedDoc];
        [self.examsTableView removeRowsAtIndexes:[NSIndexSet indexSetWithIndex:self.examsTableView.selectedRow] withAnimation:NSTableViewAnimationSlideRight];
    }
}


@end
