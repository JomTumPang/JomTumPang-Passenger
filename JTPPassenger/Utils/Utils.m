//
//  ShowdaUtils.m
//  ShowdaDemo
//
//  Created by Venkat on 08/10/15.
//  Copyright (c) 2015 Venkat. All rights reserved.
//

#import "Utils.h"


@implementation Utils


+(BOOL)isObject:(id)object
{
    return !(object == nil || object == Nil|| [object isKindOfClass:[NSNull class]]);
}
+(NSString *)getString:(id)value
{
    if([value isKindOfClass:[NSString class]])
        return value;
    return nil;
}
+(BOOL)isEmptyString:(NSString *)str
{
    return [str length]> 0?TRUE:FALSE;
}
+ (NSString *)encodeToBase64String:(UIImage *)image {
    
    NSData *data = UIImagePNGRepresentation(image);
    
    return [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];

//    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}
+ (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
//    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
//    return [UIImage imageWithData:data];
    
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    return [UIImage imageWithData:data];

}
@end
