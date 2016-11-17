//
//  NearbyBusinessesTableViewController.m
//  Business Finder
//
//  Created by Michael Johnson on 8/1/16.
//  Copyright © 2016 Michael Johnson. All rights reserved.
//

#import "NearbyBusinessesTableViewController.h"
#import "Business.h"
#import "LocationGateway.h"
#import "Controller.h"

@interface NearbyBusinessesTableViewController ()
@end

@implementation NearbyBusinessesTableViewController

-(instancetype)init {
    self = [super init];
    if (self) {
        _loadSemaphore = dispatch_semaphore_create(0);
        dispatch_semaphore_signal(_loadSemaphore);
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _loadSemaphore = dispatch_semaphore_create(0);
        dispatch_semaphore_signal(_loadSemaphore);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.dataSource == nil) {
        self.dataSource = [NearbyBusinessesDataSource new];
    }
    
    if (self.controller == nil) {
        self.controller = [Controller new];
    }

    [self.controller startInitialLoadForNearbyBusinessesTVC:self];
}

-(void)nearbyBusinessesDataSourceDidUpdateLocationAndBusinesses {
    [self.controller nearbyBusinessesDataSourceDidUpdateLocationAndBusinessesForTVC:self];
}

-(void)nearbyBusinessesDataSourceDidFailWithError:(NSError *) error {
    [self.controller endRefreshing];
    NSString *message = [error localizedDescription];
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:nil];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    dispatch_semaphore_signal(self.loadSemaphore);
}

-(void)waitForInitialLoadToComplete {
    dispatch_semaphore_wait(self.loadSemaphore,DISPATCH_TIME_FOREVER);
};
@end
