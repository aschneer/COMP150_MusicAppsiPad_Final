//
//  AppDelegate.m
//  Team3-Project1
//
//  Created by Jacob Apkon on 2/16/15.
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
    
    _patch = [PdBase openFile:@"../../../puredata/song_clock.pd"
                         path:[[NSBundle mainBundle] resourcePath]];
    
    if (!_patch) {
        NSLog(@"Patch didn't open");
    }
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    // Turn off the audio controller, and close the PD file
    _audioController.active = NO;
    [PdBase closeFile:_patch];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    _audioController.active = YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
