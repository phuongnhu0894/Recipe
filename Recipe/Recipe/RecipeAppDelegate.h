//
//  CustomTableAppDelegate.h
//  CustomTable
//
//  Created by Phuong on 1/15/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "RECommonFunctions.h"
#import "UIViewController+RESideMenu.h"
#import "RECommonFunctions.h"


@interface RecipeAppDelegate : UIResponder <UIApplicationDelegate, RESideMenuDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
