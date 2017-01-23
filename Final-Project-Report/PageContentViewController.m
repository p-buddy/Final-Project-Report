//
//  PageContentViewController.m
//  Final-Project-Report
//
//  Created by Parker Malachowsky on 12/11/16.
//  pmalacho@usc.edu
//  Copyright © 2016 Parker Malachowsky. All rights reserved.
//

#import "PageContentViewController.h"

@interface PageContentViewController ()

@end

@implementation PageContentViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;

    
    self.titleLabel.text = self.titleText;
    self.titleTitleLabel.text = self.titleTitleText;
    UIImage *image = [UIImage imageNamed: self.imageURL];
    self.titleImage.image = image;


    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
