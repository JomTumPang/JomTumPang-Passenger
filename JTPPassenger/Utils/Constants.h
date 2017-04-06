//
//  Constants.h
//  DentalCare
//
//  Created by Venkat on 06/01/17.
//  Copyright © 2017 Bala. All rights reserved.
//

#ifndef Constants_h
#define Constants_h


#endif /* Constants_h */


#define DEBUG_MODE 1

#define IS_CUSTOMERAPP 1
/*
 #if (DEBUG_MODE == 1)
 #define DLog( s, ... ) NSLog( @"[Line %d] %@] %@", __LINE__, __PRETTY_FUNCTION__, , [NSString stringWithFormat:(s), ##__VA_ARGS__] )
 #else
 #define DLog( s, ... )
 #endif
 */

//==================================================
#pragma  mark ========= iOS version ================

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#define iOS7_0 @"7.0"

#pragma mark ============= Logs ====================
//==================================================

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"[Line %d] %s " fmt), __LINE__,__PRETTY_FUNCTION__,  ##__VA_ARGS__)
#else
#   define DLog(...)
#endif
#define METHOD_NAME [NSString stringWithFormat:@"%s", __FUNCTION__]

//@"AIzaSyConB4bTqZAHCdV59_g8CWgmSj-r4GCwdI"
//#define GOOGLEMAPS_KEY @"AIzaSyAQoCATbSI9aqoGOTqJmjAtSTIgLoOGZ5w"
//#define GOOGLEMAPS_KEY @"AIzaSyD3c2bHqUlnVsaZgxxQfiP8V3knM2nEbM0"
#define GOOGLEMAPS_KEY @"AIzaSyAQoCATbSI9aqoGOTqJmjAtSTIgLoOGZ5w"
//==================================================
#pragma mark ======== Regular Experssion ===========

#define REG_DOUBLEVALUE @"^(?:|0|[1-9]\\d*)(?:\\.\\d*)?$"
//#define REG_NOTEMPTYSTRING @"^(?:|0|[1-9]\\d*)(?:\\.\\d*)?$"
#define REG_NOTEMPTYSTRING @"[A-Z0-9a-z._%+-]"
#define REG_VALIDEMAIL @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define REG_VALIDPHONE @"[0-9].{9}"
#define REG_MINCHAR_MAXCHAR_TEXT @"[A-Z0-9a-z._%+-].{6,20}"
#define REG_PASSWORDTEXT @"((?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%]).{6,12})"
#define REG_VALIDNUMERIC @"[0-9]+"
#define REG_VALIDALPHABETONLY @"[A-Za-z]+"



#define LAZYLOADINGIMAGESFOLDER @"images"

//==================================================
#pragma mark ========= UIConstants ==================

#define THEAMBACKGROUND_IMAGE [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgimage.png"]]
#define THEAMBACKGROUND_COLOR [UIColor colorWithRed:24/255.0f green:89/255.0f blue:36/255.0f alpha:0.9]
#define LABEL_COLOR [UIColor colorWithRed:24/255.0f green:89/255.0f blue:36/255.0f alpha:0.9]

#define TEXTFIELD_BGCOLOR [UIColor colorWithRed:77/255.0f green:169/255.0f blue:197/255.0f alpha:1.0]
//#define TEXTFIELD_PLACEHOLDER_TEXTCOLOR [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.7]
//#define TEXTFIELD_BORDER_COLOR [UIColor colorWithRed:42/255.0f green:98/255.0f blue:144/255.0f alpha:1.0]
#define TEXTFIELD_BORDER_COLOR [UIColor lightGrayColor]
#define TEXTFIELD_PLACEHOLDER_TEXTCOLOR [UIColor grayColor]

