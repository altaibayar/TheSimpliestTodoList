//
//  CoreCategory.h
//  TheSimpliestTODOLIst
//
//  Created by Altaibayar Tseveenbayar on 8/10/14.
//  Copyright (c) 2014 altai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CoreTask;

@interface CoreCategory : NSManagedObject

@property (nonatomic, retain) NSString * color;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *tasks;

- (UIView *) view;
+ (NSArray *) getAllCategories;
+ (UIColor *) getColor: (NSString *) categoryColor;

@end

@interface CoreCategory (CoreDataGeneratedAccessors)

- (void)addTasksObject:(CoreTask *)value;
- (void)removeTasksObject:(CoreTask *)value;
- (void)addTasks:(NSSet *)values;
- (void)removeTasks:(NSSet *)values;

@end
