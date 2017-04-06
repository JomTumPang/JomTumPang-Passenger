/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 Main view controller for the application.
 */

@import UIKit;
@import AVFoundation;
#import <CocoaLumberjack/CocoaLumberjack.h>

@protocol ProfilePicListener <NSObject>

@required
- (void)onProfilePicSelect:(UIImage *)image;
@end

@interface APLViewController : UIViewController

@property (nonatomic , weak) id<ProfilePicListener> profilePicDelegate;

- (IBAction)onProfilePicSelect:(id)sender;
@end
