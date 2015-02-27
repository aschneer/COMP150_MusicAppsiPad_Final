//
//  ViewController.h
//  BackTrackSolo
//
//  Created by Jacob Apkon on 2/16/15.
//  Copyright (c) 2015 COMP150. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PdDispatcher.h"


@interface ViewController : UIViewController

- (IBAction)sendVolume:(UISlider *)sender;
@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;

- (IBAction)sendTempo:(UISlider *)sender;
@property (weak, nonatomic) IBOutlet UISlider *tempoSlider;




@end

