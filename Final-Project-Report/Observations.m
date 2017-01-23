//
//  Observations.m
//  Final-Project-Report
//
//  Created by Parker Malachowsky on 12/12/16.
//  pmalacho@usc.edu
//  Copyright © 2016 Parker Malachowsky. All rights reserved.
//

#import "Observations.h"

//plist stored in Documents holding observations
static NSString const * kObservationsFilename = @"Observations.plist";

@interface Observations()

@property (nonatomic, strong) NSString *filePath;


@end

@implementation Observations

// Initializer
- (instancetype)init{
    
    NSLog(@"%@",[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
    
    self = [super init];
    if (self) {
       
        
        //Get the documents directory path
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        _filePath = [documentsDirectory stringByAppendingPathComponent: [NSString stringWithFormat:@"%@", kObservationsFilename] ];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if (![fileManager fileExistsAtPath: _filePath]) {
            
            _filePath = [documentsDirectory stringByAppendingPathComponent: [NSString stringWithFormat:@"%@", kObservationsFilename] ];
        }
        
        
        
        // get the Document directory and set _filepath
        // _filepath includes the plist
        
        //create observations array with plist from Documents file
        _observations = [NSMutableArray arrayWithContentsOfFile:_filePath];
        
        
        //initializing array if file empty
        if (!_observations) {
            
            _observations = [[NSMutableArray alloc] initWithObjects: nil];
        } else {
            NSLog(@"else");
        }
        
        
    }
    return self;
    
}

+ (instancetype) sharedModel {
    static Observations *_sharedManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[Observations alloc] init];
    });
    
    return _sharedManager;
};

-(void) insertWithName: (NSString *) name
        situation: (NSString *) situation
        date: (NSString *) date {
    NSDictionary *new = [NSDictionary dictionaryWithObjectsAndKeys:name, @"name", situation, @"situation", date, @"date", nil];
    
    //add new observation
    [self.observations addObject:new];
    //write array to file
    [self save];
}

//number of observations
-(NSUInteger)numberOfObservations{
    return self.observations.count;
}

//delete observation dictionary from array at index
-(void)deleteAtIndex:(NSUInteger) index {
    if(self.observations.count > 0){
    [self.observations removeObjectAtIndex:index];
    //write array to file
    [self save];
    }
}

- (void) save {
    [self.observations writeToFile:self.filePath atomically:YES];
}
@end
