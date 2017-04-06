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

#import "NSString+TimeInMilliSeconds.h"
#define kUSIDCOUNTERKEY @"keyusidcounter"
#define kUSIDCOUNTER @"keyusid"
@implementation NSString (TimeInMilliSeconds)

+(NSString *)getTimeStampInMilliSeconds
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
    return [NSString stringWithFormat:@"%@",formatedusid];
}

+(NSString *)getJulianDateForModifiedDateColumn {
    double unixdate_ = [[NSDate date] timeIntervalSince1970];
    double juliandate_ = ((double)(unixdate_)/86400.0)+(2440587.5);
    NSString *julianDateString = [NSString stringWithFormat:@"%f", (juliandate_)];
    return julianDateString;
}

+(NSString *)getJulianDateForSpecificDate {
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]  init];
    [dateformatter setDateStyle:NSDateFormatterMediumStyle];
    NSDate *distantdate = [dateformatter dateFromString:@"Sep 12, 2050"];
    
    double unixdate_ = [distantdate timeIntervalSince1970];
    double juliandate_ = ((double)(unixdate_)/86400.0)+(2440587.5);
    NSString *julianDateString = [NSString stringWithFormat:@"%f", (juliandate_)];
    return julianDateString;
}

+(NSString *)getHumanReadableDate
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setLocale:posix];
    [formatter setDateFormat:@"MMM-dd-yyyy HH:MM"];
    // Date to string
    NSDate *currentDate = [NSDate date];
    NSString *prettyDate = [formatter stringFromDate:currentDate];
    NSLog(@"prettyDate  %@", prettyDate);
    return prettyDate;
}

-(NSString *)getHumanReadableDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setLocale:posix];
    // Date to string
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *currentDate = [formatter dateFromString:self];
    [formatter setDateFormat:@"dd MMM yyyy"];
    
    NSString *prettyDate = [formatter stringFromDate:currentDate];
    NSLog(@"prettyDate  %@", prettyDate);
    return prettyDate;
    
    
    
    
}

@end
