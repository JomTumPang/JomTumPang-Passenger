//
//  ShowdaHttpService1.m
//  ShowdaDemo
//
//  Created by Venkat on 29/08/15.
//  Copyright (c) 2015 Venkat. All rights reserved.
//

#import "HttpService1.h"

@implementation HttpService1

+ (NSURLSession *)dataSession
{
    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    });
    return session;
}

+ (void)fetchContentsOfURL:(NSURL *)url completion:(void (^)(NSURLResponse *response, NSData *data, NSError *error)) completionHandler {
    
    NSURLSessionDataTask *dataTask = [[self dataSession] dataTaskWithURL:url completionHandler:
     
     ^(NSData *data, NSURLResponse *response, NSError *error) {
         
         if (completionHandler == nil) return;
         
         if (error) {
             completionHandler(response,nil, error);
             return;
         }
         completionHandler(response, data, nil);
     }];
    
    [dataTask resume];
}

+ (void)downloadFileAtURL:(NSURL *)url toLocation:(NSURL *)destinationURL completion:(void (^)(NSURL *url, NSError *error)) completionHandler {
    
    NSURLSessionDownloadTask *fileDownloadTask = [[self dataSession] downloadTaskWithRequest:[NSURLRequest requestWithURL:url]
                              completionHandler:
     
     ^(NSURL *location, NSURLResponse *response, NSError *error) {
         
         if (completionHandler == nil) return;
         
         if (error) {
             completionHandler(url, error);
             return;
         }
         
         NSError *fileError = nil;
         [[NSFileManager defaultManager] removeItemAtURL:destinationURL error:NULL];
         [[NSFileManager defaultManager] moveItemAtURL:location toURL:destinationURL error:&fileError];
         completionHandler(url, fileError);
     }];
    
    [fileDownloadTask resume];
}
- (void) ontemp
{
    
}
@end
