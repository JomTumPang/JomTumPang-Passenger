//
//  ShowdaService.m
//  ShowdaDemo
//
//  Created by Venkat on 29/08/15.
//  Copyright (c) 2015 Venkat. All rights reserved.
//

#import "HttpService.h"

@interface HttpService()<NSURLSessionDelegate> {
    NSURLSession *session;
}

@end

@implementation HttpService

+ (NSURLSession *)getSharedDefaultSession
{
    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    });
    return session;
}
- (void) fetchJSONFromURL:(NSURL *) url
{
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil)
            [self.urlDelegate onJSONResponseRecieve:url withData:data withResponse:response];
        else
            [self.urlDelegate onErrorResponseRecieve:url withError:error];
    }];
    [dataTask resume];
}
@end
