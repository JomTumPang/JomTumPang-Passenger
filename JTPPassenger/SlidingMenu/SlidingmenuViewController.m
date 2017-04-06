//
//  SlidingmenuViewController.m
//  JomTumpang
//
//  Created by Venkat on 09/01/17.
//  Copyright © 2017 ezrider. All rights reserved.
//
#define kExposedWidth 200.0
#define kProfilePicHeight 82.0
#define kProfilePicWidth 82.0
#define kMenuCellID @"MenuCell"

#import "SlidingmenuViewController.h"

@interface SlidingmenuViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *menu;
@property (nonatomic, strong) NSArray *viewControllers;
@property (nonatomic, strong) NSArray *menuTitles;
@property (nonatomic, strong) UIImageView *profileView;


@property (nonatomic, assign) NSInteger indexOfVisibleController;

@property (nonatomic, assign) BOOL isMenuVisible;
@end

@implementation SlidingmenuViewController

- (id)initWithViewControllers:(NSArray *)viewControllers andMenuTitles:(NSArray *)menuTitles
{
    if (self = [super init])
    {
        NSAssert(self.viewControllers.count == self.menuTitles.count, @"There must be one and only one menu title corresponding to every view controller!");    // (1)
        NSMutableArray *tempVCs = [NSMutableArray arrayWithCapacity:viewControllers.count];
        
        self.menuTitles = [menuTitles copy];
        
        for (UIViewController *vc in viewControllers) // (2)
        {
            if (![vc isMemberOfClass:[UINavigationController class]])
            {
                [tempVCs addObject:[[UINavigationController alloc] initWithRootViewController:vc]];
                
            }
            else
                [tempVCs addObject:vc];
            
//            UIBarButtonItem *revealMenuBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(toggleMenuVisibility:)]; // (3)
            
//            [tempVCs.lastObject navigationController].navigationBar.items = @[revealMenuBarButtonItem];
//            UIViewController *topVC = ((UINavigationController *)tempVCs.lastObject).topViewController;
//            topVC.navigationItem.rightBarButtonItem = revealMenuBarButtonItem;//@[revealMenuBarButtonItem];//[@[revealMenuBarButtonItem] arrayByAddingObjectsFromArray:topVC.navigationItem.rightBarButtonItem];
            
            
        }
        self.viewControllers = [tempVCs copy];
        self.menu = [[UITableView alloc] init]; // (4)
        self.menu.delegate = self;
        self.menu.dataSource = self;
        
        self.profileView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Profile.png"]];
        
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setHidesBackButton:YES];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.menu registerClass:[UITableViewCell class] forCellReuseIdentifier:kMenuCellID];
    self.menu.frame = self.view.bounds;
    [self.view addSubview:self.menu];
    
    self.indexOfVisibleController = 0;
    UIViewController *visibleViewController = self.viewControllers[0];
    visibleViewController.view.frame = [self offScreenFrame];
    [self addChildViewController:visibleViewController]; // (5)
    [self.view addSubview:visibleViewController.view]; // (6)
    self.isMenuVisible = FALSE;
    [self adjustContentFrameAccordingToMenuVisibility]; // (7)
    
    
    [self.viewControllers[0] didMoveToParentViewController:self]; // (8)
    
    
}
- (void)setNavigationTitle:(NSString *)title
{
    self.navigationController.title = title;
}
- (void)toggleMenuVisibility:(id)sender // (9)
{
    self.isMenuVisible = !self.isMenuVisible;
    [self adjustContentFrameAccordingToMenuVisibility];
}

- (void)logOutButtonClicked
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController popToRootViewControllerAnimated:YES];
    });
}
- (void)adjustContentFrameAccordingToMenuVisibility // (10)
{
    UIViewController *visibleViewController = self.viewControllers[self.indexOfVisibleController];
    CGSize size = visibleViewController.view.frame.size;
    
    if (self.isMenuVisible)
    {
        [UIView animateWithDuration:0.5 animations:^{
            visibleViewController.view.frame = CGRectMake(kExposedWidth, 0, size.width, size.height);
        }];
    }
    else
        [UIView animateWithDuration:0.5 animations:^{
            visibleViewController.view.frame = CGRectMake(0, 0, size.width, size.height);
        }];
    
}

- (void)replaceVisibleViewControllerWithViewControllerAtIndex:(NSInteger)index // (11)
{
    if (index == self.indexOfVisibleController) return;
    UIViewController *incomingViewController = self.viewControllers[index];
    incomingViewController.view.frame = [self offScreenFrame];
    UIViewController *outgoingViewController = self.viewControllers[self.indexOfVisibleController];
    CGRect visibleFrame = self.view.bounds;
    
    
    [outgoingViewController willMoveToParentViewController:nil]; // (12)
    
    [self addChildViewController:incomingViewController]; // (13)
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents]; // (14)
    [self transitionFromViewController:outgoingViewController // (15)
                      toViewController:incomingViewController
                              duration:0.5 options:0
                            animations:^{
                                outgoingViewController.view.frame = [self offScreenFrame];
                                
                            }
     
                            completion:^(BOOL finished) {
                                [UIView animateWithDuration:0.5
                                                 animations:^{
                                                     [outgoingViewController.view removeFromSuperview];
                                                     [self.view addSubview:incomingViewController.view];
                                                     incomingViewController.view.frame = visibleFrame;
                                                     [[UIApplication sharedApplication] endIgnoringInteractionEvents]; // (16)
                                                 }];
                                [incomingViewController didMoveToParentViewController:self]; // (17)
                                [outgoingViewController removeFromParentViewController]; // (18)
                                self.isMenuVisible = NO;
                                self.indexOfVisibleController = index;
                            }];
}


// (19):

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMenuCellID];
    cell.textLabel.text = self.menuTitles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self replaceVisibleViewControllerWithViewControllerAtIndex:indexPath.row];
}

- (CGRect)offScreenFrame
{
    return CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kProfilePicHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *profilePic = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user@2x.png"]];
    profilePic.frame = CGRectMake(self.menu.frame.origin.x, self.menu.frame.origin.y, kProfilePicWidth, kProfilePicHeight);
    [profilePic setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [profilePic setContentMode:UIViewContentModeScaleAspectFit|UIViewContentModeLeft];
    return profilePic;
}
@end
