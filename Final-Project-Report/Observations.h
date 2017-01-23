//
//  Observations.h
//  Final-Project-Report
//
//  Created by Parker Malachowsky on 12/12/16.
//  pmalacho@usc.edu
//  Copyright © 2016 Parker Malachowsky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Observations : NSObject

//holds all user generated observations
@property (nonatomic, strong) NSMutableArray *observations;

+ (instancetype) sharedModel;

//add new observation
//write to file
-(void) insertWithName: (NSString *) name
             situation: (NSString *) situation
                  date: (NSString *) date;
//number of observations
-(NSUInteger) numberOfObservations;

//delete observation
//write to file
-(void)deleteAtIndex:(NSUInteger) index;
@end
