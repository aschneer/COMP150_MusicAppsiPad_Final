//
//  MIKMIDIMetaLyricEvent.h
//  MIDI Files Testbed
//
//  Created by Jake Gundersen on 5/22/14.
//  Copyright (c) 2014 Mixed In Key. All rights reserved.
//

#import "MIKMIDIMetaTextEvent.h"

/**
 *  A meta event containing lyrics.
 */
@interface MIKMIDIMetaLyricEvent : MIKMIDIMetaTextEvent

@end

/**
 *  The mutable counterpart of MIKMIDIMetaLyricEvent.
 */
@interface MIKMutableMIDIMetaLyricEvent : MIKMIDIMetaLyricEvent

@end
