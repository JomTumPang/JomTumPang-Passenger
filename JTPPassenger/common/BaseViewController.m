//
//  BaseViewController.m
//  DentalCare
//
//  Created by Venkat on 06/01/17.
//  Copyright © 2017 Bala. All rights reserved.
//

#import "BaseViewController.h"
#import "Constants.h"
#import "Utils.h"

@interface BaseViewController ()
{
//    UIActivityIndicatorView *activityView;
}
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    [[self.view viewWithTag:100001] setHidden:true];
    /*UIActivityIndicatorView *activity = (UIActivityIndicatorView *)[self.view viewWithTag:100000];
    if(activity != nil)
    {
        activity.hidden = TRUE;
        activity.bounds = self.view.bounds;
        [activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    }*/
//    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    activityView.center=self.view.center;
//    activityView.bounds = self.view.bounds;
//    activityView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];;
    
//    self.view.backgroundColor = THEAMBACKGROUND_COLOR;

}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (BOOL) validateScreen
{
    return TRUE;
}
/*
-(void)showActivityIndicator:(BOOL)show
{
    UIActivityIndicatorView *activity = (UIActivityIndicatorView *)[self.view viewWithTag:100000];
    if (activity == nil)
        return;
    if(show)
    {
        activity.hidden = FALSE;
        [activityView startAnimating];
//        [self.view addSubview:activityView];
        [self.view bringSubviewToFront:activityView];
    }else
    {
        [activityView stopAnimating];
        activity.hidden = TRUE;
//        [activityView removeFromSuperview];
    }
}*/
- (void)showActivityIndicator:(BOOL)show
{
    UIView *activityView = [self.view viewWithTag:100001];
    [activityView setHidden:show];
    
    if(show)
    {
        [self.view bringSubviewToFront:activityView];
    }else
    {
        [self.view sendSubviewToBack:activityView];
    }
}
-(void) showErrorMessage:(NSDictionary *)errorInfo
{
    NSString *errorCode     = errorInfo[@"errorCode"];
    NSString *errorMessage  = errorInfo[@"errorMsg"];
    if([Utils isObject:errorCode] && [errorCode length] > 0 )
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error Occured" message:[NSString stringWithFormat:@"%@\n%@", errorCode, errorMessage] preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alertController animated:YES completion:nil];
        });
    }
}
@end
