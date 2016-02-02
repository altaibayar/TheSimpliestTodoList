//
//  CoreTask.h
//  TheSimpliestTODOLIst
//
//  Created by Altaibayar Tseveenbayar on 8/10/14.
//  Copyright (c) 2014 altai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CoreCategory;

@interface CoreTask : NSManagedObject

@property (nonatomic, retain) NSDate * deadline;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber *notify;
@property (nonatomic, retain) NSNumber *done;
@property (nonatomic, retain) CoreCategory *category;

+ (NSArray *) getAllTasks;

@end
