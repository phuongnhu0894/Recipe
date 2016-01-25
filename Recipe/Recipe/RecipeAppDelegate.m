//
//  CustomTableAppDelegate.m
//  CustomTable
//
//  Created by Phuong on 1/15/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

#import "RecipeAppDelegate.h"
#import "DEMOLeftMenuViewController.h"
#import "RecipeTableViewController.h"
#import "RESideMenu.h"
#import "RECommonFunctions.h"
#import "UIViewController+RESideMenu.h"
#import <sqlite3.h>

@implementation RecipeAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Function called to create a copy of the database if needed.
    // display launch screen in 1 sec
//    [NSThread sleepForTimeInterval:1.0];
    //set background image
    [self.window setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg"]]];
    UIImage *navigationImage = [UIImage imageNamed:@"navbar_bg"];
    [[UINavigationBar appearance] setBackgroundImage:navigationImage forBarMetrics:UIBarMetricsDefault];
    
    //set bar button image
    UIImage *backImage =[[UIImage imageNamed:@"button_back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 6)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    UIImage *barButtonImage = [[UIImage imageNamed:@"button_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 6, 0, 6)];
    [[UIBarButtonItem appearance] setBackgroundImage:barButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    

    NSShadow *shadow = [NSShadow new];
    [shadow setShadowColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8]];
    [shadow setShadowOffset:CGSizeMake(0, 1)];
    
    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName: [UIColor colorWithRed:220.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0],
                                 NSShadowAttributeName: shadow,
                                 NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0]
                                 };
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
//    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:attributes forState: UIControlStateNormal];
    
    // Or you can use.
    
    [[UIBarItem appearance] setTitleTextAttributes:attributes forState: UIControlStateNormal];
    
    [self createCopyOfDatabaseIfNeeded];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[RecipeTableViewController alloc] init]];
    DEMOLeftMenuViewController *leftMenuViewController = [[DEMOLeftMenuViewController alloc] init];
   
    
    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:navigationController
                                                                    leftMenuViewController:leftMenuViewController
                                                                   rightMenuViewController:nil];
    sideMenuViewController.backgroundImage = [UIImage imageNamed:@"Stars"];
    sideMenuViewController.menuPreferredStatusBarStyle = 1; // UIStatusBarStyleLightContent
    sideMenuViewController.delegate = self;
    sideMenuViewController.contentViewShadowColor = [UIColor blackColor];
    sideMenuViewController.contentViewShadowOffset = CGSizeMake(0, 0);
    sideMenuViewController.contentViewShadowOpacity = 0.6;
    sideMenuViewController.contentViewShadowRadius = 12;
    sideMenuViewController.contentViewShadowEnabled = YES;
    self.window.rootViewController = sideMenuViewController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark - Defined Functions

// Function to Create a writable copy of the bundled default database in the application Documents directory.
- (void)createCopyOfDatabaseIfNeeded {
    // First, test for existence.
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    // Database filename can have extension db/sqlite.
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appDBPath = [documentsDirectory stringByAppendingPathComponent:@"Recipe.sqlite"];
    
    success = [fileManager fileExistsAtPath:appDBPath];
    if (success) {
        return;
    }
    // The writable database does not exist, so copy the default to the appropriate location.
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Recipe.sqlite"];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:appDBPath error:&error];
    NSAssert(success, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
