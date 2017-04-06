//
//  ePhaseRestClient.m
//  ePhase
//
//  Created by Venkat on 19/09/15.
//  Copyright (c) 2015 Venkat. All rights reserved.
//

#import "RestClient.h"
#import "URLRequest.h"
#import "NSNumber+JulianDate.h"

@interface RestClient()<NSURLConnectionDelegate, NSURLSessionDelegate> {
    NSURLSession *session;
    NSArray *trustedHosts;
}

@end

@implementation RestClient

 
- (id)initWithDelegate:(id<RestListener>)httpDelegate
{
    self = [super init];
    if (self) {
        self.httpResponseDelegate = httpDelegate;
        self.urlSessionDelete = self;
    }
    return self;
}
- (void)dataTaskWithGetURL:(NSString *)requestURL withRequestInfo:(NSDictionary *)requestInfo
{
    /*NSURLRequest *claimHistoryURLRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:requestURL]];
    
    NSMutableURLRequest *mutableRequest = [claimHistoryURLRequest mutableCopy];
    
    [mutableRequest addValue:@"efb1274a-e389-4501-87f6-0148435bbe8d" forHTTPHeaderField:@"X-CSRF-TOKEN"];
    [mutableRequest addValue:@"eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbjoxNDQyMjQ3NjI3MTY5OmZhbHNlIn0.XwSOBwUpxw9A7PT0wFtIGKW2yz9NiWVwBvpBRJbhwTxe7_6ujMp-UlI4ER53g5DS0KyRSRqRowFukmCJVklkHQ" forHTTPHeaderField:@"X-AUTH-TOKEN"];
    [mutableRequest addValue:@"6ED28C7B7BBB638825177E33CD25F454" forHTTPHeaderField:@"JSESSIONID"];
    
    claimHistoryURLRequest = [mutableRequest copy];*/
    
    NSURLRequest *urlRequest = [[[URLRequest alloc] init] getNSURLGETRequest:requestURL];
    
    NSURLSessionDataTask *getURLRequestTask = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil)
        {
            NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
            if (statusCode == 200 || statusCode == 201)
                [self.httpResponseDelegate onResponseRecieved:data withURLResponse:response];
            else
                [self.httpResponseDelegate onFailureResponseRecieved:data withURLResponse:response];
        }
        else
            [self.httpResponseDelegate onErrorResponseRecieved:error withURLResponse:response];
    }];
    [getURLRequestTask resume];
}
- (void)dataTaskWithPOSTURL:(NSString *)requestURL withRequestInfo:(NSDictionary *)requestInfo onSuccess:(void (^)(NSData *responseData, NSURLResponse *response))onSuccess onError:(void (^)(NSError *error))onError
{
    NSURLRequest *urlRequest = [[[URLRequest alloc] init] getNSURLPOSTRequest:requestURL];
    
    NSMutableURLRequest *mutableRequest = [urlRequest mutableCopy];
    NSData *postData = [requestInfo toJsonWithOptions:NSJSONWritingPrettyPrinted];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    [mutableRequest setValue:postLength forHTTPHeaderField:CONTENT_LENGTH];
    [mutableRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [mutableRequest setValue:@"application/json" forHTTPHeaderField:CONTENT_TYPE];
    
    [mutableRequest setHTTPBody:postData];
    
    urlRequest = [mutableRequest copy];
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    
    session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:Nil];
    
    NSURLSessionDataTask *sessionPostTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil)
        {
            NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
            if (statusCode == 200 || statusCode == 201)
            {
                onSuccess(data, response);
            }
            else
            {
                onError(error);
//                [self.httpResponseDelegate onFailureResponseRecieved:data withURLResponse:response];
            }
        }
        else
        {
            onError(error);
//            [self.httpResponseDelegate onErrorResponseRecieved:error withURLResponse:response];
        }
    }];
    [sessionPostTask resume];
}
- (void)dataTaskWithPOSTURL:(NSString *)requestURL withRequestInfo:(NSDictionary *)requestInfo
{
    NSURLRequest *urlRequest = [[[URLRequest alloc] init] getNSURLPOSTRequest:requestURL];

    NSMutableURLRequest *mutableRequest = [urlRequest mutableCopy];
    NSData *postData = [requestInfo toJsonWithOptions:NSJSONWritingPrettyPrinted];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    [mutableRequest setValue:postLength forHTTPHeaderField:CONTENT_LENGTH];
    [mutableRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [mutableRequest setValue:@"application/json" forHTTPHeaderField:CONTENT_TYPE];

    [mutableRequest setHTTPBody:postData];
    
    urlRequest = [mutableRequest copy];
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    
    session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:Nil];

    NSURLSessionDataTask *sessionPostTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil)
        {
            NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
            if (statusCode == 200 || statusCode == 201)
                [self.httpResponseDelegate onResponseRecieved:data withURLResponse:response];
            else
                [self.httpResponseDelegate onFailureResponseRecieved:data withURLResponse:response];
        }
        else
            [self.httpResponseDelegate onErrorResponseRecieved:error withURLResponse:response];
    }];
    [sessionPostTask resume];
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    DLog(@"Fuuuu---%s \n %@, \n %@", __FUNCTION__, connection, protectionSpace);
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler
{
    DLog(@"FUN!---%s \n %@, \n %@", __FUNCTION__, challenge, completionHandler);
    /*if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]){
        if([challenge.protectionSpace.host isEqualToString:@"ezrider.noip.me"]){
            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            
            completionHandler(NSURLSessionAuthChallengeUseCredential,credential);
        }
    }
//    completionHandler(NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]);
     */
    // Get remote certificate
    /*SecTrustRef serverTrust = challenge.protectionSpace.serverTrust;
    SecCertificateRef certificate = SecTrustGetCertificateAtIndex(serverTrust, 0);
    
    // Set SSL policies for domain name check
    NSMutableArray *policies = [NSMutableArray array];
    [policies addObject:(__bridge_transfer id)SecPolicyCreateSSL(true, (__bridge CFStringRef)challenge.protectionSpace.host)];
    SecTrustSetPolicies(serverTrust, (__bridge CFArrayRef)policies);
    
    // Evaluate server certificate
    SecTrustResultType result;
    SecTrustEvaluate(serverTrust, &result);
    BOOL certificateIsValid = (result == kSecTrustResultUnspecified || result == kSecTrustResultProceed);
    
    // Get local and remote cert data
    NSData *remoteCertificateData = CFBridgingRelease(SecCertificateCopyData(certificate));
//    NSString *pathToCert = [[NSBundle mainBundle]pathForResource:@"github.com" ofType:@"cer"];
//    NSData *localCertificate = [NSData dataWithContentsOfFile:pathToCert];
    
    // The pinnning check
    if ([challenge.protectionSpace.host isEqualToString:@"ezrider.noip.me"] || ([remoteCertificateData isEqualToData:localCertificate] && certificateIsValid)) {
        NSURLCredential *credential = [NSURLCredential credentialForTrust:serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
    } else {
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, NULL);
    }*/
    
    if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
        // create trust from protection space
        SecTrustRef trustRef;
        int trustCertificateCount = SecTrustGetCertificateCount(challenge.protectionSpace.serverTrust);
        
        NSMutableArray* trustCertificates = [[NSMutableArray alloc] initWithCapacity:trustCertificateCount];
        for (int i = 0; i < trustCertificateCount; i++) {
            SecCertificateRef trustCertificate =  SecTrustGetCertificateAtIndex(challenge.protectionSpace.serverTrust, i);
            [trustCertificates addObject:(__bridge id _Nonnull)(trustCertificate)];
        }
        
        // set evaluation policy
        SecPolicyRef policyRef;
        // set to YES to verify certificate extendedKeyUsage is set to serverAuth
        policyRef = SecPolicyCreateSSL(YES, (CFStringRef) challenge.protectionSpace.host);
        SecTrustCreateWithCertificates((CFArrayRef) trustCertificates, policyRef, &trustRef);

        
        // load known certificates from keychain and set as anchor certificates
        NSMutableDictionary* secItemCopyCertificatesParams = [[NSMutableDictionary alloc] init];
        [secItemCopyCertificatesParams setObject:(id)kSecClassCertificate forKey:(id)kSecClass];
        [secItemCopyCertificatesParams setObject:@"Server_Cert_Label" forKey:(id)kSecAttrLabel];
        [secItemCopyCertificatesParams setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnRef];
        [secItemCopyCertificatesParams setObject:(id)kSecMatchLimitAll forKey:(id)kSecMatchLimit];
        
        CFArrayRef certificates;
        certificates = nil;
        SecItemCopyMatching((CFDictionaryRef) secItemCopyCertificatesParams, (CFTypeRef*) &certificates);
        
//        if (certificates != nil && CFGetTypeID(certificates) == CFArrayGetTypeID()) {
//            SecTrustSetAnchorCertificates(trustRef, certificates);
//            SecTrustSetAnchorCertificatesOnly(trustRef, NO);
//        } else {
//            // set empty array as own anchor certificate so system anchos certificates are used too!
//            SecTrustSetAnchorCertificates(trustRef, (CFArrayRef) certificates);
//            SecTrustSetAnchorCertificatesOnly(trustRef, NO);
//        }
        
        
        
        
        OSStatus status = SecTrustSetAnchorCertificates(trustRef, certificates);
        
        
        SecTrustResultType result;
        OSStatus trustEvalStatus = SecTrustEvaluate(trustRef, &result);
        if (trustEvalStatus == errSecSuccess) {
            if (result == kSecTrustResultConfirm || result == kSecTrustResultProceed || result == kSecTrustResultUnspecified) {
                // evaluation OK
                [challenge.sender useCredential:[NSURLCredential credentialForTrust: challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
                NSURLCredential *credential = [NSURLCredential credentialForTrust:trustRef];
                completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
            }
            else {
                // evaluation failed
                // ask user to add certificate to keychain
                NSURLCredential *credential = [NSURLCredential credentialForTrust:trustRef];
                completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
            }
        } 
        else {
            // evaluation failed - cancel authentication
            [[challenge sender] cancelAuthenticationChallenge:challenge];
        }
    }
}
/*- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
        if ([trustedHosts containsObject:challenge.protectionSpace.host])
            [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}
*/
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge1:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler
{
    DLog(@"%s \n %@, \n %@", __FUNCTION__, challenge, completionHandler);
    completionHandler(NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]);
}

@end
