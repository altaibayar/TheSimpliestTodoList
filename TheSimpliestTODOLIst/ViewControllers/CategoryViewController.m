//
//  CategoryViewController.m
//  TheSimpliestTODOLIst
//
//  Created by Altaibayar Tseveenbayar on 8/10/14.
//  Copyright (c) 2014 altai. All rights reserved.
//

#import "CategoryViewController.h"

#import "../AppDelegate.h"
#import "../ManagedObjects/CoreCategory.h"

@implementation CategoryViewController
{
    NSMutableArray *categories;
    NSArray *colors;
}

- (void) viewDidLoad
{
    categories = [NSMutableArray arrayWithArray: [CoreCategory getAllCategories]];
    colors = @[ @"black", @"darkGray", @"lightGray", @"gray",
                @"red", @"green", @"blue", @"cyan", @"yellow",
                @"magenta", @"orange", @"purple", @"brown" ];
    
}

- (IBAction)addCategory:(id)sender
{
    if([categories count] < [colors count])
    {
        for(NSString *color in colors)
        {
            NSInteger idx = [categories indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
                CoreCategory *cat = obj;
                
                if([cat.color isEqualToString: color])
                {
                    *stop = YES;
                    return YES;
                }
                
                return NO;
            }];
            
            if(idx == NSNotFound)
            {
                AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
                NSManagedObjectContext *context = appDelegate.managedObjectContext;

                CoreCategory *category = [NSEntityDescription insertNewObjectForEntityForName: @"CoreCategory"
                                                                       inManagedObjectContext:context];
                category.color = color;
                
                
                NSError *error;
                [context save: &error];
                
                [categories addObject: category];
                [self.tableView insertRowsAtIndexPaths: @[ [NSIndexPath indexPathForRow: [categories count] - 1
                                                                              inSection: 0] ]
                                      withRowAnimation: UITableViewRowAnimationFade];
                
                break;
            }
        }
    }
}


- (NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection: (NSInteger) section
{
    return [categories count];
}

- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath
{
    static NSString *ident = @"CELL";
    
    UITableViewCell *result = [tableView dequeueReusableCellWithIdentifier: ident];
    if(result == nil)
    {
        result = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: ident];
    }
    
    CoreCategory *category = [categories objectAtIndex: indexPath.row];
    
    [result.textLabel setAttributedText:
     [[NSAttributedString alloc] initWithString: category.color
                                     attributes: @{ NSForegroundColorAttributeName: [CoreCategory getColor: category.color] }]];
    [result setAccessoryView: [category view]];

    return result;
}

@end
