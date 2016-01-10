//
//  ViewController.m
//  TestStringComparisonTime
//
//  Created by Marcin Krzych on 04/01/16.
//  Copyright © 2016 Marcin Krzych. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    NSUInteger amountOfRecords;
    NSUInteger stringLength;
    NSUInteger amountOfSearches;

    NSMutableArray* mutableArrayOfIds;
    NSMutableSet* setOfIds;
    
    NSString* testString;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    amountOfRecords = 68496;
    stringLength = 25;
    amountOfSearches = 100;
    
    
    mutableArrayOfIds = [NSMutableArray arrayWithCapacity:amountOfRecords];
    setOfIds = [NSMutableSet setWithCapacity:amountOfRecords];
    
    // set up data
    for (int i=0; i<amountOfRecords; i++) {
        NSString* string = [self randomStringWithLength:stringLength];
        [mutableArrayOfIds addObject:string];
        [setOfIds addObject:string];
    }
    
    testString = [self randomStringWithLength:stringLength];

    NSLog(@"----------------------------");
    NSLog(@"------------- COLLECTIONS CONTAINS OBJECT ---------------");
    
    NSLog(@"Case 1");
    // test of [NSMutableArray containsObject:@"aaaaa"]
    [self executeTestTimeMeasure:@"arrayContainsInStringTest"];

    NSLog(@"----------------------------");
    NSLog(@"Case 2");
    // test of [NSMutableArray containsObject:@"aaaaa"]
    [self executeTestTimeMeasure:@"setContainsInStringTest"];
   
    
}

- (void)didReceiveMemoryWarning {   
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(NSString *)randomStringWithLength: (NSUInteger) len {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((u_int32_t)[letters length])]];
    }
    
    return randomString;
}

- (NSTimeInterval)executeTestTimeMeasure:(NSString*)methodName {
    NSDate* start = [NSDate date];
    
    SEL selector = NSSelectorFromString(methodName);
    IMP imp = [self methodForSelector:selector];
    void (*func)(id, SEL) = (void *)imp;
    
    for (int i=0; i<amountOfSearches; i++) {
        func(self, selector);
    }
    
    NSDate* end = [NSDate date];
    NSTimeInterval executionTime = [end timeIntervalSinceDate:start];
    NSLog(@"%@ execution time: %f", methodName, executionTime);
    
    return executionTime;
}

- (void)arrayContainsInStringTest {
    [mutableArrayOfIds containsObject:testString];
}

- (void)setContainsInStringTest {
    [setOfIds containsObject:testString];
}


@end