#define BUTTON_COLOR [UIColor colorWithRed:24/255.0f green:89/255.0f blue:36/255.0f alpha:0.9]
#define BUTTONBG_COLOR [UIColor colorWithRed:24/255.0f green:89/255.0f blue:36/255.0f alpha:0.9]
#define BUTTONBG_COLOR [UIColor colorWithRed:24/255.0f green:89/255.0f blue:36/255.0f alpha:0.9]

#define EZ_CORNER_RADIUS 8.0f
#define EZ_BORDER_WIDTH 1.1f

//==================================================
#pragma mark  ======= HTTP URL Constants =============

#define HOSTNAME @"https://ezrider.noip.me:8443/EZRiderJSONWS/api/ezRiderWS" // Dev wirh CRSF deactivated

#define USERREGISTER_URL     [NSString stringWithFormat:@"%@/registerNewUser", EZHOSTNAME]
#define LOGIN_URL            [NSString stringWithFormat:@"%@/userLoginAuthentication", EZHOSTNAME]
#define VERIFYTAC_URL        [NSString stringWithFormat:@"%@/verifyTAC", EZHOSTNAME]
#define GETUSERPROFILE_URL   [NSString stringWithFormat:@"%@/getUserProfileDetails", EZHOSTNAME]
#define UPDATE_USERPROFILE_URL   [NSString stringWithFormat:@"%@/updateUserProfileDetails", EZHOSTNAME]

#define UPDATE_DEVICETOKEN_URL   [NSString stringWithFormat:@"%@/userDeviceTokenUpdate", EZHOSTNAME]
#define UPDATE_USERLOCATION_URL  [NSString stringWithFormat:@"%@/updateUserLocationDetails", EZHOSTNAME]
#define GETUSERPROFILE_PIC_URL [NSString stringWithFormat:@"%@/getUserProfilePicture", EZHOSTNAME]

//==================================================
#pragma mark ====== HTTP Request&Response =======

#define DEFAULT_X_AUTH_TOKEN @"eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhcHBkZXY6MTQ0MjY4NDgxNzY2MTpmYWxzZSJ9.xavibd_9pRpjZB6UrmXkb6pC6okhcWP_XfxopQAv9Ag4qhVPS_X5l24iftPyj4x_e27IgtunVKnEQCzbvFYJYw"


#define TIMEINTERVAL 60000
#define X_CSRF_TOKEN @"X-CSRF-TOKEN"
#define X_AUTH_TOKEN @"X-AUTH-TOKEN"
#define JSESSIONID @"JSESSIONID"
#define CONTENT_LENGTH @"Content-Length"
#define CONTENT_TYPE @"Content-Type"
#define CORRELATIONID @"CorrelationId"
#define AUTHORIZATION @"Authorization"
#define GET_METHOD @"GET"

#define POST_METHOD @"POST"
#define PUT_METHOD @"PUT"

#define RESPONSE_STATUS @"status"
#define RESPONSE_CODE @"code"
#define RESPONSE_ERROR @"errors"
#define RESPONSE_DATA @"data"
#define ACCESS_TOKEN @"accessToken"
#define SERVER_TOKEN @"token"

#define JSON @"json"

#define ISSUEDON @"issuedOn"
#define USER @"user"
#define USERID @"userId"
#define ERRORCODE @"errorCode"
#define ERRORMSG @"errorMsg"

#define EMPTY_STRING @""
#define DENTIST_ID @"dentistid"
#define DENTIST_NAME @"dentistname"
#define NAME @"name"
#define DENTIST_EMAIL @"dentistemail"
#define DENTIST_PHONENO @"dentistphoneno"
#define SPECLZ @"speclz"
#define SPECIALIZATION @"specialization"
#define PHONE @"phone"
#define EMAIL @"email"
#define EXPERIENCE @"exp"
#define LOCATION @"location"
#define ISVERIFIED @"isverified"
#define LONGUITUDE @"longitude"
#define LATTITUDE @"latitude"
#define DISPLAY_PICTURE @"displaypicture"
#define ADDRESS @"address"
