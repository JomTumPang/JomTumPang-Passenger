

#import <Foundation/Foundation.h>
#import "EZConstants.h"

@protocol HTTPDelegate<NSObject>

- (void) onResonseDataRecieved;
@end

@interface HttpService1 :NSObject

@property (weak) id<HTTPDelegate> urlDelegate;

+ (void)fetchContentsOfURL:(NSURL *)url completion:(void (^)(NSURLResponse *response, NSData *data, NSError *error)) completionHandler;

+ (void)downloadFileAtURL:(NSURL *)url toLocation:(NSURL *)destinationURL completion:(void (^)(NSURL *url, NSError *error)) completionHandler;

@end
