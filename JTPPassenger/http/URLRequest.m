//
//  ShowdaURLRequest.m
//  Showda
//
//  Created by Venkat on 19/09/15.
//  Copyright (c) 2015 Venkat. All rights reserved.
//

#import "URLRequest.h"
#import "NSNumber+JulianDate.h"



@implementation URLRequest

- (NSURLRequest *)getNSURLGETRequest:(NSString *)urlString
{
    NSMutableURLRequest *mutableRequest = [[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:TIMEINTERVAL] mutableCopy];
    
    
    NSUserDefaults  *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *csrfToken     = [userDefault stringForKey:X_CSRF_TOKEN];
    NSString *xAuthToken    = [userDefault stringForKey:X_AUTH_TOKEN];
    NSString *jsessionId    = [userDefault stringForKey:JSESSIONID];

    if (xAuthToken != nil)
        xAuthToken = DEFAULT_X_AUTH_TOKEN;
    
    [mutableRequest addValue:csrfToken forHTTPHeaderField:X_CSRF_TOKEN];
    [mutableRequest addValue:xAuthToken forHTTPHeaderField:X_AUTH_TOKEN];
    [mutableRequest addValue:jsessionId forHTTPHeaderField:JSESSIONID];
    [mutableRequest addValue:[[NSNumber getTimeStampInMilliSeconds] description] forHTTPHeaderField:CORRELATIONID];
    [mutableRequest setHTTPMethod:GET_METHOD];
    
    
    return [mutableRequest copy];
}
- (NSURLRequest *)getNSURLPOSTRequest:(NSString *)urlString
{
    NSUserDefaults  *userDefault = [NSUserDefaults standardUserDefaults];
//    NSString *csrfToken = [userDefault stringForKey:X_CSRF_TOKEN];
    
      NSMutableURLRequest *mutableRequest = [[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]] mutableCopy];
//    NSMutableURLRequest *mutableRequest = [[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:TIMEINTERVAL] mutableCopy];
    
    [mutableRequest addValue:[userDefault stringForKey:X_CSRF_TOKEN] forHTTPHeaderField:X_CSRF_TOKEN];
    [mutableRequest addValue:[userDefault stringForKey:X_AUTH_TOKEN] forHTTPHeaderField:X_AUTH_TOKEN];
    [mutableRequest addValue:[userDefault stringForKey:X_AUTH_TOKEN] forHTTPHeaderField:JSESSIONID];
//    [mutableRequest addValue:@"gzip, deflate" forHTTPHeaderField:@"accept-encoding"];
    [mutableRequest addValue:@"en-US,en;q=0.8" forHTTPHeaderField:@"accept-language"];
//    [mutableRequest addValue:@"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.71 Safari/537.36" forHTTPHeaderField:@"user-agent"];
    [mutableRequest addValue:[[NSNumber getTimeStampInMilliSeconds] description] forHTTPHeaderField:CORRELATIONID];
    [mutableRequest setHTTPMethod:POST_METHOD];
    
    
    return [mutableRequest copy];
}
@end
