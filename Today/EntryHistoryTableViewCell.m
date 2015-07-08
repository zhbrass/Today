//
//  EntryHistoryTableViewCell.m
//  Today
//
//  Copyright (c) 2015 zachbrass. All rights reserved.
//

#import "EntryHistoryTableViewCell.h"
@interface EntryHistoryTableViewCell ()
@property (nonatomic, strong) NSDateFormatter *dayOfWeekFormatter;
@property (nonatomic, strong) NSDateFormatter *dayOfMonthFormatter;

@end
@implementation EntryHistoryTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.dayOfWeekFormatter = [[NSDateFormatter alloc] init];
    self.dayOfWeekFormatter.dateFormat = @"ccc";
    self.dayOfMonthFormatter = [[NSDateFormatter alloc] init];
    self.dayOfMonthFormatter.dateFormat = @"d";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setDate:(NSDate *)date{
    self.dayOfWeekLabel.text = [[self.dayOfWeekFormatter stringFromDate:date] uppercaseStringWithLocale:[NSLocale currentLocale]];
    self.dayOfMonthLabel.text = [self.dayOfMonthFormatter stringFromDate:date];
    
}
@end
