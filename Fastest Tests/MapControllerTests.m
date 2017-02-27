//
//  MapControllerTests.m
//  Business Finder
//
//  Created by Michael Johnson on 2/21/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MapController.h"
#import "MapViewController.h"
#import "OCMock.h"
#import "Business.h"
#import "Model.h"
#import "AppDelegate.h"

@interface MapControllerTests : XCTestCase

@end

@implementation MapControllerTests

- (void)setUp {
    [super setUp];
}

- (void)testConfigureViewController {
    const int testBusinessLatitude = 1.0, testBusinessLongitude = 2.0;
    const int testUserLatitude = 3.0, testUserLongitude = 4.0;
    // Distance (in meters) betweeen the coordinates above
    const double expectedRadius = 313713;
    // Setup
    Model *fakeModel = OCMClassMock([Model class]);
    OCMStub([fakeModel userLatitude]).andReturn(testUserLatitude);
    OCMStub([fakeModel userLongitude]).andReturn(testUserLongitude);

    MapViewController *fakeViewController = OCMClassMock([MapViewController class]);
    MapController *SUT = [[MapController alloc] initWithViewController:fakeViewController
                                              model:fakeModel];
    
    Business *business = [[Business alloc] initWithName:@"Cyberdyne Systems" distance:1.0];
    business.latitude = testBusinessLatitude;
    business.longitude = testBusinessLongitude;
    SUT.business = business;

    // Run
    [SUT configureViewController];
    
    // Verify
    CLLocationCoordinate2D expectedBusinessCoordinate = CLLocationCoordinate2DMake(testBusinessLatitude, testBusinessLongitude);
    OCMVerify([fakeViewController annotateCoordinate:expectedBusinessCoordinate withTitle:business.name]);
    CLLocationCoordinate2D expectedUserCoordinate = CLLocationCoordinate2DMake(testUserLatitude,
                                                                               testUserLongitude);
    
    OCMVerify([fakeViewController zoomToCoordinate:expectedUserCoordinate withRadius:expectedRadius]);
    OCMVerify([fakeViewController displayDirectionsToCoordinate:expectedBusinessCoordinate]);
}

-(void)testModel {
    // Setup
    id fakeViewController = OCMClassMock([MapViewController class]);
    MapController *SUT = [[MapController alloc] initWithViewController:fakeViewController];
    
    // Run
    Model *model = SUT.model;
    
    // Verify
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    XCTAssert(model == [appDelegate model]);
}

@end
