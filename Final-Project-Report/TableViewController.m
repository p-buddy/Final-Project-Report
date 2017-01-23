//
//  TableViewController.m
//  Final-Project-Report
//
//  Created by Parker Malachowsky on 12/12/16.
//  pmalacho@usc.edu
//  Copyright © 2016 Parker Malachowsky. All rights reserved.
//

#import "TableViewController.h"
#import "Observations.h"
#import "ObservationViewController.h"
#import "ReportViewController.h"

@interface TableViewController ()

@property (nonatomic, strong) Observations *observationModel;


@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //show nav bar
    self.navigationController.navigationBarHidden = NO;

    //create instance of observations model with observations array
    self.observationModel = [Observations sharedModel];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     //self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

//sets up data to be displayed in table view
-(void)viewDidAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    

    //get the index of the last observation added
    NSUInteger lastIndex = [self.observationModel numberOfObservations] - 1;
    
    if([[self.observationModel observations] count] > 0) {
    //get the name of the last observation added
    NSString *name = [[[self.observationModel observations] objectAtIndex:lastIndex] objectForKey:@"name"];
    
    //unused variable, maintained as I might use it in the future to keep track of the for loop with more than 'i'
    NSUInteger toIncrement = 0;
    
    
    //go through each observation in observation array except for last one
    for (int i = 0; i < lastIndex; i++){
        
        //get Dictionary at each index
        NSDictionary *currentDictionary = [[self.observationModel observations] objectAtIndex:i];
        
        //check if there is more than one observation and if the current name matches the name just entered
        if (lastIndex > 0 && [currentDictionary objectForKey:@"name"] == name) {
            
            //define view controller to transition to
            ReportViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"Report"];
            
            //not used currently
            toIncrement ++;
            
            //Throw alert, as there are at least two entries concerning a specific child
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Time to Report?"
                                                                           message:@"You have two reports about the same child, would you like to report it?"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            //if yes, user chooses to report
            //delete specific observations from list, as they are being reported
            //reload the table
            //transition to the report view controller
            UIAlertAction* emergencyAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive
                handler:^(UIAlertAction * action) {
                    //clear entries to be reported
                    [self.observationModel deleteAtIndex:i];
                    [self.observationModel deleteAtIndex:(lastIndex -1)];
                    
                    [self.tableView reloadData];
                    
                    //transition to report
                    [self.navigationController pushViewController:view animated:YES];
                
                }];
            
            //if no do nothing
            UIAlertAction* noAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault
                 handler:^(UIAlertAction * action) {
      
                 }];
            
            //present alert
            [alert addAction:emergencyAction];
            [alert addAction:noAction];
            [self presentViewController:alert animated:YES completion:nil];
            


        } else {
            toIncrement ++;
        }
    }
    
    ///
    }
    
}

-(void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [self.observationModel numberOfObservations];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    // Create a cell
    
    if ([[self.observationModel observations] count] > 0) {
    // Get the quote at index path
    NSDictionary *observationCurrent = [[self.observationModel observations] objectAtIndex:indexPath.row];
    
    // Modify the cell
    //Message presented in each cell
    NSString *toPrint = [NSString stringWithFormat:@"%@ %@ -- %@", [observationCurrent objectForKey:@"name"], [observationCurrent objectForKey:@"date"], [observationCurrent objectForKey:@"situation"]];
    cell.textLabel.text = toPrint;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;
    
    }
    // Return the cell
    return cell;
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    ObservationViewController *ovc = (ObservationViewController *)segue.destinationViewController;
    
    ovc.completionHandler = ^(NSString *name, NSString *situation, NSDate* date){
        
        //from date string
        NSString *dateString = [NSDateFormatter localizedStringFromDate: date
                                                              dateStyle:NSDateFormatterShortStyle
                                                              timeStyle:NSDateFormatterNoStyle];
        
        if (name != nil && date != nil){
            //add observation to table
            [self.observationModel insertWithName:name situation:situation date:dateString];
            [self.tableView reloadData];
            
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    };
    
    ovc.onCancelHandler = ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    
    //directions text
    ovc.labelText = @"Enter the youth's first name, a description of the incident, and date it occured";
    
    ovc.placeHolderText = @"Name";
}


@end
