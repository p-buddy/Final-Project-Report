//
//  PageContentViewController.h
//  Final-Project-Report
//
//  Created by Parker Malachowsky on 12/11/16.
//  pmalacho@usc.edu
//  Copyright © 2016 Parker Malachowsky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController 
@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *titleTitleText;
@property NSString *imageURL;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (weak, nonatomic) IBOutlet UILabel *titleTitleLabel;

@end
