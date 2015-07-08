//
//  EntryHistoryTableViewCell.h
//  Today
//
//  Copyright (c) 2015 zachbrass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EntryHistoryTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *dayOfWeekLabel;
@property (nonatomic, weak) IBOutlet UILabel *dayOfMonthLabel;
@property (nonatomic, weak) IBOutlet UIView *dateView;
@property (nonatomic, weak) IBOutlet UILabel *entryTextLabel;
@property (nonatomic, weak) IBOutlet UILabel *moodLabel;
@property (nonatomic, weak) IBOutlet UILabel *weatherLabel;
- (void)setDate:(NSDate *)date;
@end
