//
//  LearningData.h
//  Final-Project-Report
//
//  Created by Parker Malachowsky on 12/12/16.
//  pmalacho@usc.edu
//  Copyright © 2016 Parker Malachowsky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LearningData : NSObject

@property (strong, nonatomic) NSArray *pageInformation;


+ (instancetype) sharedModel;


@end
