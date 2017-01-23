//
//  ReportData.h
//  Final-Project-Report
//
//  Created by Parker Malachowsky on 12/11/16.
//  pmalacho@usc.edu
//  Copyright © 2016 Parker Malachowsky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReportData : NSObject

@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *city;

+ (instancetype) sharedModel;
- (void) establishDataBaseConnection;
-(NSString *)getPhoneNumber:(NSString *) currentCounty;


@end
