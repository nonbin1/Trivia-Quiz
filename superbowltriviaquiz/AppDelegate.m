//
//  AppDelegate.m
//  superbowltriviaquiz
//
//  Created by Panasun on 5/23/2557 BE.
//  Copyright (c) 2557 Flutx. All rights reserved.
//

#import "AppDelegate.h"
#import "iRate.h"

@implementation AppDelegate

+ (void)initialize
{
    //configure iRate
    [iRate sharedInstance].daysUntilPrompt = 5;
    [iRate sharedInstance].usesUntilPrompt = 15;
    
    /*
    [iRate sharedInstance].previewMode = YES;
    [iRate sharedInstance].messageTitle = NSLocalizedString(@"Rate MyApp", @"iRate message title");
    [iRate sharedInstance].message = NSLocalizedString(@"If you like MyApp, please take the time, etc", @"iRate message");
    [iRate sharedInstance].cancelButtonLabel = NSLocalizedString(@"No, Thanks", @"iRate decline button");
    [iRate sharedInstance].remindButtonLabel = NSLocalizedString(@"Remind Me Later", @"iRate remind button");
    [iRate sharedInstance].rateButtonLabel = NSLocalizedString(@"Rate It Now", @"iRate accept button");
     */
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    
    /*
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"MyAlertView"
                                                        message:@"Local notification was received"
                                                       delegate:self cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
    */
   
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
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

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
        
}
@end
