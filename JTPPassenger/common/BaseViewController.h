//
//  BaseViewController.h
//  DentalCare
//
//  Created by Venkat on 06/01/17.
//  Copyright © 2017 Bala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "EZConstants.h"
#import <CocoaLumberjack/CocoaLumberjack.h>


@interface BaseViewController : UIViewController


-(void)showActivityIndicator:(BOOL)show;
-(void) showErrorMessage:(NSDictionary *)responseInfo;
@end
