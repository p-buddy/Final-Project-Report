//
//  WebViewController.m
//  Final-Project-Report
//
//  Created by Parker Malachowsky on 12/10/16.
//  pmalacho@usc.edu
//  Copyright © 2016 Parker Malachowsky. All rights reserved.
//

#import "WebViewController.h"
#import "ILPDFKit.h"

@interface WebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end

@implementation WebViewController

//brings up web view on screen of form pdf
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //open specific form in CA
    NSString *urlString = @"http://ag.ca.gov/childabuse/pdf/ss_8572.pdf";
    NSURL *url = [NSURL URLWithString: urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    [self.webView loadRequest:request];
    
    [self.spinner startAnimating];
    self.webView.hidden = YES;

    self.navigationController.navigationBarHidden = NO;

    // Manually set a form value
    // Save via a static PDF.
}

//opens up share menu for form pdf
- (IBAction)share:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://ag.ca.gov/childabuse/pdf/ss_8572.pdf"]];

    //on share, share specific pdf
    NSString *urlString = @"http://ag.ca.gov/childabuse/pdf/ss_8572.pdf";
    NSURL *url = [NSURL URLWithString: urlString];
    
    NSArray *items = @[url];
    
    // build an activity view controller
    UIActivityViewController *controller = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];
    
    // and present it
    [self presentActivityController:controller];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//brings up activities within share menu
- (void)presentActivityController:(UIActivityViewController *)controller {
    
    // for iPad: make the presentation a Popover
    controller.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:controller animated:YES completion:nil];
    
    //pop controller controls share pop over
    UIPopoverPresentationController *popController = [controller popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popController.barButtonItem = self.navigationItem.leftBarButtonItem;
    
    // access the completion handler
    controller.completionWithItemsHandler = ^(NSString *activityType,
                                              BOOL completed,
                                              NSArray *returnedItems,
                                              NSError *error){
        // react to the completion
        if (completed) {
            
            // user shared an item
            NSLog(@"We used activity type%@", activityType);
            
        } else {
            
            // user cancelled
            NSLog(@"We didn't want to share anything after all.");
        }
        
        if (error) {
            NSLog(@"An Error occured: %@, %@", error.localizedDescription, error.localizedFailureReason);
        }
    };
}

//stops the spinner from spinning pnce app loads
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    self.webView.hidden = NO;
    [self.spinner stopAnimating];
    self.spinner.hidden = YES;
    
}

//dissapears navigation bar to home screen
-(void)viewDidAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;

}

//brings up navigation bar
-(void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
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
