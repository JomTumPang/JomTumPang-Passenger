
#import <Foundation/Foundation.h>
#import "EZConstants.h"
#import "Constants.h"


@interface URLRequest : NSObject

- (NSURLRequest *)getNSURLGETRequest:(NSString *)urlString;
- (NSURLRequest *)getNSURLPOSTRequest:(NSString *)urlString;

@end
