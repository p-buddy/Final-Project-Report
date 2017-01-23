//
//  ObservationViewController.h
//  Final-Project-Report
//
//  Created by Parker Malachowsky on 12/12/16.
//  pmalacho@usc.edu
//  Copyright © 2016 Parker Malachowsky. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CompletionHandler)(NSString *name, NSString *situation, NSDate *date);
typedef void(^OnCancel)();

@interface ObservationViewController : UIViewController

//defined by prepare for seque method of TableView Controller
@property (copy, nonatomic) CompletionHandler completionHandler;
//defined by prepare for seque method of TableView Controller

@property (copy, nonatomic) OnCancel onCancelHandler;

//to set text of directions label
@property (nonatomic, strong) NSString *labelText;
//to set the placeholder of the text field
@property (nonatomic, strong) NSString *placeHolderText;

@end
