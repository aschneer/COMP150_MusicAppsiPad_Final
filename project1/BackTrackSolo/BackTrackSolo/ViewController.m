//
//  ViewController.m
//  BackTrackSolo
//
//  Created by Jacob Apkon on 2/16/15.
//  Copyright (c) 2015 COMP150. All rights reserved.
//

#import "ViewController.h"
#import "BackTrackSolo-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // dispatcher is for receiving messages from PD
    //PdDispatcher *dispatcher = (PdDispatcher *)[PdBase delegate];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)sendVolume:(UISlider *)sender {
    NSLog(@"%f", self.volumeSlider.value);
    [PdBase sendFloat:self.volumeSlider.value toReceiver:@"$0-volume"];
}
- (IBAction)sendTempo:(UISlider *)sender {
    [PdBase sendFloat:self.tempoSlider.value toReceiver:@"$0-metro"];
}
@end
