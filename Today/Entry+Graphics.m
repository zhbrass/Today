//
//  Entry+Graphics.m
//  Today
//
//  Copyright (c) 2015 zachbrass. All rights reserved.
//

#import "Entry+Graphics.h"

@implementation Entry (Graphics)

// Valid moods are 1-indexed because nobody asks a
// non-engineer "On a scale of 0-4, how do you feel?"
- (NSString *)emojiForMood{
    switch (self.moodIndex.integerValue) {
        case 1:
            return @"😞";
            break;
        case 2:
            return @"😕";
            break;
        case 3:
            return @"😐";
            break;
        case 4:
            return @"😊";
            break;
        case 5:
            return @"😄";
            break;
        default:
            break;
    }
    return nil;
}

@end
