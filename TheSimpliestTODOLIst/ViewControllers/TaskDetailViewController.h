//
//  TaskDetailViewController.h
//  TheSimpliestTODOLIst
//
//  Created by Altaibayar Tseveenbayar on 8/10/14.
//  Copyright (c) 2014 altai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../ManagedObjects/CoreTask.h"

@interface TaskDetailViewController : UIViewController < UIPickerViewDataSource, UIPickerViewDelegate >
{
    __weak IBOutlet UITextField *lblTitle;
    __weak IBOutlet UIDatePicker *dtpDue;
    __weak IBOutlet UISwitch *swNotify;
    __weak IBOutlet UISwitch *swDone;
    __weak IBOutlet UILabel *lblDone;
    __weak IBOutlet UIPickerView *pckCategory;
}

@property (atomic, strong) CoreTask *currentTask;

@end
