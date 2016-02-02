//
//  AppSettings.m
//  TheSimpliestTODOLIst
//
//  Created by Altaibayar Tseveenbayar on 8/10/14.
//  Copyright (c) 2014 altai. All rights reserved.
//

#import "AppSettings.h"

@implementation AppSettings

+ (AppSettings *) sharedInstance
{
    static AppSettings *result;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        result = [[AppSettings alloc] init];
    });

    return result;
}

- (BOOL)sortByDeadline
{
    return [[NSUserDefaults standardUserDefaults] boolForKey: @"SortByDeadline"];    
}

-(void)setSortByDeadline:(BOOL)sortByDeadline
{
    [[NSUserDefaults standardUserDefaults] setBool: sortByDeadline forKey: @"SortByDeadline"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
