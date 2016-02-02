//
//  MainViewController.h
//  TheSimpliestTODOLIst
//
//  Created by Altaibayar Tseveenbayar on 8/10/14.
//  Copyright (c) 2014 altai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController < UITableViewDataSource, UITableViewDelegate >
{
    __weak IBOutlet UITableView *table;
}

@end
