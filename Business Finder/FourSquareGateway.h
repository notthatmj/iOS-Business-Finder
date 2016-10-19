//
//  FourSquareGateway.h
//  Business Finder
//
//  Created by Michael Johnson on 8/5/16.
//  Copyright © 2016 Michael Johnson. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
@class Business;

@protocol FourSquareGatewayDelegate <NSObject>
-(void)fourSquareGatewayDidFinishGettingBusinesses;
-(void)fourSquareGatewayDidFail;
@end

@interface FourSquareGateway : NSObject
@property (nonatomic, readonly) NSArray<Business *> *businesses;
@property (nonatomic, copy) NSString *clientID;
@property (nonatomic, copy) NSString *clientSecret;
@property (nonatomic, weak) NSObject<FourSquareGatewayDelegate> *delegate;
- (NSString *) searchURLForLatitude:(double) latitude longitude:(double) longitude;
- (NSString *) photosURLForVenueID:(NSString *)id;
-(void)getNearbyBusinessesForLatitude:(double) latitude longitude:(double)longitude;
-(void)downloadPhotoListForVenueID:(NSString *)businessID
                completionHandler:(void (^)(NSArray *photoList))completionHandler;
-(void)downloadPhotoDictForVenueID:(NSString *)businessID
                 completionHandler:(void (^)(NSDictionary *photoDict))completionHandler;
-(UIImage *)downloadFirstPhotoForVenueID:(NSString *)venueID;
-(NSString *) getFirstPhotoURLForVenueID:(NSString *)venueID;
@end

