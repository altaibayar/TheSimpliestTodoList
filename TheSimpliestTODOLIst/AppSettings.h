//
//  AppSettings.h
//  TheSimpliestTODOLIst
//
//  Created by Altaibayar Tseveenbayar on 8/10/14.
//  Copyright (c) 2014 altai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppSettings : NSObject

+ (AppSettings *) sharedInstance;

@property BOOL sortByDeadline;

@end
