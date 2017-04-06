
#ifndef EZConstants_h
#define EZConstants_h


#endif /* EZConstants_h */

#define DEBUG_MODE 1

/*
 #if (DEBUG_MODE == 1)
 #define DLog( s, ... ) NSLog( @"[Line %d] %@] %@", __LINE__, __PRETTY_FUNCTION__, , [NSString stringWithFormat:(s), ##__VA_ARGS__] )
 #else
 #define DLog( s, ... )
 #endif
 */

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#define iOS7_0 @"7.0"

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"[Line %d] %s " fmt), __LINE__,__PRETTY_FUNCTION__,  ##__VA_ARGS__)
#else
#   define DLog(...)
#endif
#define METHOD_NAME [NSString stringWithFormat:@"%s", __FUNCTION__]

#define GOOGLE_PLACES_API_KEY @"AIzaSyCPyUURSfhbIJMLqjrMEXXrdi-gSCW1sr0"
#define GOOGLE_MAPS_API_KEY @"AIzaSyBA-ugrz0cL8OzuAFfxqfzRC6zfmG02a7c"

#define APP_USERTYPE @"Consumer" //@"Dispatcher" //@"Consumer"
