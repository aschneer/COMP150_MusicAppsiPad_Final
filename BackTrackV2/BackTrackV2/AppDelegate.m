//
//  AppDelegate.m
//  BackTrackV2
//
//  Created by Jacob Apkon on 3/27/15.
//  Copyright (c) 2015 COMP150. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
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
    
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Turn off the audio controller, and close the PD file
    _audioController.active = NO;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    _audioController.active = YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {}

@end
