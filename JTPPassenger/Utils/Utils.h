
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Utils : NSObject

+(BOOL)isObject:(id)object;
+(NSString *)getString:(id)value;
+(BOOL)isEmptyString:(NSString *)str;

+ (NSString *)encodeToBase64String:(UIImage *)image;
+ (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData;
@end
