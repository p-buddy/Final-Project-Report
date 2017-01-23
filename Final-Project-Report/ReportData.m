//
//  ReportData.m
//  Final-Project-Report
//
//  Created by Parker Malachowsky on 12/11/16.
//  pmalacho@usc.edu
//  Copyright © 2016 Parker Malachowsky. All rights reserved.
//

#import "ReportData.h"
#import <CoreLocation/CoreLocation.h>
@import Firebase;
@import FirebaseDatabase;



@interface ReportData() <CLLocationManagerDelegate>

//ref to database storing child protective service phone numbers attatched to the cities/counties they serve
@property (nonatomic, strong) FIRDatabaseReference *ref;

//to get the users location to determine their local CPS to contact
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *location;


@end

@implementation ReportData
// Initializer
- (instancetype)init{
    
    self = [super init];
    if (self) {
        
        
        //Establish Database Connection
        NSString *strUrl = [NSString stringWithFormat:@"https://foster-care-report.firebaseio.com/"];
        self.ref = [[FIRDatabase database] referenceFromURL:strUrl];
        
        //Set up location manager
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest; // accuracy of user's location
        self.locationManager.distanceFilter = 10.0f; // meters
        [self.locationManager requestAlwaysAuthorization]; // display a UIAlertViewController asking the user for permission to ALWAYS fetch their location, even when the app is in background
        [self.locationManager startUpdatingLocation];
        
    }
    return self;
        
    }

+ (instancetype) sharedModel {
    static ReportData *_sharedManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[ReportData alloc] init];
    });
    
    return _sharedManager;
};

//retrieve the phone number from the firebase database of the user's current location
-(NSString *)getPhoneNumber:(NSString *) currentCounty {
    
    
    
    NSString* city = currentCounty;
    
    //get phone number at location of josn tree of current city/county
    __block NSString* phone = @"";
    [[[_ref child:@"Counties"] child:city] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        //NSLog(@"Helllllo");
        self.phoneNumber = snapshot.value[@"Phone"];
        NSLog(@"%@", self.phoneNumber);
        phone = snapshot.value[@"Phone"];
        
        NSLog(@"%@", phone);
        // ...
    } withCancelBlock:^(NSError * _Nonnull error) {
    }];
    
    NSLog(@"hello");
    NSLog(@"%@", phone);
    return self.phoneNumber;
}

#pragma mark: - CLLocationManagerDelegate

// Tells you whenever the user location has changed by "distanceFilter" meters
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    CLLocation *latestLocation = [locations lastObject];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:latestLocation
                   completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (error){
             NSLog(@"Geocode failed with error: %@", error);
             return;
         }
         CLPlacemark *placemark = [placemarks objectAtIndex:0];
         //get name of current city
         self.city = placemark.locality;
     }];
    
}



- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    NSLog(@"%s", __FUNCTION__);
}


@end
