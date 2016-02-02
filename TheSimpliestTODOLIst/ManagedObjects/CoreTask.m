//
//  CoreTask.m
//  TheSimpliestTODOLIst
//
//  Created by Altaibayar Tseveenbayar on 8/10/14.
//  Copyright (c) 2014 altai. All rights reserved.
//

#import "CoreTask.h"
#import "CoreCategory.h"
#import "../AppDelegate.h"
#import "../AppSettings.h"

@implementation CoreTask

@dynamic deadline;
@dynamic title;
@dynamic category;
@dynamic notify;
@dynamic done;

+ (NSArray *) getAllTasks
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName: @"CoreTask"
                                              inManagedObjectContext: context];
    [request setEntity: entity];
    
    NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc] initWithKey: ([[AppSettings sharedInstance] sortByDeadline] ? @"deadline" : @"title")
                                                             ascending: YES
                                                              selector: @selector(localizedCaseInsensitiveCompare:)];
    
    [request setSortDescriptors: @[ sortDesc ]];
    
    NSError *error;
    NSArray *result = [context executeFetchRequest: request error: &error];
    
    return error ? nil : result;
}


@end
