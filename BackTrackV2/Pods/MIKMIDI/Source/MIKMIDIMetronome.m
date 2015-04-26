//
//  MIKMIDIMetronome.m
//  MIKMIDI
//
//  Created by Chris Flesner on 11/24/14.
//  Copyright (c) 2014 Mixed In Key. All rights reserved.
//

#import "MIKMIDIMetronome.h"
#import "MIKMIDINoteEvent.h"

#if !__has_feature(objc_arc)
#error MIKMIDIMetronome.m must be compiled with ARC. Either turn on ARC for the project or set the -fobjc-arc flag for MIKMIDIMappingManager.m in the Build Phases for this target
#endif

@interface MIKMIDIEndpointSynthesizer (Protected)

- (BOOL)sendBankSelectAndProgramChangeForInstrumentID:(MusicDeviceInstrumentID)instrumentID error:(NSError **)error;

@end

@implementation MIKMIDIMetronome

#if TARGET_OS_IPHONE && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
+ (AudioComponentDescription)appleSynthComponentDescription
{
	AudioComponentDescription instrumentcd = (AudioComponentDescription){0};
	instrumentcd.componentManufacturer = kAudioUnitManufacturer_Apple;
	instrumentcd.componentType = kAudioUnitType_MusicDevice;
	instrumentcd.componentSubType = kAudioUnitSubType_MIDISynth;
	return instrumentcd;
}
#endif

- (BOOL)setupMetronome
{
	self.tickMessage = (MIDINoteMessage){ .channel = 0, .note = 57, .velocity = 127, .duration = 0.5, .releaseVelocity = 0 };
	self.tockMessage = (MIDINoteMessage){ .channel = 0, .note = 56, .velocity = 127, .duration = 0.5, .releaseVelocity = 0 };

	NSError *error = nil;
	if (![self sendBankSelectAndProgramChangeForInstrumentID:7864376 error:&error]) {
		NSLog(@"Unable to set up MIKMIDIMetronome (%@): %@", self, error);
		return NO;
	}
	return YES;
}

- (instancetype)init
{
	if (self = [super init]) {
		if (![self setupMetronome]) return nil;
	}
	return self;
}

- (instancetype)initWithClientDestinationEndpoint:(MIKMIDIClientDestinationEndpoint *)destination componentDescription:(AudioComponentDescription)componentDescription
{
	if (self = [super initWithClientDestinationEndpoint:destination componentDescription:componentDescription]) {
		if (![self setupMetronome]) return nil;
	}
	return self;
}

- (instancetype)initWithMIDISource:(MIKMIDISourceEndpoint *)source componentDescription:(AudioComponentDescription)componentDescription
{
	if (self = [super initWithMIDISource:source componentDescription:componentDescription]) {
		if (![self setupMetronome]) return nil;
	}
	return self;
}

@end
