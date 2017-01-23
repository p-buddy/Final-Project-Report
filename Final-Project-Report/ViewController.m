//
//  ViewController.m
//  Final-Project-Report
//
//  Created by Parker Malachowsky on 12/10/16.
//  pmalacho@usc.edu
//  Copyright © 2016 Parker Malachowsky. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;

    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//show nav bar
-(void) viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;

}

@end
