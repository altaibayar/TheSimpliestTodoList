//
//  SettingsViewController.m
//  TheSimpliestTODOLIst
//
//  Created by Altaibayar Tseveenbayar on 8/10/14.
//  Copyright (c) 2014 altai. All rights reserved.
//

#import "SettingsViewController.h"
#import "../AppSettings.h"
#import "../AppDelegate.h"
#import "../LocalNotificationManager.h"

@implementation SettingsViewController

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
                                                       reuseIdentifier: @""];
        [cell.textLabel setText: @"Categories"];
        [cell setAccessoryType: UITableViewCellAccessoryDisclosureIndicator];
        
        return cell;
    }
    
    else if(indexPath.row == 1)
    {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle
                                                       reuseIdentifier: @"Cell"];
        [cell.textLabel setText: @"Ordered by:"];
        [cell.detailTextLabel setText: ([[AppSettings sharedInstance] sortByDeadline] ? @"Deadline" : @"Title")];

        return cell;
    }
    else
    {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
                                                       reuseIdentifier: @"Cell"];
        [cell.textLabel setAttributedText:
         [[NSAttributedString alloc] initWithString: @"Disable all notifications"
                                         attributes: @{ NSForegroundColorAttributeName : [UIColor redColor] }]];
        [cell.textLabel setTextAlignment: NSTextAlignmentCenter];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        [self performSegueWithIdentifier: @"categories" sender: self];
    }
    else if(indexPath.row == 1)
    {
        BOOL toInvert = [[AppSettings sharedInstance] sortByDeadline];
        [[AppSettings sharedInstance] setSortByDeadline: !toInvert];
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath: indexPath];
        [cell.detailTextLabel setText: (toInvert ? @"Title" : @"Deadline")];

        [tableView reloadData];
    }
    else if(indexPath.row == 2)
    {
        [[LocalNotificationManager sharedInstance] disableAllNotificaions];
        
        NSArray *allTasks = [CoreTask getAllTasks];
        for(CoreTask *task in allTasks)
            task.notify = [NSNumber numberWithBool: NO];
        
        NSError *error;
        NSManagedObjectContext *context = ((AppDelegate *)[UIApplication sharedApplication]).managedObjectContext;
        [context save: &error];
    }
    
    [tableView deselectRowAtIndexPath: indexPath animated: YES];
}


@end
