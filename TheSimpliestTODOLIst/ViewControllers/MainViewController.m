//
//  MainViewController.m
//  TheSimpliestTODOLIst
//
//  Created by Altaibayar Tseveenbayar on 8/10/14.
//  Copyright (c) 2014 altai. All rights reserved.
//

#import "MainViewController.h"

//VC
#import "TaskDetailViewController.h"

//CD
#import "../AppDelegate.h"
#import "../ManagedObjects/CoreTask.h"
#import "../ManagedObjects/CoreCategory.h"

@implementation MainViewController
{
    NSMutableArray *tasks;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItems = @[
                                                [[UIBarButtonItem alloc] initWithTitle: @"\u2699"
                                                                                 style: UIBarButtonItemStylePlain
                                                                                target: self
                                                                                action: @selector(settingsClicked:)],
                                                 [[UIBarButtonItem alloc] initWithTitle: @"+"
                                                                                  style: UIBarButtonItemStylePlain
                                                                                 target: self
                                                                                 action: @selector(addTaskClicked:)]
                                                ];
    table.contentOffset = CGPointZero;
    table.contentInset = UIEdgeInsetsZero;
    
    [self reloadTasks];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    
    //[table deselectRowAtIndexPath: [table indexPathForSelectedRow] animated: NO];
    [self reloadTasks];
}

- (void) reloadTasks
{
    tasks = [NSMutableArray arrayWithArray: [CoreTask getAllTasks]];
    [table reloadData];
}

- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
{
    if([segue.identifier isEqualToString: @"task_detail"])
    {
        TaskDetailViewController *detailVC = segue.destinationViewController;
        detailVC.currentTask = sender;
    }
}

- (void) settingsClicked: (id) sender
{
    [self performSegueWithIdentifier: @"settings" sender: self];
}

- (void) addTaskClicked: (id) sender
{
    [self performSegueWithIdentifier: @"task_detail" sender: nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection: (NSInteger) section
{
    return [tasks count];
}

- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath
{
    static NSString *ident = @"TaskCell";
    
    UITableViewCell *result = [tableView dequeueReusableCellWithIdentifier: ident];
    if(!result)
    {
        result = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: ident];
    }
    
    CoreTask *task = [tasks objectAtIndex: indexPath.row];
    
    NSDictionary *titleAttr = @{ };
    if([task.done boolValue])
        titleAttr = @{ NSStrikethroughStyleAttributeName: @2 };
    
    result.textLabel.attributedText = [[NSMutableAttributedString alloc] initWithString: task.title
                                                                             attributes: titleAttr];
    [result.detailTextLabel setText: [task.deadline description]];
    result.accessoryView = [task.category view];
    
    return result;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [table deselectRowAtIndexPath: indexPath animated: NO];
    [self performSegueWithIdentifier: @"task_detail" sender: [tasks objectAtIndex: indexPath.row] ];
}

- (BOOL) tableView: (UITableView *) tableView canEditRowAtIndexPath: (NSIndexPath *) indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle) tableView: (UITableView *) tableView editingStyleForRowAtIndexPath: (NSIndexPath *) indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView: (UITableView *) tableView commitEditingStyle: (UITableViewCellEditingStyle) editingStyle forRowAtIndexPath: (NSIndexPath *) indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        AppDelegate *app = [UIApplication sharedApplication].delegate;
        [app.managedObjectContext deleteObject: [ tasks objectAtIndex: indexPath.row ]];
        [tasks removeObjectAtIndex: indexPath.row];
        
        NSError *error;
        [app.managedObjectContext save: &error];
        
        [tableView deleteRowsAtIndexPaths: @[ indexPath ]
                         withRowAnimation: UITableViewRowAnimationFade];
    }
}

@end
