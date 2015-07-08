//
//  Entry.h
//  Today
//
//  Copyright (c) 2015 zachbrass. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entry : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * entryText;
@property (nonatomic, retain) NSNumber * moodIndex;
@property (nonatomic, retain) NSString * weatherCharacter;

@end
