//
//  LearningData.m
//  Final-Project-Report
//
//  Created by Parker Malachowsky on 12/12/16.
//  pmalacho@usc.edu
//  Copyright © 2016 Parker Malachowsky. All rights reserved.
//

#import "LearningData.h"

@implementation LearningData
// Initializer
- (instancetype)init{
    
    self = [super init];
    if (self) {
        //Get information about types of indications of foster care abuse/neglect from Indicators.plist
        //path to Indicators.plist
        NSString *pathAndFileName = [[NSBundle mainBundle] pathForResource:@"Indicators" ofType:@"plist"];
        
        //fill page information with Array from Indicators.plist
        _pageInformation = [[NSArray alloc] initWithContentsOfFile:pathAndFileName];
    }
    return self;
}

//shared model
+ (instancetype) sharedModel {
    static LearningData *_sharedManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[LearningData alloc] init];
    });
    
    return _sharedManager;
};

@end
