/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "AppDelegate.h"

#import "RCTRootView.h"

#import <Parse/Parse.h>

#import <Tapjoy/Tapjoy.h>

@implementation AppDelegate

-(void)tjcConnectSuccess:(NSNotification*)notifyObj{NSLog(@"Tapjoy connect Succeeded");}
-(void)tjcConnectFail:(NSNotification*)notifyObj{NSLog(@"Tapjoy connect Failed");}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
  [Tapjoy setDeviceToken:deviceToken];
  
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  /////////////////////
  // Parse
  /////////////////////
  
  // Initialize Parse.
  [Parse setApplicationId:@"JQW7bTJJdThVqIRtJdB4hlW63otAOYkQd9siQT6D"
                clientKey:@"AzS2EWeWEr0Jzf4tMzNubk2P4nlwzM6dtC8eefrw"];
  
  // [Optional] Track statistics around application opens.
  [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
  
  
  /////////////////////
  // Tapjoy
  /////////////////////
  
  //Set up success and failure notifications
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(tjcConnectSuccess:)
                                               name:TJC_CONNECT_SUCCESS
                                             object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(tjcConnectFail:)
                                               name:TJC_CONNECT_FAILED
                                             object:nil];
  //Turn on Tapjoy debug mode
  
  [Tapjoy setDebugEnabled:YES]; //Do not set this for any version of the game released to an app store!
  //The Tapjoy connect call
  [Tapjoy connect:@"7ukbDPNUR9CMYEUVUF8DbAEBTFycuYcBUx2WDuSVtge8c-5uj5O0bKbTqADK"];
  
  //If you are not using Tapjoy Managed currency, you would set your own user ID here.
  //[Tapjoy setUserID:@"A_UNIQUE_USER_ID"];
  
  [Tapjoy setApplicationLaunchingOptions:launchOptions];
  
  //-- Set Notification
  if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
  {
    // iOS 8 Notifications
    [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
    
    [application registerForRemoteNotifications];
  }
  else
  {
    // iOS < 8 Notifications
    [application registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
  }
  
  
  /////////////////////
  // React Native
  /////////////////////
  
  NSURL *jsCodeLocation;

  // Loading JavaScript code - uncomment the one you want.

  // OPTION 1
  // Load from development server. Start the server from the repository root:
  //
  // $ npm start
  //
  // To run on device, change `localhost` to the IP address of your computer, and make sure your computer and
  // iOS device are on the same Wi-Fi network.
  // jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle"];

  // OPTION 2
  // Load from pre-bundled file on disk. To re-generate the static bundle, run
  //
  // $ curl http://localhost:8081/index.ios.bundle -o main.jsbundle
  //
  // and uncomment the next following line
  jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];

  RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                      moduleName:@"Pebbles"
                                                   launchOptions:launchOptions];

  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  UIViewController *rootViewController = [[UIViewController alloc] init];
  rootViewController.view = rootView;
  self.window.rootViewController = rootViewController;
  [self.window makeKeyAndVisible];
  return YES;
}

- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo {
  
  [Tapjoy setReceiveRemoteNotification:userInfo];
  
}

@end
