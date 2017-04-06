/*
 * Copyright (C) 2013 - Cognizant Technology Solutions.
 * This file is a part of OneMobileStudio
 * Licensed under the OneMobileStudio, Cognizant Technology Solutions,
 * Version 1.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *      http://www.cognizant.com/
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#import "NSNumber+JulianDate.h"
#define kUSIDCOUNTERKEY @"keyusidcounter"
#define kUSIDCOUNTER @"keyusid"

@implementation NSNumber(JulianDate)

+(NSNumber *)getJulianTimeStamp
{
    __autoreleasing NSDate *date = [NSDate date ];
    double timeIntervalSince1970 = [date timeIntervalSince1970];
    double timeStampInJulian = (timeIntervalSince1970/86400)+2440587.5;
    __autoreleasing NSNumber *timeStamp =[NSNumber numberWithDouble:timeStampInJulian];
    return timeStamp;
    
}

+(NSNumber *)getTimeStampInMilliSeconds
{
    __autoreleasing NSDate *date = [NSDate date ];
    double timeIntervalSince1970 = [date timeIntervalSince1970];
     // converting to 13 digit number
    timeIntervalSince1970 = timeIntervalSince1970*1000;
    
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSInteger countervalue = 1;
     if([userdefaults dictionaryForKey:kUSIDCOUNTERKEY] != nil) {
        NSDictionary *dict = [userdefaults dictionaryForKey:kUSIDCOUNTERKEY];
        
        countervalue = [dict[kUSIDCOUNTER] integerValue];
        countervalue += 1;
    }
    [userdefaults setObject:@{kUSIDCOUNTER:@(countervalue)} forKey:kUSIDCOUNTERKEY];
    [userdefaults synchronize];
    
    NSString *justintegerpart = [NSString stringWithFormat:@"%.0f", timeIntervalSince1970];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *formatedusid = [numberFormatter numberFromString:justintegerpart];
    long long newTimeValue  =  [formatedusid longLongValue]+(countervalue*10);
    formatedusid = [NSNumber numberWithLongLong:newTimeValue];
    return formatedusid;
}

@end
