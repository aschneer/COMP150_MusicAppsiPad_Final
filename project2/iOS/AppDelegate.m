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

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSURL *jsCodeLocation;

    // Loading JavaScript code - uncomment the one you want.

    // OPTION 1
    // Load from development server. Start the server from the repository root:
    //
    // $ npm start
    //
    // To run on device, change `localhost` to the IP address of your computer, and make sure your computer and
    // iOS device are on the same Wi-Fi network.
    jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle"];

    // OPTION 2
    // Load from pre-bundled file on disk. To re-generate the static bundle, run
    //
    // $ curl http://localhost:8081/index.ios.bundle -o main.jsbundle
    //
    // and uncomment the next following line
    // jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];

    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                      moduleName:@"project2"
                                                   launchOptions:launchOptions];

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIViewController *rootViewController = [[UIViewController alloc] init];
    rootViewController.view = rootView;
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];
   
    // Initialize the audio controller for Core Audio integration
    _audioController = [PdAudioController new];
    if ([_audioController configureAmbientWithSampleRate:44100
                                          numberChannels:2
                                           mixingEnabled:YES] != PdAudioOK) {
        NSLog(@"Could not initialize Audio Controller");
    }
    
    // Dispatcher listens for messages from Pure Data
    PdDispatcher *dispatcher = [PdDispatcher new];
    [PdBase setDelegate:dispatcher];
    
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Turn off the audio controller, and close the PD file
    _audioController.active = NO;
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    _audioController.active = YES;
}

@end
