//
//  SlidingmenuViewController.h
//  JomTumpang
//
//  Created by Venkat on 09/01/17.
//  Copyright © 2017 ezrider. All rights reserved.
//

#import "BaseViewController.h"

@interface SlidingmenuViewController : BaseViewController

- (id)initWithViewControllers:(NSArray *)viewControllers andMenuTitles:(NSArray *)titles; // (2)


- (void)toggleMenuVisibility:(id)sender; // (9)
- (void)logOutButtonClicked;
@end
