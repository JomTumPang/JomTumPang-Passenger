
#import <Foundation/Foundation.h>
#import <CocoaLumberjack/CocoaLumberjack.h>

@protocol HTTPDelegate <NSObject>

@required
- (void) onJSONResponseRecieve:(NSURL *)url withData:(NSData *)data withResponse:(NSURLResponse *)response;
- (void) onErrorResponseRecieve:(NSURL *)url withError:(NSError *)error;

@end

@interface HttpService : NSObject

+ (NSURLSession *)getSharedDefaultSession;

@property (weak) id<HTTPDelegate> urlDelegate;

@end
