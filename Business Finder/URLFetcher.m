//
//  URLFetcher.m
//  Business Finder
//
//  Created by Michael Johnson on 8/5/16.
//  Copyright © 2016 Michael Johnson. All rights reserved.
//

#import "URLFetcher.h"

@implementation URLFetcher

+(void)fetchURLContents:(NSString *)URLString completionHandler: (void (^)(NSString *))completionHandler {
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [sharedSession
                                      dataTaskWithURL:[NSURL URLWithString:URLString]
                                      completionHandler:^void (NSData* data, NSURLResponse* response, NSError* error) {
                                          NSString *convertedString;
                                          [NSString stringEncodingForData:data
                                                          encodingOptions:nil
                                                          convertedString:&convertedString
                                                      usedLossyConversion:nil];
                                          
                                          completionHandler(convertedString);
                                      }];
    [dataTask resume];
    return;
}

+(void)fetchURLData:(NSString *)URLString completionHandler: (void (^)(NSData *))completionHandler {
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [sharedSession
                                      dataTaskWithURL:[NSURL URLWithString:URLString]
                                      completionHandler:^void (NSData* data, NSURLResponse* response, NSError* error) {
                                          completionHandler(data);
                                      }];
    [dataTask resume];
    return;
}

+(void)fetchDataForURLString:(NSString *)urlString
           completionHandler:(void (^)(NSData *, NSError *))completionHandler {
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [sharedSession
                                      dataTaskWithURL:[NSURL URLWithString:urlString]
                                      completionHandler:^void (NSData* data, NSURLResponse* response, NSError* error) {
                                          completionHandler(data,error);
                                      }];
    [dataTask resume];
    return;
}

@end
