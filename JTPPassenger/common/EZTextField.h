//
//  DCTextField.h
//  DentalCare
//
//  Created by Venkat on 21/02/16.
//  Copyright © 2016 Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CocoaLumberjack/CocoaLumberjack.h>

@interface EZTextField : UITextField

- (BOOL)validateTextWithRegularExpression:(NSString *)regExpression;
-(BOOL)isEmptyTextCheck;
- (void)changeBorderColor:(BOOL)isValid;
@end
