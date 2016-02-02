//
//  CoreCategory.m
//  TheSimpliestTODOLIst
//
//  Created by Altaibayar Tseveenbayar on 8/10/14.
//  Copyright (c) 2014 altai. All rights reserved.
//

#import "CoreCategory.h"
#import "CoreTask.h"
#import "../AppDelegate.h"
#import "../AppSettings.h"

#import <QuartzCore/QuartzCore.h>

@implementation CoreCategory

@dynamic color;
@dynamic title;
@dynamic tasks;

- (UIView *) view
{
    UIView *result = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 40, 40)];
    result.layer.cornerRadius = 20;
    result.layer.backgroundColor = [CoreCategory getColor: self.color].CGColor;
        
    return result;
}

+ (UIColor *) getColor: (NSString *) categoryColor
{
    NSString *colorString = [NSString stringWithFormat: @"%@Color", categoryColor];
    SEL selector = NSSelectorFromString(colorString);
    
    if([UIColor respondsToSelector: selector])
    {
        UIColor *uiColor = [UIColor performSelector: selector];
        return uiColor;
    }
    
    return [UIColor blackColor];
}

+ (NSArray *) getAllCategories
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName: @"CoreCategory"
                                              inManagedObjectContext: context];
    [request setEntity: entity];
    
    NSError *error;
    NSArray *result = [context executeFetchRequest: request error: &error];
    
    return error ? nil : result;

}

@end
