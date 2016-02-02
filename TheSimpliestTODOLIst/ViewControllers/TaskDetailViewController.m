//
//  TaskDetailViewController.m
//  TheSimpliestTODOLIst
//
//  Created by Altaibayar Tseveenbayar on 8/10/14.
//  Copyright (c) 2014 altai. All rights reserved.
//

#import "TaskDetailViewController.h"

#import "../ManagedObjects/CoreCategory.h"
#import "../ManagedObjects/CoreTask.h"

#import "../LocalNotificationManager.h"
#import "../AppDelegate.h"

@implementation TaskDetailViewController
{
    NSArray *categories;
}

@synthesize currentTask;

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemDone
                                                  target: self
                                                  action: @selector(saveTask:)];
    
    [self setCategories];
    [self setTask];
}

- (void) setCategories
{
    categories = [CoreCategory getAllCategories];
    [pckCategory reloadComponent: 0];
}

- (void) setTask
{
    if(currentTask == nil)
    {
        swDone.hidden = lblDone.hidden = YES;
        swDone.on = NO;
        
        return;
    }
    
    [lblTitle setText: currentTask.title];
    [dtpDue setDate: currentTask.deadline animated: YES];
    [swNotify setOn: [currentTask.notify boolValue] animated: YES];
    [swDone setOn: [currentTask.done boolValue] animated: YES];
    
    NSInteger idx = [categories indexOfObjectIdenticalTo: currentTask.category];
    [pckCategory selectRow: (idx != NSNotFound ? idx : 0) inComponent: 0 animated: YES];

}

- (void) saveTask: (id) sender
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
 
    BOOL isNew = (currentTask == nil);
    
    CoreTask *taskToSave = currentTask == nil ? [NSEntityDescription insertNewObjectForEntityForName: @"CoreTask"
                                                                              inManagedObjectContext: context] : currentTask;
    if(!isNew && [currentTask.notify boolValue])
    {
        [[LocalNotificationManager sharedInstance] disableNotification: currentTask];
    }
    
    taskToSave.title = lblTitle.text;
    taskToSave.deadline = dtpDue.date;
    taskToSave.notify = [NSNumber numberWithBool: swNotify.on];
    taskToSave.done = [NSNumber numberWithBool: swDone.on];
    taskToSave.category = [categories count] == 0 ? nil : [categories objectAtIndex: [pckCategory selectedRowInComponent: 0]];
    
    if(swNotify.on)
    {
        [[LocalNotificationManager sharedInstance] addNotification: currentTask];
    }
    
    /*
    NSArray *colors = @[ @"red", @"green", @"blue", @"yellow", @"black" ];    
    for (int i = 0; i < 5; i ++)
    {
        CoreCategory *category = [NSEntityDescription insertNewObjectForEntityForName: @"CoreCategory"
                                                               inManagedObjectContext: context];
        category.title = [NSString stringWithFormat: @"Category: %d", i];
        category.color = [colors objectAtIndex: i];
        
        for (int j = 0; j < 10; j ++)
        {
            CoreTask *task = [NSEntityDescription insertNewObjectForEntityForName: @"CoreTask"
                                                           inManagedObjectContext: context];
            task.title = [NSString stringWithFormat: @"Task: %d_%d", i, j];
            task.deadline = [NSDate dateWithTimeIntervalSince1970: (i * 1000000) + (j * 123)];
            task.category = category;
        }
    }
    */
    
    NSError *error;
    [context save: &error];
    
    if(error)
    {
        NSLog(@"PROBLEM: %@", error);
    }
    
    [self.navigationController popViewControllerAnimated: YES];
}

#pragma mark - UIPicker

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [categories count];
}

-(NSInteger) numberOfComponentsInPickerView: (UIPickerView *) pickerView
{
    return 1;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    CoreCategory *category = [categories objectAtIndex: row];
    
    UIColor *color = [CoreCategory getColor: category.color];
    NSDictionary *attrDict = @{ NSForegroundColorAttributeName: color };
    
    NSAttributedString *result = [[NSAttributedString alloc] initWithString: category.color
                                                                 attributes: attrDict];
    
    return result;
}

@end
