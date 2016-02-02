//
//  LocalNotificationManager.h
//  TheSimpliestTODOLIst
//
//  Created by Altaibayar Tseveenbayar on 8/10/14.
//  Copyright (c) 2014 altai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreTask.h"

@interface LocalNotificationManager : NSObject

+ (LocalNotificationManager *) sharedInstance;

- (void) disableAllNotificaions;
- (void) disableNotification: (CoreTask *) task;
- (void) addNotification: (CoreTask *) task;

@end
