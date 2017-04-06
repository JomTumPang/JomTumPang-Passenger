//
//  ShowdaRestClient.h
//  Showda
//
//  Created by Venkat on 19/09/15.
//  Copyright (c) 2015 Venkat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionary+JSON.h"
#import <CocoaLumberjack/CocoaLumberjack.h>

@protocol RestListener <NSObject>

@required
- (void)onResponseRecieved:(NSData *)responseData withURLResponse:response;
- (void)onFailureResponseRecieved:(NSData *)responseData withURLResponse:response;
- (void)onErrorResponseRecieved:(NSError *)error withURLResponse:response;

@end

@interface RestClient : NSObject

@property (nonatomic , weak) id<RestListener> httpResponseDelegate;
@property (nonatomic, weak) id<NSURLSessionDelegate> urlSessionDelete;

- (id)initWithDelegate:(id<RestListener>)httpDelegate;
- (void)dataTaskWithGetURL:(NSString *)requestURL withRequestInfo:(NSDictionary *)requestInfo;
- (void)dataTaskWithPOSTURL:(NSString *)requestURL withRequestInfo:(NSDictionary *)requestInfo;;
- (void)dataTaskWithPOSTURL:(NSString *)requestURL withRequestInfo:(NSDictionary *)requestInfo onSuccess:(void (^)(NSData *responseData, NSURLResponse *response))onSuccess onError:(void (^)(NSError *error))onError;

@end
