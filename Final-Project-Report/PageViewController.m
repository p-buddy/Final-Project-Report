//
//  PageViewController.m
//  Final-Project-Report
//
//  Created by Parker Malachowsky on 12/11/16.
//  pmalacho@usc.edu
//  Copyright © 2016 Parker Malachowsky. All rights reserved.
//

#import "PageViewController.h"
#import "PageContentViewController.h"


@interface PageViewController ()

@end

@implementation PageViewController

//draws page view
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor greenColor];

    // Create the data model
    _pageData = [NSArray arrayWithArray:[[LearningData sharedModel] pageInformation]];
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//begins walkthrough
- (IBAction)startWalkthrough:(id)sender {
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
}

//moves data along
- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageData count] == 0) || (index >= [self.pageData count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.titleText = [self.pageData[index] objectForKey:@"Details"];
    pageContentViewController.titleTitleText = [self.pageData[index] objectForKey:@"Title"];
    pageContentViewController.imageURL = [self.pageData[index] objectForKey:@"Image"];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}

#pragma mark - Page View Controller Data Source

//moves page back as decreases
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

//moves through page increasing index
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageData count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

//move up count of page as swipe
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageData count];
}

//gets  index of base page
- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

-(void)viewDidAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    
}

-(void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
}

@end

