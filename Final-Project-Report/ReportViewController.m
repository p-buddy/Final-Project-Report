//
//  ReportViewController.m
//  Final-Project-Report
//
//  Created by Parker Malachowsky on 12/11/16.
//  pmalacho@usc.edu
//  Copyright © 2016 Parker Malachowsky. All rights reserved.
//

#import "ReportViewController.h"
#import "ReportData.h"
#import <CoreLocation/CoreLocation.h>
@import Firebase;
@import FirebaseDatabase;



@interface ReportViewController () <CLLocationManagerDelegate>

//Firebase reference
@property (nonatomic, strong) FIRDatabaseReference *ref;

//Location manager
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *location;

//Child Services phone nuber according to user's current location
@property (nonatomic, strong) NSString *phoneNumber;

//user's current city
@property (nonatomic, strong) NSString *city;


@end

/*
This Controller features Fire Base code and core location retrieval coe
I created a Report Model to satisfy the MVC (that functions) but because it seems that the firebase call is asynchronous, sometimes if a user clicked to fast, they could get a head of the Model.
 Therefore the model code is active in the controller, hope that is okay! I feautre the MVC in every other possible location, and simply had to employ this method to ensure an effective app.
*/

@implementation ReportViewController
- (IBAction)onClick:(id)sender {
    UIApplication *application = [UIApplication sharedApplication];
    
    //If user clicks button, call specific local number according to geolocation
    //Based on available phone number information, and for efficiency, this function only currently works for every city in Los Angeles and San Francisco city [ made sense to test since that is the default location of the simulator]
    //Based on data accessed from firebase
    NSString *telExtension = @"tel://";
    NSString *new = [NSString stringWithFormat:@"%@/%@/", telExtension, self.phoneNumber];
    NSURL *URL = [NSURL URLWithString:new];
    [application openURL:URL options:@{} completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"Opened url");
        }
    }];
}

//begins location manager
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    
    //Set up location manager
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest; // accuracy of user's location
    self.locationManager.distanceFilter = 10.0f; // meters
    [self.locationManager requestAlwaysAuthorization]; // display a UIAlertViewController asking the user for permission to ALWAYS fetch their location, even when the app is in background
    [self.locationManager startUpdatingLocation];
    
    // Do any additional setup after loading the view.
    
    //Establish Database Connection
    NSString *strUrl = [NSString stringWithFormat:@"https://foster-care-report.firebaseio.com/"];
    self.ref = [[FIRDatabase database] referenceFromURL:strUrl];
    
    //Initial Alert to check if emergency
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"EMERGENCY?"
                                                                   message:@"Are you or the child in imminent danger?"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    //Action to call police
    UIAlertAction* emergencyAction = [UIAlertAction actionWithTitle:@"Yes, call the police." style:UIAlertActionStyleDestructive
                                                          handler:^(UIAlertAction * action) {
    //Initiates call
    UIApplication *application = [UIApplication sharedApplication];
                                                            
    //Calls "police", currently 411 just in case
    //Non-deprecated openURL syntax
    NSURL *URL = [NSURL URLWithString:@"tel://411"];
        [application openURL:URL options:@{} completionHandler:^(BOOL success) {
            if (success) {
                NSLog(@"Opened url");
            }
        }];

    }];
    
    
    UIAlertAction* noAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
           //If not emergency, then access the according Child Protective Services Hotline based on the user's location
         [[[_ref child:@"Counties"] child:self.city] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
             
             //set phone number with value from Firebase database
             self.phoneNumber = snapshot.value[@"Phone"];
             
             NSLog(@"%@", self.phoneNumber);
            
             // ...
         } withCancelBlock:^(NSError * _Nonnull error) {
        }];
    NSLog(@"he");
     NSLog(@"%@", self.phoneNumber);
    }];
    
    //present alert for getting asked if it is emergency
    [alert addAction:emergencyAction];
    [alert addAction:noAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    
}

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

#pragma mark: - CLLocationManagerDelegate

// Tells you whenever the user location has changed by "distanceFilter" meters
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    //get current user locaton
    CLLocation *latestLocation = [locations lastObject];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:latestLocation
                   completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (error){
             NSLog(@"Geocode failed with error: %@", error);
             return;
         }
         //Get users current city
         CLPlacemark *placemark = [placemarks objectAtIndex:0];
         self.city = placemark.locality;
     }];
    
}



- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    NSLog(@"%s", __FUNCTION__);
}

@end
