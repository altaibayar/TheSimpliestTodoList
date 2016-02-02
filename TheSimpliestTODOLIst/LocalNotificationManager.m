//
//  LocalNotificationManager.m
//  TheSimpliestTODOLIst
//
//  Created by Altaibayar Tseveenbayar on 8/10/14.
//  Copyright (c) 2014 altai. All rights reserved.
//

#import "LocalNotificationManager.h"

@implementation LocalNotificationManager

+ (LocalNotificationManager *) sharedInstance
{
    static LocalNotificationManager *result;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        result = [[LocalNotificationManager alloc] init];
    });
    
    return result;
}

- (void) disableAllNotificaions
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

- (void) disableNotification: (CoreTask *) task
{
    NSArray *notifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    
    [notifications enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        UILocalNotification *notification = obj;
        if([notification.fireDate isEqualToDate: task.deadline] &&
           [notification.alertBody isEqualToString: task.title])
        {
            [[UIApplication sharedApplication] cancelLocalNotification: notification];
            *stop = YES;
        }
    }];

}

- (void) addNotification: (CoreTask *) task
{
    UILocalNotification *notification = [[UILocalNotification alloc] init];

    notification.fireDate = task.deadline;
    notification.alertBody = task.title;
    notification.timeZone = [NSTimeZone defaultTimeZone];
    
    [[UIApplication sharedApplication] scheduleLocalNotification: notification];
}



@end
