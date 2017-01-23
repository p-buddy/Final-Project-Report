//
//  PageViewController.h
//  Final-Project-Report
//
//  Created by Parker Malachowsky on 12/11/16.
//  pmalacho@usc.edu
//  Copyright © 2016 Parker Malachowsky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LearningData.h"

@interface PageViewController : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageData;



@end
